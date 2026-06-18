# Grouped bar charts. values[series, group]; one label per series.
# Stacked via spec=ImPlotSpec(Flags=ImPlotBarGroupsFlags_Stacked); horizontal via _Horizontal.
"""$(TYPEDSIGNATURES)"""
function PlotBarGroups(label_ids::AbstractVector{<:AbstractString}, values::AbstractMatrix{<:Real};
                       group_size::Real=0.67, shift::Real=0, spec::ImPlotSpec=ImPlotSpec())
    item_count, group_count = size(values)
    if length(label_ids) != item_count
        throw(DimensionMismatch("PlotBarGroups: label_ids ($(length(label_ids))) must equal series count ($item_count)"))
    end
    vc = _coerce(vec(permutedims(values)))          # row-major flatten
    labels = convert(Vector{String}, label_ids)     # low-level needs an invariant String array (e.g. SubString -> String)
    return PlotBarGroups(labels, vc, item_count, group_count, Float64(group_size), Float64(shift), spec)
end
