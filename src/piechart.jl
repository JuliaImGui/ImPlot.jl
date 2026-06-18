# Pie charts. Normalize via spec=ImPlotSpec(Flags=ImPlotPieChartFlags_Normalize).
"""$(TYPEDSIGNATURES)"""
function PlotPieChart(label_ids::AbstractVector{<:AbstractString}, values::AbstractArray{<:Real},
                      x::Real, y::Real, radius::Real; label_fmt::AbstractString="%.1f", angle0::Real=90,
                      spec::ImPlotSpec=ImPlotSpec())
    if length(label_ids) != length(values)
        throw(DimensionMismatch("PlotPieChart: label_ids ($(length(label_ids))) and values ($(length(values))) lengths differ"))
    end
    vc = _coerce(values)
    labels = convert(Vector{String}, label_ids)  # low-level needs an invariant String array (e.g. SubString -> String)
    return PlotPieChart(labels, vc, length(vc), Float64(x), Float64(y), Float64(radius), label_fmt, Float64(angle0), spec)
end
