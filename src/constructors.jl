ImPlotPoint() = ImPlotPoint(0, 0)
ImPlotPoint(p::ImVec2) = ImPlotPoint(p.x, p.y)
ImPlotRange() = ImPlotRange(0, 0)
ImPlotRect() = ImPlotRect(ImPlotRange(), ImPlotRange())
ImPlotRect(x1, x2, y1, y2) = ImPlotRect(ImPlotRange(x1, x2), ImPlotRange(y1, y2))

# ImPlotSpec: keyword constructor whose defaults come from the actual linked implot
const _IMPLOTSPEC_DEFAULTS = Ref{ImPlotSpec}()
function __init__()
    p = ImPlotSpec_ImPlotSpec()          # heap-allocates and runs the C++ default constructor
    _IMPLOTSPEC_DEFAULTS[] = unsafe_load(p)
    ImPlotSpec_destroy(p)
end
ImPlotSpec(; kwargs...) = setproperties(_IMPLOTSPEC_DEFAULTS[]; kwargs...)

# Data coercion: the low-level ccall needs a dense, unit-stride buffer of a natively-supported eltype.
# Dense supported arrays pass through zero-copy; ranges / non-contiguous views are materialized;
# unsupported eltypes are converted to Float64 (broadcast, which also materializes).
_coerce(a::DenseArray{<:ImPlotData}) = a
_coerce(a::AbstractArray{<:ImPlotData}) = collect(a)
_coerce(a::AbstractArray{<:Real}) = collect(Float64, a)
# Multiple arrays must share one C eltype `T`: pick the common natively-supported eltype and
# coerce each to a dense Array{T} (zero-copy when already a dense T array; ranges/views materialized).
function _coerce(a::AbstractArray{<:Real}, b::AbstractArray{<:Real}, rest::AbstractArray{<:Real}...)
    arrs = (a, b, rest...)
    T0 = Base.promote_eltype(arrs...)
    T = T0 <: ImPlotData ? T0 : Float64
    return map(x -> x isa DenseArray{T} ? x : convert(Array{T}, x), arrs)
end

# Shared array-of-structs field extraction (fail-loud); used by PlotLine/PlotScatter/PlotStairs/PlotDigital/PlotShaded.
# `extra...` are positional args (e.g. PlotShaded's y_ref) inserted between count and spec in the low-level call.
function _plot_structfields(plotfn, label_id, data::AbstractVector{S}, xfield::Symbol, yfield::Symbol, spec::ImPlotSpec, extra...) where {S}
    if !(data isa DenseArray)
        throw(ArgumentError("$plotfn struct-field extraction needs a dense vector (got $(typeof(data))); collect it first"))
    end
    if !isbitstype(S)
        throw(ArgumentError("$plotfn struct-field extraction needs an isbits element type, got $S"))
    end
    Tx, Ty = fieldtype(S, xfield), fieldtype(S, yfield)
    if !(Tx === Ty && Tx <: ImPlotData)
        throw(ArgumentError("$plotfn: fields :$xfield, :$yfield must share a natively-supported type (got $Tx, $Ty)"))
    end
    GC.@preserve data begin
        base = pointer(data)
        xptr = Ptr{Tx}(base + fieldoffset(S, Base.fieldindex(S, xfield)))
        yptr = Ptr{Ty}(base + fieldoffset(S, Base.fieldindex(S, yfield)))
        return plotfn(label_id, xptr, yptr, length(data), extra..., setproperties(spec; Stride=sizeof(S)))
    end
end
