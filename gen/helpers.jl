# Generic trait checks
is_imgui_struct(x) = x.stname !== ""
isdestructor(x) = hasproperty(x, :destructor)
isconstructor(x) = hasproperty(x, :constructor)

# Functions with pointer as first argument return
hasoutputarg(x) = hasproperty(x, :nonUDT)

#ImPlot specific
isplotfunction(x) = startswith(x.funcname, "Plot") && !startswith(x.funcname, "PlotToPixels")

hasdefault(metadata, sym) = hasproperty(metadata.defaults, sym)
getdefault(metadata, sym) = getproperty(metadata.defaults, sym)
get_jl_type(argtype) = argtype ∈ IMDATATYPES ? IMTOJL_LOOKUP[argtype] : argtype

function read_metadata()
    json_enums = read(CImGuiPack_jll.cimplot_structs_and_enums, String);
    json_defs = read(CImGuiPack_jll.cimplot_definitions, String);
    #json_typedefs = read(joinpath(METADATA_DIR, "typedefs_dict.json"), String);
    enums = JSON3.read(json_enums);
    #types = JSON3.read(json_typedefs);
    FUNCTION_METADATA = JSON3.read(json_defs);
    ENUMS = Symbol.(chop.(string.(propertynames(enums.enums))))
    return FUNCTION_METADATA, ENUMS
end

# Check if originally from implot_internal.h; this filters most internal functions
function internal_check(x)
    if hasproperty(x, :location)
        startswith(x.location, "implot_internal") && return true
    end
    return false
end

function split_ccall(body)
    local funsymbol, rettype, argtypes, argnames
    for ex in body.args
        @capture(ex, ccall((funsymbol_, libcimgui), rettype_, (argtypes__,), argnames__)) && break
    end
    return (funsymbol, rettype, argtypes, argnames)
end

function parse_default(jlsymtype, str, ptr_type = nothing)
    T = eval(jlsymtype)
    if str == "((void*)0)" || str == "NULL" || str == "nullptr"
        return :C_NULL
    end
    (T <: AbstractFloat || T <: Bool || T <: Cstring) && return Meta.parse(str)
    T <: Integer && return (startswith(str, "sizeof") ? :(sizeof($ptr_type)) : Meta.parse(str))
    T <: Symbol && return Symbol(str)
    return @warn "Not parsing default value of: $str"
end

function revise_arg(def, metadata, i, sym, jltype, ptr_type = nothing)
    if jltype ∈ (:Cint, :Clong, :Cshort, :Cushort, :Culong, :Cuchar, :Cchar,
                 :Int8, :UInt8, :Int16, :UInt16, :Int32, :UInt32, :Int64, :UInt64)
        if hasdefault(metadata, sym)
            val = parse_default(jltype, getdefault(metadata, sym), ptr_type)
            def[:args][i] = :($( Expr(:kw, :($sym::Integer), val)) )
        else
            def[:args][i] = :($sym::Integer)
        end
        return
    elseif jltype ∈ (:Cfloat, :Cdouble, :Float64, :Float32)
        if hasdefault(metadata, sym)
            val = parse_default(jltype, getdefault(metadata,sym), ptr_type)
            def[:args][i] = :($( Expr(:kw, :($sym::Real), val)) )
        else
            def[:args][i] = :($sym::Real)
        end
        return
    elseif jltype ∈ (:Cstring,:Bool)
        # Don't annotate strings--we want option to pass C_NULL
        # Don't annotate Bool, we want option to pass 0 or 1
        if hasdefault(metadata, sym)
            val = parse_default(jltype, getdefault(metadata, sym), ptr_type)
            def[:args][i] = :($(Expr(:kw, sym, val)))
        end
        return
    elseif startswith(string(jltype), "Im") # Heuristic for imgui types
        if hasdefault(metadata, sym)
            raw_val = getdefault(metadata,sym)
            if  raw_val == "((void*)0)"
                val = :C_NULL
                def[:args][i] = :($(Expr(:kw, sym, val)) )
                return
            elseif startswith(raw_val, "Im")
                if jltype in IMGUI_ISBITS_TYPES
                    def[:args][i] = :($(Expr(:kw, :($sym::$jltype), Meta.parse(raw_val))))
                else
                    def[:args][i] = :($(Expr(:kw, sym, Meta.parse(raw_val))))
                end
                return
            elseif jltype in ENUMS
                def[:args][i] = :($(Expr(:kw, :($sym::Union{$(Symbol(string(jltype)*"_")),Integer}), Meta.parse(raw_val))))
                return
            else
                def[:args][i] = :($(Expr(:kw, sym, Meta.parse(raw_val))))
                return
            end
        elseif jltype in ENUMS
            def[:args][i] = :($sym::Union{$(Symbol(string(jltype)*"_")),Integer})
            return
        else
            def[:args][i] = :($sym::$jltype)
            return
        end
    elseif @capture(jltype, Ptr{ptrtype_}) # if pointer argument + capture eltype
        if hasdefault(metadata, sym)
            raw_val = getdefault(metadata,sym)
            if raw_val !== "((void*)0)" && endswith(raw_val, r"\(.+\)")
                rx = match(r"\(.+\)",raw_val)
                tupex = Meta.parse(rx.match)
                def[:args][i] = :($(Expr(:kw,
                                         :($sym::Union{$ptrtype,AbstractArray{$ptrtype}}), :($ptrtype($(tupex.args...))))))
            end
        elseif ptrtype == :Cstring
            def[:args][i] = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
        elseif ptrtype == :Cvoid
            return
        else
            def[:args][i] = :($sym::Union{$ptrtype,AbstractArray{$ptrtype}})
        end
        return
    end
    @info "Not processing argument: $sym::$jltype from $(def[:name])"
    return
