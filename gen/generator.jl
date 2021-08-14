
cd(@__DIR__)

using Clang.Generators
using ExprTools, MacroTools, JSON3, JuliaFormatter
# using ImPlot.LibCImPlot.CImPlot_jll
using CImGui.CImGui_jll

const CIMGUI_INCLUDE_DIR = joinpath(CImGui_jll.artifact_dir, "include")
const CIMPLOT_INCLUDE_DIR = @__DIR__
const CIMPLOT_H = normpath(@__DIR__, "cimplot_patched.h")

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
pushfirst!(args, "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS")
pushfirst!(args, "-isystem$CIMGUI_INCLUDE_DIR")
push!(args, "-I$CIMPLOT_INCLUDE_DIR")

# add definitions
@add_def ImVec2
@add_def ImVec4
@add_def ImGuiMouseButton
@add_def ImGuiKeyModFlags
@add_def ImS8 
@add_def ImU8
@add_def ImS16
@add_def ImU16
@add_def ImS32
@add_def ImU32
@add_def ImS64
@add_def ImU64
@add_def ImTextureID
@add_def ImGuiCond
@add_def ImGuiDragDropFlags
@add_def ImDrawList
@add_def ImGuiContext

imdatatypes = [:Cfloat, :Cdouble, :ImS8, :ImU8, :ImS16, :ImU16, :ImS32, :ImU32, :ImS64, :ImU64]
jldatatypes = [:Float32, :Float64, :Int8, :UInt8, :Int16, :UInt16, :Int32, :UInt32, :Int64, :UInt64] 
imtojl_lookup = Dict(zip(imdatatypes, jldatatypes))
const PRIMITIVE_TYPES = [:ImPlotPoint, :ImPlotRange, :ImVec2, :ImVec4, :ImPlotLimits]
ctx = create_context(CIMPLOT_H, args, options)
build!(ctx, BUILDSTAGE_NO_PRINTING)

json_defs = read("assets/definitions.json", String);
metadata = JSON3.read(json_defs);

json_enums = read("assets/structs_and_enums.json", String);
enums = JSON3.read(json_enums);
const ENUMS = Symbol.(chop.(string.(propertynames(enums.enums))))
const DESPECIALIZE = ["LinkNextPlotLimits"]

function split_ccall(body)
    local funsymbol, rettype, argtypes, argnames
    for ex in body.args
        @capture(ex, ccall((funsymbol_, libcimplot), rettype_, (argtypes__,), argnames__)) && break
    end
    return (funsymbol, rettype, argtypes, argnames)
end

function parse_default(T::DataType, str, ptr_type = :notparsed)
    str == "((void*)0)" && return :C_NULL
    T <: Integer && return (startswith(str, "sizeof") ? :(sizeof($ptr_type)) : Meta.parse(str))
    T <: AbstractFloat && return Meta.parse(str) 
    T <: Cstring && return Meta.parse(str)
    T <: Bool && return Meta.parse(str)
    T <: Symbol && return Symbol(str)
    return @warn "Not parsing default value of: $str"
end

