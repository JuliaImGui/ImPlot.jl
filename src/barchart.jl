# Bar charts. Horizontal via spec=ImPlotSpec(Flags=ImPlotBarsFlags_Horizontal); for a shifted group, shift x explicitly or use PlotBarGroups.
"""$(TYPEDSIGNATURES)"""
function PlotBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; bar_size::Real=0.67, spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotBars: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotBars(label_id, xc, yc, length(xc), Float64(bar_size), spec)
end