end

function generate_plotmethod(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    datatype = :notparsed
    for (i, argtype) in enumerate(argtypes)
        sym = argnames[i]
        jltype = get_jl_type(argtype)
        if @capture(jltype, Ptr{ptrtype_}) && ptrtype ∈ IMDATATYPES
            datatype = ptrtype
            def[:args][i] = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
        else
            revise_arg(def, metadata, i, sym, jltype, datatype)
        end
    end
    def[:body] = Expr(:block,
                      :(ccall(($funsymbol, libcimgui), $rettype, ($(argtypes...),), $(argnames...))))
    return ExprTools.combinedef(def)
end

function make_finalizer!(def, metadata)
    def[:name] = :(Base.finalizer)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    argtype, argname = only(argtypes), only(argnames)
    @capture(argtype, Ptr{ptrtype_})
    def[:args] = [:($argname::Union{$argtype,$ptrtype})]
    new_ccall = :(ccall(($funsymbol, libcimgui), $rettype, ($argtype,), $argname))
    new_body = Expr(:block, :(ptr = pointer_from_objref($argname)), :(GC.@preserve $argname $new_ccall))
    def[:body] = MacroTools.prewalk(rmlines, new_body)
end

function make_constructor!(def, metadata)
    def[:name] = Symbol(metadata.stname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    new_ccall = :(ccall(($funsymbol, libcimgui), $rettype, ($(argtypes...),), $(argnames...)))
    def[:body] = Expr(:block, new_ccall)
end

function parse_pointer_arg!(jltype, def, metadata, sym, i)
    if @capture(jltype, Ptr{ptrtype_})
        if ptrtype in (IMDATATYPES..., :Cstring, :Bool)
            if ptrtype == :Cstring
                arg_type = :($sym::Union{Ptr{Nothing},String,AbstractArray{String}})
            elseif ptrtype == :Bool
                arg_type = def[:args][i] = :($sym)
            else
                arg_type = :($sym::Union{Ptr{$ptrtype},Ref{$ptrtype},AbstractArray{$ptrtype}})
            end

            if hasdefault(metadata, sym)
                val = parse_default(jltype, getdefault(metadata, sym), ptrtype)
                def[:args][i] = :($(Expr(:kw, arg_type, val)))
            else
                def[:args][i] = arg_type
            end

            return true
        elseif ptrtype ∉ vcat(IMGUI_ISBITS_TYPES, IMDATATYPES)
            return true
        end
    end
    return false
end

function make_objmethod!(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])

    # Handle the 'self' argument
    firstsym, firstargtype = first(argnames), first(argtypes)
    @capture(firstargtype, Ptr{ptr_type_})
    def[:args][1] = :($firstsym::Union{$ptr_type,$firstargtype,Ref{$ptr_type}})

    # parse remaining arguments
    for (i, argtype) in enumerate(argtypes)
        i == 1 && continue
        sym = argnames[i]
        jltype = get_jl_type(argtype)
        # Skip pointer types
        parse_pointer_arg!(jltype, def, metadata, sym, i) && continue
        revise_arg(def, metadata, i, sym, jltype)
    end
end

function generate_allocating(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    sym = popfirst!(def[:args])
    @capture(first(argtypes), Ptr{ptr_type_})
    argtypes[1] = :(Ref{$ptr_type})
    def[:body] = Expr(:block,
                      :($sym = Ref{$ptr_type}()),
                      :(ccall(($funsymbol, libcimgui), $rettype, ($(argtypes...),), $(argnames...))),
                      ptr_type in IMGUI_ISBITS_TYPES ? :($sym[]) : :($sym))

    for (i, argtype) in enumerate(argtypes)
        i == 1 && continue
        sym = argnames[i]
        jltype = get_jl_type(argtype)
        # Skip pointer types
        parse_pointer_arg!(jltype, def, metadata, sym, i) && continue
        revise_arg(def, metadata, i-1, sym, jltype) # offset bc we pop off first arg above
    end
    return ExprTools.combinedef(def)
end

function generate_generic(def, metadata)
    def[:name] = Symbol(metadata.funcname)
    (funsymbol, rettype, argtypes, argnames) = split_ccall(def[:body])
    def[:body] = Expr(:block,
                      :(ccall(($funsymbol, libcimgui), $rettype, ($(argtypes...),), $(argnames...))))

    for (i, argtype) in enumerate(argtypes)
        sym = argnames[i]
        jltype = get_jl_type(argtype)

        # Remove type annotations from functions labeled DESPECIALIZE
        if metadata.funcname in DESPECIALIZE
            def[:args][i] = :($sym)
            continue
        end

        parse_pointer_arg!(jltype, def, metadata, sym, i) && continue
        revise_arg(def, metadata, i, sym, jltype)
    end
    return ExprTools.combinedef(def)
end

function get_function_name(def)
    # Skip Expr function names (e.g. :(Base.getproperty))
    # FIXME: sometimes getting functors??!!
    def[:name] isa Symbol || return nothing
    return string(def[:name])
end

function find_function_metadata(fun_name, metadata)
    for object_vector in values(metadata), fun_meta in object_vector
        if fun_name == fun_meta.ov_cimguiname || fun_name == fun_meta.cimguiname
            return fun_meta
        end
    end
    return nothing
end

function filter_internal_functions!(options, metadata)
    for object_vector in values(metadata), object in object_vector
        if internal_check(object)
            push!(options["general"]["output_ignorelist"], object.ov_cimguiname)
        end
    end
end

# unused and untest--may need more work
function filter_internal_enums!(options, enums)
    for (obj, location) in enums.locations
        if contains(location, "internal")
            push!(options["general"]["output_ignorelist"], String(obj))
        end
    end
end

function generate_struct_function(def, metadata, old_ex)
    # Skip constructors/destructors for primitive types--we can handle these with Julia
    if metadata.stname ∉ String.(IMGUI_ISBITS_TYPES)
        if hasproperty(metadata, :destructor)
            make_finalizer!(def, metadata)
            return ExprTools.combinedef(def)
        elseif hasproperty(metadata, :constructor)
            # write contructor...
            make_constructor!(def, metadata)
            return ExprTools.combinedef(def)
        end
    end
    # Fall through to object method; skip destructors
    if !(isdestructor(metadata) || isconstructor(metadata))
        make_objmethod!(def,metadata)
        # Reconstitute function definition expression
        return ExprTools.combinedef(def)
    else
        return old_ex
    end
end

function create_docstring(func_name, metadata)
    docstring = ""

    comment = get(metadata, :comment, "")
    if !isempty(comment)
        comment = replace(comment, "\\0" => "\\\\0")
        formatted_comment = chopprefix(comment, "//") |> strip |> uppercasefirst
        if !isempty(formatted_comment) && formatted_comment[end] ∉ ('.', '!', '?')
            formatted_comment *= "."
        end

        docstring *= "\n\n$(formatted_comment)"
    end

    header, line = split(metadata[:location], ':')
    implot_version = "47522f47054d33178e7defa780042bd2a06b09f9"
    link = "https://github.com/epezent/implot/blob/$(implot_version)/$(header).h#L$(line)"

    docstring *= "[Upstream link]($link)."

    return docstring
end

function revise_function(ex::Expr, all_metadata, options, docstrings)
    # Destructure the function definition
    def = ExprTools.splitdef(ex)

    # Get & validate function name
    fun_name = get_function_name(def)
    isnothing(fun_name) && return ex

    metadata = find_function_metadata(fun_name, all_metadata)

    # Skip functions not in the JSON metadata
    if isnothing(metadata)
        @warn "Could not find function: $fun_name in JSON metadata"
        return ex
    end

    # Check if it's for a struct type
    ex = if is_imgui_struct(metadata)
        generate_struct_function(def, metadata, ex)
    elseif isplotfunction(metadata) # implot specific
        generate_plotmethod(def, metadata)
    elseif hasoutputarg(metadata) # generic
        generate_allocating(def, metadata)
    else
        generate_generic(def, metadata)
    end

    # Generate docstrings for everything but internal functions and destructors
    if !endswith(fun_name, "_destroy") && !internal_check(metadata)
        docstrings[fun_name] = create_docstring(fun_name, metadata)
    end

    return ex
end

function rewrite!(dag::ExprDAG, metadata, options, docstrings)
    for node in get_nodes(dag)
        expressions = get_exprs(node)
        for (i, expr) in enumerate(expressions)
            if Meta.isexpr(expr, :function)
                expressions[i] = revise_function(expr, metadata, options, docstrings)
            end
        end
    end
end
