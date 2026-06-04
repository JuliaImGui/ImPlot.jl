# Shaded plots: shade between the curve and a reference level (y_ref, default 0 = x-axis),
# or between two curves y1 and y2. (PlotShaded is y-only in implot 1.0 — no horizontal flag.)
"""$(TYPEDSIGNATURES)"""
function PlotShaded(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; y_ref::Real=0, spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotShaded: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotShaded(label_id, xc, yc, length(xc), Float64(y_ref), spec)
end

"""$(TYPEDSIGNATURES)"""
function PlotShaded(label_id, x::AbstractRange, y::AbstractArray{<:Real}; y_ref::Real=0, spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotShaded: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    yc = _coerce(y)
    return PlotShaded(label_id, yc, length(yc), Float64(y_ref), Float64(step(x)), Float64(first(x)), spec)
end

"""$(TYPEDSIGNATURES)"""
PlotShaded(label_id, y::AbstractArray{<:Real}; y_ref::Real=0, spec::ImPlotSpec=ImPlotSpec()) =
    PlotShaded(label_id, 0:length(y)-1, y; y_ref, spec)

"""$(TYPEDSIGNATURES)"""
function PlotShaded(label_id, x::AbstractArray{<:Real}, y1::AbstractArray{<:Real}, y2::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if !(length(x) == length(y1) == length(y2))
        throw(DimensionMismatch("PlotShaded: x/y1/y2 lengths differ ($(length(x)),$(length(y1)),$(length(y2)))"))
    end
    xc, y1c, y2c = _coerce(x, y1, y2)
    return PlotShaded(label_id, xc, y1c, y2c, length(xc), spec)
end

"""$(TYPEDSIGNATURES)"""
PlotShaded(label_id, data::AbstractVector, xfield::Symbol, yfield::Symbol; y_ref::Real=0, spec::ImPlotSpec=ImPlotSpec()) =
    _plot_structfields(PlotShaded, label_id, data, xfield, yfield, spec, Float64(y_ref))
