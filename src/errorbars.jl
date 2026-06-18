# Error bars. Horizontal via spec=ImPlotSpec(Flags=ImPlotErrorBarsFlags_Horizontal).
"""$(TYPEDSIGNATURES)"""
function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}, err::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if !(length(x) == length(y) == length(err))
        throw(DimensionMismatch("PlotErrorBars: x/y/err lengths differ ($(length(x)),$(length(y)),$(length(err)))"))
    end
    xc, yc, ec = _coerce(x, y, err)
    return PlotErrorBars(label_id, xc, yc, ec, length(xc), spec)
end

"""$(TYPEDSIGNATURES)"""
function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}, neg::AbstractArray{<:Real}, pos::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    if !(length(x) == length(y) == length(neg) == length(pos))
        throw(DimensionMismatch("PlotErrorBars: x/y/neg/pos lengths differ ($(length(x)),$(length(y)),$(length(neg)),$(length(pos)))"))
    end
    xc, yc, nc, pc = _coerce(x, y, neg, pos)
    return PlotErrorBars(label_id, xc, yc, nc, pc, length(xc), spec)
end
