# Generic trait checks
is_imgui_struct(x) = x.stname !== ""
isdestructor(x) = hasproperty(x, :destructor)
isconstructor(x) = hasproperty(x, :constructor)

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

const INTEGER_JLTYPES = (:Cint, :Clong, :Cshort, :Cushort, :Culong, :Cuchar, :Cchar,
                         :Int8, :UInt8, :Int16, :UInt16, :Int32, :UInt32, :Int64, :UInt64)
const REAL_JLTYPES = (:Cfloat, :Cdouble, :Float64, :Float32)

# Check if there is a width-only collision: ≥ 2 distinct numeric jltypes at this
# (funcname, position) across all C overloads. When such a collision exists we must
# emit a concrete numeric type at this argument so the generated Julia methods
# remain distinguishable.
function has_numeric_collision(overload_types_at, funcname, i, jltype)
    overload_types_at === nothing && return false
    types_here = get(overload_types_at, (String(funcname), i), nothing)
    types_here === nothing && return false
    if jltype ∈ INTEGER_JLTYPES
        return count(t -> t ∈ INTEGER_JLTYPES, types_here) > 1
    elseif jltype ∈ REAL_JLTYPES
        return count(t -> t ∈ REAL_JLTYPES, types_here) > 1
    end
    return false
end

function revise_arg(def, metadata, i, sym, jltype, ptr_type = nothing; overload_types_at = nothing)
    funcname_for_collision = hasproperty(metadata, :funcname) ? metadata.funcname : nothing
    if jltype ∈ INTEGER_JLTYPES
        target = (funcname_for_collision !== nothing &&
                  has_numeric_collision(overload_types_at, funcname_for_collision, i, jltype)) ? jltype : :Integer
        if hasdefault(metadata, sym)
            val = parse_default(jltype, getdefault(metadata, sym), ptr_type)
            def[:args][i] = :($( Expr(:kw, :($sym::$target), val)) )
        else
            def[:args][i] = :($sym::$target)
        end
        return
    elseif jltype ∈ REAL_JLTYPES
        target = (funcname_for_collision !== nothing &&
                  has_numeric_collision(overload_types_at, funcname_for_collision, i, jltype)) ? jltype : :Real
        if hasdefault(metadata, sym)
            val = parse_default(jltype, getdefault(metadata,sym), ptr_type)
            def[:args][i] = :($( Expr(:kw, :($sym::$target), val)) )
        else
            def[:args][i] = :($sym::$target)
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

function generate_plotmethod(def, metadata; overload_types_at = nothing)
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
            revise_arg(def, metadata, i, sym, jltype, datatype; overload_types_at)
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

function make_objmethod!(def, metadata; overload_types_at = nothing)
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
        revise_arg(def, metadata, i, sym, jltype; overload_types_at)
    end
end

function generate_generic(def, metadata; overload_types_at = nothing)
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
        revise_arg(def, metadata, i, sym, jltype; overload_types_at)
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

function generate_struct_function(def, metadata, old_ex; overload_types_at = nothing)
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
        make_objmethod!(def, metadata; overload_types_at)
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
    implot_version = "0.17"
    link = "https://github.com/epezent/implot/blob/$(implot_version)/$(header).h#L$(line)"

    docstring *= "[Upstream link]($link)."

    return docstring
end

function revise_function(ex::Expr, all_metadata, options, docstrings; overload_types_at = nothing)
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
    try
        ex = if is_imgui_struct(metadata)
            generate_struct_function(def, metadata, ex; overload_types_at)
        elseif isplotfunction(metadata) # implot specific
            generate_plotmethod(def, metadata; overload_types_at)
        else
            generate_generic(def, metadata; overload_types_at)
        end
    catch
        @error "Failed to wrap $(fun_name)"
        rethrow()
    end

    # Generate docstrings for everything but internal functions and destructors
    if !endswith(fun_name, "_destroy") && !internal_check(metadata)
        docstrings[fun_name] = create_docstring(fun_name, metadata)
    end

    return ex
end

function rewrite!(dag::ExprDAG, metadata, options, docstrings)
    # In newer versions of the cimgui bindings non-POD-types-that-look-like-POD-types-but-actually-aren't
    # are renamed to have a '_c' underscore. In the generated Julia bindings we
    # rename these back to their old names for the sake of convenience.
    # See: https://github.com/cimgui/cimgui/issues/309
    structs_and_enums = JSON3.read(getproperty(CImGuiPack_jll, :cimplot_structs_and_enums))
    nonpod_used = structs_and_enums[:nonPOD_used]
    new2old_names = Dict([Symbol(x, "_c") => x for x in keys(nonpod_used)])

    # Pass 1: collect, for each (funcname, arg_position), the set of jltypes that
    # `revise_arg` would see across all C overloads. Used downstream to detect
    # width-only collisions (e.g. ImPlotSpec_SetProp_{Float,double,S8,...,U64}),
    # which require concrete numeric types in the generated signatures.
    overload_types_at = Dict{Tuple{String,Int},Set{Symbol}}()
    for node in get_nodes(dag)
        for expr in get_exprs(node)
            Meta.isexpr(expr, :function) || continue
            local def
            try
                def = ExprTools.splitdef(expr)
            catch
                continue
            end
            fun_name = get_function_name(def)
            isnothing(fun_name) && continue
            fun_meta = find_function_metadata(fun_name, metadata)
            isnothing(fun_meta) && continue
            # Destructors and a handful of other metadata entries lack `funcname`.
            # Such functions are not routed through `revise_arg`, so we can skip them.
            hasproperty(fun_meta, :funcname) || continue
            (_, _, argtypes, _) = split_ccall(def[:body])
            argtypes === nothing && continue
            funcname = String(fun_meta.funcname)
            for (i, at) in enumerate(argtypes)
                jl = get_jl_type(at)
                # Only track jltypes as a Symbol; pointer/structured types are
                # not numeric-collision candidates so we still collect them but
                # they will simply never match the INTEGER/REAL numeric sets.
                jl_sym = jl isa Symbol ? jl : Symbol(string(jl))
                push!(get!(overload_types_at, (funcname, i), Set{Symbol}()), jl_sym)
            end
        end
    end

    # Pass 2: actual rewrite with collision info threaded through.
    for node in get_nodes(dag)
        expressions = get_exprs(node)
        for (i, expr) in enumerate(expressions)
            if Meta.isexpr(expr, :function)
                expressions[i] = revise_function(expr, metadata, options, docstrings; overload_types_at)
            end

            expressions[i] = postwalk(expressions[i]) do x
                if x isa Symbol && x in keys(new2old_names)
                    new2old_names[x]
                else
                    x
                end
            end
        end
    end
end
