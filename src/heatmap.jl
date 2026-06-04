# Heatmaps. M[i,j] maps to heatmap row i, col j. Julia is column-major, so we pass vec(M)
# (zero-copy alias for dense M) and tell implot to read column-major via ColMajor.
# scale_min==scale_max==0 ⇒ auto-scale. label_fmt=nothing draws no cell labels.
"""$(TYPEDSIGNATURES)"""
function PlotHeatmap(label_id, M::AbstractMatrix{<:Real}; scale_min::Real=0, scale_max::Real=0,
                     label_fmt::Union{AbstractString,Nothing}="%.1f",
                     bounds_min=ImPlotPoint(0, 0), bounds_max=ImPlotPoint(1, 1), spec::ImPlotSpec=ImPlotSpec())
    rows, cols = size(M)
    values = _coerce(vec(M))                                 # column-major; zero-copy alias for dense M
    spec = setproperties(spec; Flags = spec.Flags | Cint(ImPlotHeatmapFlags_ColMajor))
    fmt = label_fmt === nothing ? C_NULL : label_fmt
    return PlotHeatmap(label_id, values, rows, cols, Float64(scale_min), Float64(scale_max), fmt, bounds_min, bounds_max, spec)
end
