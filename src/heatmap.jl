#Heatmap plots
"""
$(TYPEDSIGNATURES)
"""
function PlotHeatmap(label_id, x::AbstractArray{T}, rows, cols, scale_min=0.0, scale_max=1.0;
                     label_fmt="%.1f",
                     bounds_min=ImPlotPoint(0.0, 0.0),
                     bounds_max=ImPlotPoint(1.0, 1.0)) where {T<:ImPlotData}
    return PlotHeatmap(label_id, x, rows, cols, scale_min, scale_max, label_fmt, bounds_min,
                       bounds_max)
end
