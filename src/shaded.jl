# Shaded line plots
"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}, count,
                    y_ref::Real, args...)
    (x, y) = promote(x, y)
    return PlotShaded(label_id, x, y, count, Float64(y_ref), args...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{<:Real}, y1::AbstractArray{<:Real},
                    y2::AbstractArray{<:Real}, args...)
    return PlotShaded(label_id, promote(x, y1, y2)..., args...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{T}, y1::AbstractArray{T}, y2::AbstractArray{T};
                    count::Integer=min(length(x), length(y2), length(y2)),
                    offset::Integer=0, stride::Integer=1) where {T<:ImPlotData}
    return PlotShaded(label_id, x, y1, y2, count, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{T1}, y1::AbstractArray{T2}, y2::AbstractArray{T3};
                    kwargs...) where {T1<:Real,T2<:Real,T3<:Real}
    return PlotShaded(label_id, promote(x, y1, y2)...; kwargs...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{T}, y::AbstractArray{T}, y_ref::T;
                    count::Integer=min(length(x), length(y)), offset::Integer=0,
                    stride::Integer=1) where {T<:ImPlotData}
    return PlotShaded(label_id, x, y, count, y_ref, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::AbstractArray{T1}, y::AbstractArray{T2}, y_ref::T3;
                    kwargs...) where {T1<:Real,T2<:Real,T3<:Real}
    (x, y) = promote(x, y)
    y_ref = eltype(x)(y_ref)
    return PlotShaded(label_id, x, y, y_ref; kwargs...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::UnitRange{<:Integer}, y1::AbstractArray{T}, y2::AbstractArray{T};
                   ) where {T<:ImPlotData}
    count = length(x)
    offset = x.start >= 1 ? x.start - 1 : throw("Offset out of bounds")
    x = collect(T, x)
    return PlotShaded(label_id, x, y1, y2, count, offset, sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::UnitRange{<:Integer}, y::AbstractArray{T}, y_ref::T;
                   ) where {T<:ImPlotData}
    count = length(x)
    offset = x.start >= 1 ? x.start - 1 : throw("Offset out of bounds")
    x = collect(T, x)
    return PlotShaded(label_id, x, y, count, y_ref, offset, sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::StepRange, y1::AbstractArray{T}, y2::AbstractArray{T};
                   ) where {T<:ImPlotData}
    x.stop < 1 && throw("Range out of bounds")
    count = length(x)
    offset = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")
    stride = x.step >= 1 ? x.step : throw("Stride must be greater than zero.")
    x = collect(T, x)
    return PlotShaded(label_id, x, y1, y2, count, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::StepRange, y::AbstractArray{T}, y_ref::T;
                   ) where {T<:ImPlotData}
    x.stop < 1 && throw("Range out of bounds")
    count = length(x)
    offset = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")
    stride = x.step >= 1 ? x.step : throw("Stride must be greater than zero.")

    x = collect(T, x)
    return PlotShaded(label_id, x, y, count, y_ref, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::OrdinalRange, y1::AbstractArray{T1}, y2::AbstractArray{T2};
                    kwargs...) where {T1<:Real,T2<:Real}
    return PlotShaded(label_id, x, promote(y1, y2)...; kwargs...)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, x::OrdinalRange, y::AbstractArray{T1}, y_ref::T2;
                    kwargs...) where {T1<:Real,T2<:Real}
    y_ref = eltype(y)(y_ref)
    return PlotShaded(label_id, x, y, y_ref; kwargs...)
end

# xfield, yfield should be propertynames of eltype(structvec)
"""
$(TYPEDSIGNATURES)
"""
function PlotShaded(label_id, structvec::Vector{T}, xfield::Symbol, yfield::Symbol, y_ref::Real;
                    count::Integer=length(structvec), offset::Integer=0, stride::Integer=1,
                   ) where {T}

    Tx = fieldtype(T, xfield)
    Ty = fieldtype(T, yfield)
    x_offset = fieldoffset(T, Base.fieldindex(T, xfield))
    y_offset = fieldoffset(T, Base.fieldindex(T, yfield))
    x_ptr = Ptr{Tx}((pointer(structvec, 1) + x_offset))
    y_ptr = Ptr{Ty}((pointer(structvec, 1) + y_offset))

    if !ismutabletype(T)
        # this is somewhat illegal and is used only to pass a pointer through AbstractArray argument into ccall
        x = unsafe_wrap(Vector{Tx}, x_ptr, size(structvec); own=false)
        y = unsafe_wrap(Vector{Ty}, y_ptr, size(structvec); own=false)
        stride = stride * sizeof(T)
    else # two new vectors every 1/60 second...
        x = Vector{Tx}(undef, length(structvec))
        y = Vector{Ty}(undef, length(structvec))
        for (i, val) in enumerate(structvec)
            x[i] = getproperty(val, xfield)
            y[i] = getproperty(val, yfield)
        end
        if Tx !== Ty
            x, y = promote(x, y)
        end
        stride = stride * sizeof(eltype(x))
    end

    return PlotShaded(label_id, x, y, count, y_ref, ImPlotShadedFlags_None, offset, stride)
end
