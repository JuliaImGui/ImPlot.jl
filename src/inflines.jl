# Infinite reference lines (replaces removed PlotVLines/PlotHLines).
# Horizontal via spec=ImPlotSpec(Flags=ImPlotInfLinesFlags_Horizontal).
"""$(TYPEDSIGNATURES)"""
function PlotInfLines(label_id, values::AbstractArray{<:Real}; spec::ImPlotSpec=ImPlotSpec())
    vc = _coerce(values)
    return PlotInfLines(label_id, vc, length(vc), spec)
end
