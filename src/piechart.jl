# Pie charts
#function PlotPieChart(label_ids, values::AbstractArray{<:Real}, args...)
#    return PlotPieChart(label_ids, Float64.(values), args...)
#end

"""
$(TYPEDSIGNATURES)
"""
function PlotPieChart(values::AbstractArray{T}, count::Integer, x, y, radius;
                      normalize::Bool=false, label_fmt::String="%.1f", angle0=90.0,
                      label_ids::Vector{String}=["" for _ in 1:length(values)]) where {T<:ImPlotData}
    return PlotPieChart(label_ids, values, count, x, y, radius, normalize, label_fmt,
                        angle0)
end

"""
$(TYPEDSIGNATURES)
"""
function PlotPieChart(values::AbstractArray{T}, count::Integer, x, y, radius;
                      normalize::Bool=false, label_fmt::String="%.1f", angle0=90.0,
                      label_ids::Vector{String}=["" for _ in 1:length(values)]) where {T<:Real}
    return PlotPieChart(label_ids, Float64.(values), count, x, y, radius, normalize,
                        label_fmt, angle0)
end
