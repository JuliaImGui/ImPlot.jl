# Scatter plots

function PlotScatter(x::AbstractArray{T,1}, y::AbstractArray{T,1};
                  count::Integer = min(length(x), length(y)),
                  offset::Integer = 0, stride::Integer = 1,
                  label::String = "") where {T}
    
    if eltype(x) == Float64
        CImPlot.PlotScatterdoublePtrdoublePtr(label, x, y, Cint(count), Cint(offset),
                                          Cint(stride * sizeof(Float64)))
    elseif eltype(x) == Float32
        CImPlot.PlotScatterFloatPtrFloatPtr(label, x, y, Cint(count), Cint(offset),
                                        Cint(stride * sizeof(Float32)))
    else
        x = convert.(Float32, x)
        y = convert.(Float32, y)
        CImPlot.PlotScatterFloatPtrFloatPtr(label, x, y, Cint(count), Cint(offset),
                                        Cint(stride * sizeof(Float32)))
    end
end

function PlotScatter(x::AbstractArray{T1,1}, y::AbstractArray{T2,1}; kwargs...) where {T1,T2}
    (x, y) = promote(x,y)
    plotline(x,y; kwargs...)
end

function PlotScatter(y::AbstractArray{T,1}; label::String="", count::Integer=length(y),
                  offset::Integer=0, stride::Integer=1) where {T}
    if eltype(y) == Float32
        CImPlot.PlotScatterFloatPtrInt(label, y, Cint(count), Cint(offset),
                                   Cint(stride * sizeof(Float32)))
    elseif eltype(y) == Float64
        CImPlot.PlotScatterdoublePtrInt(label, y, Cint(count), Cint(offset),
                                    Cint(stride * sizeof(Float64)))
    else
        y = convert.(Float32, y)
        CImPlot.PlotScatterFloatPtrInt(label, y, Cint(count), Cint(offset),
                                   Cint(stride * sizeof(Float32)))
    end
end

function PlotScatter(x::UnitRange{<:Integer}, y::AbstractArray{T,1};
                  label::String="") where {T}

        count::Cint = length(x)
        offset::Cint = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")

    if eltype(y) == Float32
        stride = Cint(sizeof(Float32))
        CImPlot.PlotScatterFloatPtrInt(label, y, count, offset, stride)
    elseif eltype(y) == Float64
        stride = Cint(sizeof(Float64))
        CImPlot.PlotScatterdoublePtrInt(label, y, count, offset, stride)
    else
        y = convert.(Float32, y)
        stride = Cint(sizeof(Float32))
        CImPlot.PlotScatterFloatPtrInt(label, y, count, offset, stride)
    end
end

function PlotScatter(x::StepRange, y::AbstractArray{T,1};
                  label::String="") where {T}
    
    x.stop < 1 && throw("Range out of bounds")
    count::Cint = length(x)
    offset::Cint = x.start >= 1 ? x.start - 1 : throw("Range out of bounds")
    
    if eltype(y) == Float64
        stride = Cint(x.step * sizeof(Float64))
        CImPlot.PlotScatterdoublePtrInt(label, y, count, offset, stride)
    elseif eltype(y) == Float32
        stride = Cint(x.step * sizeof(Float32))
        CImPlot.PlotScatterFloatPtrInt(label, y, count, offset, stride)
    else
        y = convert.(Float32, y)
        stride = Cint(x.step * sizeof(Float32))
        CImPlot.PlotScatterFloatPtrInt(label, y, count, offset, stride)
    end
end
