# Error bar plotting/annotation

# Vertical Error Bars

function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                       err::AbstractArray{<:Real}, args...)
    return PlotErrorBars(label_id, promote(x, y, err)..., args...)
end

function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                       neg::AbstractArray{<:Real}, pos::AbstractArray{<:Real}, args...)
    return PlotErrorBars(label_id, promote(x, y, neg, pos), count, offset, stride)
end

function PlotErrorBars(label_id, x::AbstractArray{T}, y::AbstractArray{T}, error::AbstractArray{T};
                       count::Integer=min(length(x), length(y), length(error)),
                       offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotErrorBars(label_id, x, y, error, count, offset, stride * sizeof(T))
end

function PlotErrorBars(label_id, x::AbstractArray{T}, y::AbstractArray{T}, negative::AbstractArray{T},
                       positive::AbstractArray{T};
                       count::Integer=min(length(x), length(y), length(negative),
                                          length(positive)), offset::Integer=0,
                       stride::Integer=1) where {T<:ImPlotData}
    return PlotErrorBars(label_id, x, y, negative, positive, count, offset,
                         stride * sizeof(T))
end

function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                       error::AbstractArray{<:Real}; kwargs...)
    return PlotErrorBars(label_id, promote(x, y, error)...; kwargs...)
end

function PlotErrorBars(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                       neg::AbstractArray{<:Real}, pos::AbstractArray{<:Real}; kwargs...)
    return PlotErrorBars(label_id, promote(x, y, pos, neg)...; kwargs...)
end

# Horizontal Error bars

function PlotErrorBarsH(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                        err::AbstractArray{<:Real}, args...)
    return PlotErrorBarsH(label_id, promote(x, y, err)..., args...)
end

function PlotErrorBarsH(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                        neg::AbstractArray{<:Real}, pos::AbstractArray{<:Real}, args...)
    return PlotErrorBarsH(label_id, promote(x, y, neg, pos), count, offset, stride)
end

function PlotErrorBarsH(label_id, x::AbstractArray{T}, y::AbstractArray{T}, error::AbstractArray{T};
                        count::Integer=min(length(x), length(y), length(error)),
                        offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotErrorBarsH(label_id, x, y, error, count, offset, stride * sizeof(T))
end

function PlotErrorBarsH(label_id, x::AbstractArray{T}, y::AbstractArray{T},
                        negative::AbstractArray{T}, positive::AbstractArray{T};
                        count::Integer=min(length(x), length(y), length(negative),
                                           length(positive)), offset::Integer=0,
                        stride::Integer=1) where {T<:ImPlotData}
    return PlotErrorBarsH(label_id, x, y, negative, positive, count, offset,
                          stride * sizeof(T))
end

function PlotErrorBarsH(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                        error::AbstractArray{<:Real}; kwargs...)
    return PlotErrorBarsH(label_id, promote(x, y, error)...; kwargs...)
end

function PlotErrorBarsH(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real},
                        neg::AbstractArray{<:Real}, pos::AbstractArray{<:Real}; kwargs...)
    return PlotErrorBarsH(label_id, promote(x, y, pos, neg)...; kwargs...)
end
