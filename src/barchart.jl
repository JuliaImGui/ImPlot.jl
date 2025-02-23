# Histogram (Bar) plots

# Vertical bars
"""
$(TYPEDSIGNATURES)
"""
function PlotBars(label_id, xs::AbstractArray{T1}, ys::AbstractArray{T2},
                  args...) where {T1<:Real,T2<:Real}
    return PlotBars(label_id, promote(xs, ys)..., args...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBars(label_id, values::AbstractArray{T}; count::Integer=length(values),
                  bar_size=0.67, shift=0.0, flags::ImPlotBarsFlags_ = ImPlotBarsFlags_None,
                  offset::Integer=0, stride::Integer=1) where {T <: ImPlotData}
    return PlotBars(label_id, values, count, bar_size, shift, flags, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBars(label_id, x::AbstractArray{T}, y::AbstractArray{T};
                  count::Integer=min(length(x), length(y)), bar_size=0.67,
                  shift=0.0, offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotBars(label_id, x, y, count, bar_size, offset, shift, ImPlotBarsFlags_None, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBars(label_id, x::AbstractArray{T1}, y::AbstractArray{T2};
                  kwargs...) where {T1<:Real,T2<:Real}
    return PlotBars(label_id, promote(x, y)..., kwargs...)
end

# Horizontal bars
"""
$(TYPEDSIGNATURES)
"""
function PlotBarsH(label_id, x::AbstractArray{T1}, y::AbstractArray{T2},
                   count::Integer, bar_size::Real, shift::Real,
                   offset::Integer, stride::Integer) where {T1<:Real,T2<:Real}
    return PlotBars(label_id, promote(x, y)..., count, bar_size, shift, ImPlotBarsFlags_Horizontal, offset, stride)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBarsH(label_id, values::AbstractArray{T}; count::Integer=length(values),
                   bar_size=0.67, shift=0.0, offset::Integer=0,
                   stride::Integer=1) where {T<:ImPlotData}
    return PlotBars(label_id, values, count, bar_size, shift, ImPlotBarsFlags_Horizontal, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBarsH(label_id, x::AbstractArray{T}, y::AbstractArray{T};
                   count::Integer=min(length(x), length(y)),
                   bar_size=0.67, shift=0.0, offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotBars(label_id, x, y, count, bar_size, shift, ImPlotBarsFlags_Horizontal, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotBarsH(label_id, x::AbstractArray{T1}, y::AbstractArray{T2};
                   kwargs...) where {T1<:Real,T2<:Real}
    return PlotBarsH(label_id, promote(x, y)..., kwargs...)
end
