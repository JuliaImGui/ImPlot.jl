# Digital signal plots
"""$(TYPEDSIGNATURES)"""
function PlotDigital(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotDigital: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotDigital(label_id, xc, yc, length(xc), spec)
end

"""$(TYPEDSIGNATURES)"""
PlotDigital(label_id, data::AbstractVector, xfield::Symbol, yfield::Symbol; spec::ImPlotSpec=ImPlotSpec()) =
    _plot_structfields(PlotDigital, label_id, data, xfield, yfield, spec)