function revise_arg(def, metadata, i, sym, jltype, ptr_type = :notparsed)
    if jltype ∈ (:Cint, :Clong, :Cshort, :Cushort, :Culong, :Cuchar, :Cchar)
        if hasproperty(metadata.defaults, sym)
            val = parse_default(eval(jltype), getproperty(metadata.defaults,sym), ptr_type)
            def[:args][i] = :($( Expr(:kw, :($sym::Integer), val)) )
        else
            def[:args][i] = :($sym::Integer) 
        end
        return
    elseif jltype ∈ (:Cfloat, :Cdouble, :Float64, :Float32)
        if hasproperty(metadata.defaults, sym)
            val = parse_default(eval(jltype), getproperty(metadata.defaults,sym))
            def[:args][i] = :($( Expr(:kw, :($sym::Real), val)) )
        else
            def[:args][i] = :($sym::Real)
        end
        return
    elseif jltype ∈ (:Cstring,:Bool)
        # Don't annotate string arguments--we want to be able to pass C_NULL
        if hasproperty(metadata.defaults, sym)
            val = parse_default(eval(jltype), getproperty(metadata.defaults, sym))
            def[:args][i] = :($(Expr(:kw, sym, val)))
        end

        return
    elseif startswith(string(jltype), "Im")
        if hasproperty(metadata.defaults, sym)
            raw_val = getproperty(metadata.defaults,sym)
            if startswith(raw_val, "Im")
                if jltype in PRIMITIVE_TYPES && endswith(raw_val, r"\(.+\)")
                    rx = match(r"\(.+\)",raw_val)
                    tupex = Meta.parse(rx.match)
                    def[:args][i] = :($( Expr(:kw, :($sym::$jltype), :($jltype($(tupex.args...))) )))
                else 
                    def[:args][i] =  :($( Expr(:kw, sym, :($(Symbol(raw_val))))) )
                end
            else
                val = raw_val == "((void*)0)" ? :C_NULL : Meta.parse(raw_val)
                def[:args][i] = :($( Expr(:kw, :($sym), val)) )
            end
            return
        elseif jltype in ENUMS
            def[:args][i] = :($sym)
            return
        else
            def[:args][i] = :($sym::$jltype)
            return
        end
    elseif @capture(jltype, Ptr{ptrtype_})
        if hasproperty(metadata.defaults, sym) && endswith(raw_val, r"\(.+\)")
                rx = match(r"\(.+\)",raw_val)
                tupex = Meta.parse(rx.match)
                def[:args][i] = :($(Expr(:kw, :($sym::Union{$ptrtype,AbstractArray{$ptrtype}}), :($ptrtype($(tupex.args...))))))
        elseif ptrtype == :Cstring
            def[:args][i] = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
        elseif ptrtype == :Cvoid
            return
        else
           def[:args][i] = :($sym::Union{$ptrtype,AbstractArray{$ptrtype}}) 
        end
        return
    end
        println("Not processing default value for: $sym from $(def[:name])")
        return
end

function make_plotmethod(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body]) 
    datatype = :notparsed
    for (i, argtype) in enumerate(argtypes)
        sym = argnames[i]
        jltype = argtype ∈ imdatatypes ? imtojl_lookup[argtype] : argtype
        if @capture(jltype, Ptr{ptrtype_}) && ptrtype ∈ imdatatypes
            datatype = ptrtype 
            def[:args][i] = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
        else
            revise_arg(def, metadata, i, sym, jltype, datatype)
        end
    end 
    def[:body] = Expr(:block, 
                      :(ccall(($funsymbol, libcimplot), $rettype, ($(argtypes...),), $(argnames...))))
end             

function make_finalizer!(def, metadata)
    def[:name] = :(Base.finalizer)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body]) 
    argtype, argname = only(argtypes), only(argnames)
    @capture(argtype, Ptr{ptrtype_})
    def[:args] = [:($argname::Union{$argtype,$ptrtype})]
    new_ccall = :(ccall(($funsymbol, libcimplot), $rettype, ($argtype,), $argname))
    new_body = Expr(:block, :(ptr = pointer_from_objref($argname)), :(GC.@preserve $argname $new_ccall))
    def[:body] = MacroTools.prewalk(rmlines, new_body)
end

