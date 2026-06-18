# Stem plots
"""$(TYPEDSIGNATURES)"""
function PlotStems(label_id, x::AbstractArray{<:Real}, y::AbstractArray{<:Real}; ref::Real=0, spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotStems: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    xc, yc = _coerce(x, y)
    return PlotStems(label_id, xc, yc, length(xc), Float64(ref), spec)
end

"""$(TYPEDSIGNATURES)"""
function PlotStems(label_id, x::AbstractRange, y::AbstractArray{<:Real}; ref::Real=0, spec::ImPlotSpec=ImPlotSpec())
    if length(x) != length(y)
        throw(DimensionMismatch("PlotStems: x ($(length(x))) and y ($(length(y))) lengths differ"))
    end
    yc = _coerce(y)
    return PlotStems(label_id, yc, length(yc), Float64(ref), Float64(step(x)), Float64(first(x)), spec)
end

"""$(TYPEDSIGNATURES)"""
PlotStems(label_id, y::AbstractArray{<:Real}; ref::Real=0, spec::ImPlotSpec=ImPlotSpec()) =
    PlotStems(label_id, 0:length(y)-1, y; ref, spec)
