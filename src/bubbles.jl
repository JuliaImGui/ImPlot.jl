# Bubble plots (per-point sizes).
"""$(TYPEDSIGNATURES)"""
function PlotBubbles(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}, sizes::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if !(length(x) == length(y) == length(sizes))
        throw(DimensionMismatch("PlotBubbles: x/y/sizes lengths differ ($(length(x)),$(length(y)),$(length(sizes)))"))
    end
    xc, yc, sc = _coerce(x, y, sizes)
    return PlotBubbles(label_id, xc, yc, sc, length(xc), spec)
end
