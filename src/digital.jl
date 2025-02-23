# Digital signal plots
"""
$(TYPEDSIGNATURES)
"""
function PlotDigital(label_id, x::AbstractArray{T}, y::AbstractArray{T};
                     count::Integer=min(length(x), length(y)), offset::Integer=0,
                     stride::Integer=1) where {T<:ImPlotData}
    return PlotDigital(label_id, x, y, count, offset, stride * sizeof(T))
end

"""
$(TYPEDSIGNATURES)
"""
function PlotDigital(label_id, x::AbstractArray{T1}, y::AbstractArray{T2};
                     kwargs...) where {T1<:Real,T2<:Real}
    return PlotDigital(label_id, promote(x, y)...; kwargs...)
end

# xfield, yfield should be propertynames of eltype(structvec)
"""
$(TYPEDSIGNATURES)
"""
function PlotDigital(label_id, structvec::Vector{T}, xfield::Symbol, yfield::Symbol;
                     count::Integer=length(structvec), offset::Integer=0, stride::Integer=1
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

    return PlotDigital(label_id, x, y, count, offset, stride)
end
