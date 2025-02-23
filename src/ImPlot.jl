module ImPlot

import DocStringExtensions: TYPEDSIGNATURES

import CImGui as ig
for i in instances(ig.ImGuiCond_)
    @eval import CImGui: $(Symbol(i))
end
import CImGui.lib: libcimgui

const ImPlotData = Union{Float32,Float64,Int8,UInt8,Int16,UInt16,Int32,UInt32,Int64,UInt64}

include("libcimplot.jl")

"""
$(TYPEDSIGNATURES)
"""
function BeginPlot(title_id::String, x_label::String = "", y_label::String = "", size::ImVec2 = ImVec2(-1,0);
                    flags = ImPlotFlags_None,
                    x_flags = ImPlotAxisFlags_None,
                    y_flags = ImPlotAxisFlags_None,
                    y2_flags::Union{ImPlotAxisFlags_, Nothing} = nothing,
                    y3_flags::Union{ImPlotAxisFlags_, Nothing} = nothing)::Bool

    ret = BeginPlot(title_id, size, flags)
    if ret
        SetupAxes(x_label, y_label, x_flags, y_flags)

        if y2_flags !== nothing
            SetupAxis(ImAxis_Y2, "", y2_flags)
        end
        if y3_flags !== nothing
            SetupAxis(ImAxis_Y3, "", y3_flags)
        end
    end

    return ret
end

"""
$(TYPEDSIGNATURES)
"""
function SetNextAxisLimitsX(x_min::Real, x_max::Real, cond = ImPlotCond_Once)
    SetNextAxisLimits(ImAxis_X1, x_min, x_max, cond)
end

"""
$(TYPEDSIGNATURES)
"""
function SetNextAxisLimitsY(y_min::Real, y_max::Real, cond = ImPlotCond_Once)
    SetNextAxisLimits(ImAxis_Y1, y_min, y_max, cond)
end

"""
$(TYPEDSIGNATURES)
"""
function SetupAxisTicksX(values, n_ticks, labels, keep_default = false)
    SetupAxisTicks(ImAxis_X1, values, n_ticks, labels, keep_default)
end

"""
$(TYPEDSIGNATURES)
"""
function SetupAxisTicksX(v_min::Real, v_max::Real, n_ticks, labels, keep_default = false)
    SetupAxisTicks(ImAxis_X1, v_min, v_max, n_ticks, labels, keep_default)
end

"""
$(TYPEDSIGNATURES)
"""
function SetupAxisTicksY(values, n_ticks, labels, keep_default = false)
    SetupAxisTicks(ImAxis_Y1, values, n_ticks, labels, keep_default)
end

"""
$(TYPEDSIGNATURES)
"""
function SetupAxisTicksY(v_min::Real, v_max::Real, n_ticks, labels, keep_default = false)
    SetupAxisTicks(ImAxis_Y1, v_min, v_max, n_ticks, labels, keep_default)
end

include("constructors.jl")
include("lines.jl")
include("stairs.jl")
include("shaded.jl")
include("scatter.jl")
include("heatmap.jl")
include("digital.jl")
include("barchart.jl")
include("piechart.jl")
include("errorbars.jl")
include("stems.jl")
#include("other.jl")
include("util.jl")
#include("color.jl")
#include("styling.jl")

end # module
