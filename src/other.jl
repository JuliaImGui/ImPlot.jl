# Plot text labels at arbitrary coordinate points
function PlotText(text::String, x::Real, y::Real, vertical::Bool=false,
                  pixel_offset::ImVec2=ImVec2(0, 0))
    return LibCImPlot.PlotText(text, x, y, vertical, pixel_offset)
end

function PlotImage(label_id, user_texture_id, bounds_min::ImPlotPoint=(0, 0),
                   bounds_max::ImPlotPoint=(0, 0), uv0::ImVec2=(0, 0), uv1::ImVec2=(1, 1),
                   tint_col::ImVec4=(1, 1, 1, 1))
    return LibCImPlot.PlotImage(label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1,
                                tint_col)
end

function PlotImage(label_id, user_texture_id, bounds_min::ImPlotPoint=(0, 0),
                   bounds_max::ImPlotPoint=(0, 0), uv0::ImVec2=(0, 0), uv1::ImVec2=(1, 1),
                   tint_col::ImVec4=(1, 1, 1, 1))
    return LibCImPlot.PlotImage(label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1,
                                tint_col)
end
