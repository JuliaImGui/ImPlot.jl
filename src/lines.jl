# Line plots
"""$(TYPEDSIGNATURES)"""
function PlotLine(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotLine: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotLine(label_id, xc, yc, length(xc), spec)
end

"""$(TYPEDSIGNATURES)"""
function PlotLine(label_id, x::AbstractRange, y::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotLine: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    yc = _coerce(y)
    return PlotLine(label_id, yc, length(yc), Float64(step(x)), Float64(first(x)), spec)
end

"""$(TYPEDSIGNATURES)"""
PlotLine(label_id, y::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec()) =
    PlotLine(label_id, 0:length(y)-1, y; spec)

"""$(TYPEDSIGNATURES)"""
PlotLine(label_id, data::AbstractVector, xfield::Symbol, yfield::Symbol; spec::ImPlotSpec=ImPlotSpec()) =
    _plot_structfields(PlotLine, label_id, data, xfield, yfield, spec)
