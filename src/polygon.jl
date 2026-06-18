# Polygons (points in counter-clockwise order; closed automatically).
"""$(TYPEDSIGNATURES)"""
function PlotPolygon(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotPolygon: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotPolygon(label_id, xc, yc, length(xc), spec)
end
