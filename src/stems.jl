"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}, args...)
    return PlotStems(label_id, promote(x, y), args...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, values::AbstractArray{T}; count::Integer=length(values),
                   y_ref=0.0, xscale=1.0, x0=0.0, offset::Integer=0,
                   stride::Integer=1) where {T<:ImPlotData}
    return PlotStems(label_id, values, count, y_ref, xscale, x0, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, values::AbstractArray{T}; count::Integer=length(values),
                   y_ref=0.0, xscale=1.0, x0=0.0, offset::Integer=0,
                   stride::Integer=1) where {T<:Real}
    return PlotStems(label_id, Float64.(values), count, y_ref, xscale, x0, offset,
                     stride * sizeof(Float64))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, x::AbstractArray{T}, y::AbstractArray{T};
                   count::Integer=min(length(x), length(y)), y_ref=0.0,
                   offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotStems(label_id, x, y, count, y_ref, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, x::AbstractArray{T}, y::AbstractArray{T};
                   count::Integer=min(length(x), length(y)), y_ref=0.0,
                   offset::Integer=0, stride::Integer=1) where {T<:Real}
    return PlotStems(label_id, Float64.(x), Float64.(y), count, y_ref, offset,
                     stride * sizeof(Float64))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotStems(label_id, x::AbstractArray{T1}, y::AbstractArray{T2};
                   kwargs...) where {T1<:Real,T2<:Real}
    return PlotBars(label_id, promote(x, y)...; kwargs...)
end