function make_constructor!(def, metadata)
    def[:name] = Symbol(metadata.stname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    new_ccall = :(ccall(($funsymbol, libcimplot), $rettype, ($(argtypes...),), $(argnames...)))
    def[:body] = Expr(:block, new_ccall)
end

function make_objmethod!(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    sym, argtype = first(argnames), first(argtypes)
    @capture(argtype, Ptr{ptr_type_})
    def[:args][1] = :($sym::Union{$ptr_type,$argtype})
    for (i, argtype) in enumerate(argtypes)
        i == 1 && continue
        sym = argnames[i]
        jltype = argtype ∈ imdatatypes ? imtojl_lookup[argtype] : argtype
        # Skip pointer types
        if @capture(jltype, Ptr{ptrtype_})
            ptrtype ∉ vcat(PRIMITIVE_TYPES, imdatatypes) && continue
            if ptrtype in (imdatatypes..., :Cstring)
                if ptrtype == :Cstring
                    def[:args][i] = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
                else   
                    def[:args][i] = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
                end
                continue
            end
        end
        revise_arg(def, metadata, i, sym, jltype) # offset bc we pop off first arg above
     end  
end

function make_nonudt(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    sym = popfirst!(def[:args]) 
    @capture(first(argtypes), Ptr{ptr_type_})
    argtypes[1] = :(Ref{$ptr_type})
    def[:body] = Expr(:block,
                      :($sym = Ref{$ptr_type}()),
                      :(ccall(($funsymbol, libcimplot), $rettype, ($(argtypes...),), $(argnames...))),
                      ptr_type in PRIMITIVE_TYPES ? :($sym[]) : :($sym))
    
   for (i, argtype) in enumerate(argtypes)
       i == 1 && continue
       sym = argnames[i]
       jltype = argtype ∈ imdatatypes ? imtojl_lookup[argtype] : argtype
       # Skip pointer types
       if @capture(jltype, Ptr{ptrtype_})
            ptrtype ∉ vcat(PRIMITIVE_TYPES, imdatatypes) && continue
            if ptrtype in (imdatatypes..., :Cstring)
                if ptrtype == :Cstring
                    def[:args][i] = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
                else   
                    def[:args][i] = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
                end
                continue
            end
       end
       revise_arg(def, metadata, i-1, sym, jltype) # offset bc we pop off first arg above
    end  
end

function make_generic(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    def[:body] = Expr(:block,
                      :(ccall(($funsymbol, libcimplot), $rettype, ($(argtypes...),), $(argnames...))))
    for (i, argtype) in enumerate(argtypes)
        sym = argnames[i]
        jltype = argtype ∈ imdatatypes ? imtojl_lookup[argtype] : argtype

        # Remove all type annotations from marked functions
        if metadata.funcname in DESPECIALIZE
            def[:args][i] = :($sym)  
            continue
        end

        # Skip pointer types
        if @capture(jltype, Ptr{ptrtype_})
            ptrtype ∉ vcat(PRIMITIVE_TYPES, imdatatypes) && continue
            if ptrtype in (imdatatypes..., :Cstring)
                if ptrtype == :Cstring
                    def[:args][i] = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
                else   
                    def[:args][i] = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
                end
                continue
            end
        end
        revise_arg(def, metadata, i, sym, jltype)
   end
end

function revise_function(ex::Expr, all_metadata, options) 
    def = ExprTools.splitdef(ex)
    # Skip Expr function names (e.g. :(Base.getproperty))
    def[:name] isa Symbol || return ex
    fun_name = String(def[:name])
    # Skip functions not in the JSON metadata
    any(startswith.(fun_name,String.(propertynames(all_metadata)))) || return ex
    local metadata
    # Find and extract metadata for specific cimplot function
    for objfield in all_metadata
        objvec = objfield.second
        idx = findfirst(x -> isequal(x.ov_cimguiname, fun_name), objvec)
        if !isnothing(idx)
            metadata = objvec[idx]
            break
        end
    end
    @isdefined(metadata) || throw("Could not find cimgui function in JSON metadata")
    # Check if it's for a type
    if metadata.stname !== ""
        # Skip constructors/destructors for primitive types--we can handle these with Julia
        if metadata.stname ∉ String.(PRIMITIVE_TYPES)
            if hasproperty(metadata, :destructor)
                make_finalizer!(def, metadata)
                return ExprTools.combinedef(def)
            elseif hasproperty(metadata, :constructor)
                # write contructor...
                make_constructor!(def, metadata)
                return ExprTools.combinedef(def)
            end
        end
        # Fall through to object method
        if !(hasproperty(metadata, :destructor) || hasproperty(metadata, :constructor))
            make_objmethod!(def,metadata)
            return ExprTools.combinedef(def)
        else
            return ex
        end
    elseif startswith(metadata.funcname, "Plot") && !startswith(metadata.funcname, "PlotToPixels")
        # Since Plot functions are templated, dispatch on pointer (data input) arguments
        make_plotmethod(def, metadata)
        return ExprTools.combinedef(def)
    elseif hasproperty(metadata, :nonUDT)
        # Pop the pOut argument and insert a Ref creation and unload...
        make_nonudt(def, metadata)
        return ExprTools.combinedef(def)
    else
        make_generic(def, metadata)
        out = ExprTools.combinedef(def)
        return out
    end
    @warn "function $(def[:name]) not parsed"
        return ex
end

function rewrite!(dag::ExprDAG, metadata, options)
    for node in get_nodes(dag)
        expressions = get_exprs(node)
        for (i, expr) in enumerate(expressions)
            if Meta.isexpr(expr, :function)
                    expressions[i] = revise_function(expr, metadata, options)
            end
        end
    end
end

ctx = create_context(CIMPLOT_H, args, options)
build!(ctx, BUILDSTAGE_NO_PRINTING)
rewrite!(ctx.dag, metadata, options)
build!(ctx, BUILDSTAGE_PRINTING_ONLY)
#format(normpath(@__DIR__,"..","src"), YASStyle())

