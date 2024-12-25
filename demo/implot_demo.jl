using Printf, Random, Setfield, Dates

using ImPlot
import CImGui
import ModernGL
import GLFW
import CSyntax: @c, @cstatic

CImGui.set_backend(:GlfwOpenGL3)

import CImGui: ImVec2, ImVec4, ImDrawIdx, ImGuiCond_Always, ImGuiCond_Appearing, ImGuiCond_FirstUseEver,
            ImGuiCond_Once, ImGuiWindowFlags_MenuBar, ImGuiBackendFlags_RendererHasVtxOffset,
            ImGuiDragDropFlags_None,
            ImGuiTableFlags_BordersOuter,
            ImGuiTableFlags_BordersV,
            ImGuiTableFlags_RowBg,
            ImGuiTableColumnFlags_WidthFixed,
            ImGuiTableColumnFlags_WidthFixed


const IMGUI_HAS_TABLE = true

# Encapsulates examples for customizing ImPlot.
module MyImPlot

using ImPlot, Setfield
import CImGui
import CImGui: ImVec4, ImVec2, ImGuiCond_Always


# Example for Custom Data and Getters section.
struct Vector2f
    x::Float32
    y::Float32
end

# Example for Custom Data and Getters section.
struct WaveData
    x::Float64
    amp::Float64
    freq::Float64
    offset::Float64
end

function SineWave(data::Ptr{Nothing}, idx::Cint, pt::Ptr{ImPlotPoint})::Nothing
    wd = unsafe_load(Ptr{WaveData}(data))
    x = idx * wd.x
    y = wd.offset + wd.amp * sin(2 * 3.14 * wd.freq * x)
    unsafe_store!(Ptr{Cdouble}(pt), Float64(x))
    unsafe_store!(Ptr{Cdouble}(pt + 8), Float64(y))
    return nothing
end

function SawWave(data::Ptr{Nothing}, idx::Cint, pt::Ptr{ImPlotPoint})::Nothing
    wd = unsafe_load(Ptr{WaveData}(data))
    x = idx * wd.x
    y = wd.offset + wd.amp * (-2/3.14 * atan(cos(3.14*wd.freq*x) / sin(3.14*wd.freq*x)))
    unsafe_store!(Ptr{Cdouble}(pt), Float64(x))
    unsafe_store!(Ptr{Cdouble}(pt+8), Float64(y))
    return nothing
end

function Spiral(::Ptr{Nothing}, idx::Cint, pt::Ptr{ImPlotPoint})::Nothing
    r = 0.9             # outer radius
    a = 0               # inner radius
    b = 0.05            # increment per rev
    n = (r - a) / b     # number  of revolutions
    th = 2 * n * 3.14   # angle
    Th = th * idx / (1000 - 1)
    x = 0.5 + (a + b * Th / (2.0 * 3.14)) * cos(Th)
    y = 0.5 + (a + b * Th / (2.0 * 3.14)) * sin(Th)
    unsafe_store!(Ptr{Cdouble}(pt), Float64(x))
    unsafe_store!(Ptr{Cdouble}(pt+8), Float64(y))
    return nothing
end

# Example for Tables section.
function Sparkline(id::String, values::Vector{Float32}, count::Int, min_v, max_v, offset::Int, col::ImVec4, size::ImVec2)

    ImPlot.PushStyleVar(ImPlotStyleVar_PlotPadding, ImVec2(0,0))
    ImPlot.SetNextAxesLimits(0, count - 1, min_v, max_v, ImGuiCond_Always)

    if ImPlot.BeginPlot(id, "", "", size;
                        flags = ImPlotFlags_CanvasOnly,
                        x_flags = ImPlotAxisFlags_NoDecorations,
                        y_flags = ImPlotAxisFlags_NoDecorations)

        ImPlot.PushStyleColor(ImPlotCol_Line, col)

        ImPlot.PlotLine(id, values, count, 1, 0, ImPlotLineFlags_None, offset)

        ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)

        ImPlot.PlotShaded(id, values, count, 0, 1, 0, ImPlotShadedFlags_None, offset)

        ImPlot.PopStyleVar()
        ImPlot.PopStyleColor()
        ImPlot.EndPlot()
    end

    ImPlot.PopStyleVar()
    return
end

function BinarySearch(arr::Vector{T}, l::Int, r::Int, x::T) where T
    if (r >= l)
        mid = l + (r - l) ÷ 2
        if (arr[mid] == x)
            return mid
        end
        if (arr[mid] > x)
            return BinarySearch(arr, l, mid - 1, x)
        end
        return BinarySearch(arr, mid + 1, r, x)
    end
    return -1
end

#= PlotCandlestick requires imgui_internal.h, which is available in cimplot v0.9+ only
# Example for Custom Plotters and Tooltips section.
function PlotCandlestick(label_id::String, xs::Vector{Float64}, opens::Vector{Float64},
                         closes::Vector{Float64}, lows::Vector{Float64}, highs::Vector{Float64},
                         count::Int, tooltip::Bool, width_percent::Float32, bullCol::ImVec4,
                         bearCol::ImVec4)

    # get ImGui window DrawList
    draw_list = ImPlot.GetPlotDrawList()
    # calc real value width
    half_width = count > 1 ? (xs[1] - xs[0]) * width_percent : width_percent

    # custom tool
    if ImPlot.IsPlotHovered() && tooltip
        ImPlotPoint mouse   = ImPlot.GetPlotMousePos()
        mouse.x             = ImPlot.RoundTime(ImPlotTime::FromDouble(mouse.x), ImPlotTimeUnit_Day).ToDouble()
        float  tool_l       = ImPlot.PlotToPixels(mouse.x - half_width * 1.5, mouse.y).x
        float  tool_r       = ImPlot.PlotToPixels(mouse.x + half_width * 1.5, mouse.y).x
        float  tool_t       = ImPlot.GetPlotPos().y
        float  tool_b       = tool_t + ImPlot.GetPlotSize().y
        ImPlot.PushPlotClipRect()
        draw_list->AddRectFilled(ImVec2(tool_l, tool_t), ImVec2(tool_r, tool_b), IM_COL32(128,128,128,64))
        ImPlot.PopPlotClipRect()
        # find mouse location index
        int idx = BinarySearch(xs, 0, count - 1, mouse.x)
        # render tool tip (won't be affected by plot clip rect)
        if (idx != -1)
            CImGui.BeginTooltip()
            char buff[32]
            ImPlot.FormatDate(ImPlotTime::FromDouble(xs[idx]),buff,32,ImPlotDateFmt_DayMoYr,ImPlot.GetStyle().UseISO8601)
            CImGui.Text("Day:   %s",  buff)
            CImGui.Text("Open:  $%.2f", opens[idx])
            CImGui.Text("Close: $%.2f", closes[idx])
            CImGui.Text("Low:   $%.2f", lows[idx])
            CImGui.Text("High:  $%.2f", highs[idx])
            CImGui.EndTooltip()
        end
    end

    # begin plot item
    if ImPlot.BeginItem(label_id)
        # override legend icon color
        ImPlot.GetCurrentItem()->Color = IM_COL32(64,64,64,255)
        # fit data if requested
        if ImPlot.FitThisFrame()
            for i = 1:count
                ImPlot.FitPoint(ImPlotPoint(xs[i], lows[i]))
                ImPlot.FitPoint(ImPlotPoint(xs[i], highs[i]))
            end
        end
        # render data
        for i = 1:count
            ImVec2 open_pos  = ImPlot.PlotToPixels(xs[i] - half_width, opens[i])
            ImVec2 close_pos = ImPlot.PlotToPixels(xs[i] + half_width, closes[i])
            ImVec2 low_pos   = ImPlot.PlotToPixels(xs[i], lows[i])
            ImVec2 high_pos  = ImPlot.PlotToPixels(xs[i], highs[i])
            ImU32 color      = CImGui.GetColorU32(opens[i] > closes[i] ? bearCol : bullCol)
            draw_list->AddLine(low_pos, high_pos, color)
            draw_list->AddRectFilled(open_pos, close_pos, color)
        end

        # end plot item
        ImPlot.EndItem()
    end
end
=#

# Example for Custom Styles section.
function StyleSeaborn()

    style  = ImPlot.GetStyle()
    colors = unsafe_load(style.Colors)

    @set colors[1 + Int(ImPlotCol_Line)]          = IMPLOT_AUTO_COL
    @set colors[1 + Int(ImPlotCol_Fill)]          = IMPLOT_AUTO_COL
    @set colors[1 + Int(ImPlotCol_MarkerOutline)] = IMPLOT_AUTO_COL
    @set colors[1 + Int(ImPlotCol_MarkerFill)]    = IMPLOT_AUTO_COL
    @set colors[1 + Int(ImPlotCol_ErrorBar)]      = ImVec4(0.00, 0.00, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_FrameBg)]       = ImVec4(1.00, 1.00, 1.00, 1.00)
    @set colors[1 + Int(ImPlotCol_PlotBg)]        = ImVec4(0.92, 0.92, 0.95, 1.00)
    @set colors[1 + Int(ImPlotCol_PlotBorder)]    = ImVec4(0.00, 0.00, 0.00, 0.00)
    @set colors[1 + Int(ImPlotCol_LegendBg)]      = ImVec4(0.92, 0.92, 0.95, 1.00)
    @set colors[1 + Int(ImPlotCol_LegendBorder)]  = ImVec4(0.80, 0.81, 0.85, 1.00)
    @set colors[1 + Int(ImPlotCol_LegendText)]    = ImVec4(0.00, 0.00, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_TitleText)]     = ImVec4(0.00, 0.00, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_InlayText)]     = ImVec4(0.00, 0.00, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_AxisText)]      = ImVec4(0.00, 0.00, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_AxisGrid)]      = ImVec4(1.00, 1.00, 1.00, 1.00)
    @set colors[1 + Int(ImPlotCol_Selection)]     = ImVec4(1.00, 0.65, 0.00, 1.00)
    @set colors[1 + Int(ImPlotCol_Crosshairs)]    = ImVec4(0.23, 0.10, 0.64, 0.50)

    style.LineWeight       = 1.5
    style.Marker           = ImPlotMarker_None
    style.MarkerSize       = 4
    style.MarkerWeight     = 1
    style.FillAlpha        = 1.0
    style.ErrorBarSize     = 5
    style.ErrorBarWeight   = 1.5
    style.DigitalBitHeight = 8
    style.DigitalBitGap    = 4
    style.PlotBorderSize   = 0
    style.MinorAlpha       = 1.0
    style.MajorTickLen     = ImVec2(0,0)
    style.MinorTickLen     = ImVec2(0,0)
    style.MajorTickSize    = ImVec2(0,0)
    style.MinorTickSize    = ImVec2(0,0)
    style.MajorGridSize    = ImVec2(1.2,1.2)
    style.MinorGridSize    = ImVec2(1.2,1.2)
    style.PlotPadding      = ImVec2(12,12)
    style.LabelPadding     = ImVec2(5,5)
    style.LegendPadding    = ImVec2(5,5)
    style.MousePosPadding  = ImVec2(5,5)
    style.PlotMinSize      = ImVec2(300,225)
end

end # module MyImPlot

# utility
RandomRange(min, max) = min + rand()*(max-min)

# utility structure for realtime plot
mutable struct ScrollingBuffer
    maxsize::Int
    offset::Int
    data::Vector{ImVec2}
    function ScrollingBuffer(maxsize = 2000)
        data = ImVec2[]
        sizehint!(data, maxsize)
        new(maxsize, 0, data)
    end
end

function AddPoint(buf::ScrollingBuffer, x, y)
    if length(buf.data) < buf.maxsize
        push!(buf.data, ImVec2(x, y))
    else
        buf.data[buf.offset + 1] = ImVec2(x, y) # 1-based indexing
        buf.offset = (buf.offset + 1) % buf.maxsize
    end
end

function Erase(buf::ScrollingBuffer)
    if length(buf.data) > 0
        empty!(buf.data)
        buf.offset = 0
    end
end

# utility structure for realtime plot
mutable struct RollingBuffer
    span::Float32
    data::Vector{ImVec2}
    function RollingBuffer()
        span = 10.0f0
        data = ImVec2[]
        sizehint!(data, 2000)
        new(span, data)
    end
end

function AddPoint(buf::RollingBuffer, x, y)
    xmod = mod(x, buf.span)
    if !isempty(buf.data) && xmod < last(buf.data).x
        empty!(buf.data)
    end
    push!(buf.data, ImVec2(xmod, y))
end

# Huge data used by Time Formatting example (~500 MB allocation!)
module Huge

    const SIZE = 60*60*24*366
    GetY(t::Float64)::Float64 = 0.5 + 0.25 * sin(t/86400/12) +  0.005 * sin(t/3600)

    struct TimeData
        ts::Vector{Float64}
        ys::Vector{Float64}
        function TimeData(min::Float64)
            ts = Vector{Float64}(undef, SIZE)
            ys = Vector{Float64}(undef, SIZE)
            for i in 1:SIZE
                ts[i] = min + i
                ys[i] = GetY(ts[i])
            end
            new(ts, ys)
        end
    end

end

#-------------------------------------------------------------------------------------------

function ShowDemoWindow()

    DEMO_TIME = CImGui.GetTime()

    @cstatic(
        p_open = false, # p_open should be passed through as an argument, just like implot does
        show_imgui_metrics = false,
        show_implot_metrics = false,
        show_imgui_style_editor = false,
        show_implot_style_editor = false,
        show_implot_benchmark = false,
    begin

        show_imgui_metrics && @c CImGui.ShowMetricsWindow(&show_imgui_metrics)
        show_implot_metrics && @c ImPlot.ShowMetricsWindow(&show_implot_metrics)

        if show_imgui_style_editor
            @c CImGui.Begin("Style Editor (CImGui)", &show_imgui_style_editor)
            CImGui.ShowStyleEditor()
            CImGui.End()
        end

        if show_implot_style_editor
            CImGui.SetNextWindowSize(ImVec2(415,762), ImGuiCond_Appearing)
            @c CImGui.Begin("Style Editor (ImPlot)", &show_implot_style_editor)
            ImPlot.ShowStyleEditor(ImPlot.GetStyle())
            CImGui.End()
        end

        if show_implot_benchmark
            CImGui.SetNextWindowSize(ImVec2(530,740), ImGuiCond_Appearing)
            @c CImGui.Begin("ImPlot Benchmark Tool", &show_implot_benchmark)
            ShowBenchmarkTool() # eventually to be defined in this demo
            CImGui.End()
            return
        end

        CImGui.SetNextWindowPos(ImVec2(50, 50), ImGuiCond_FirstUseEver)
        CImGui.SetNextWindowSize(ImVec2(600, 750), ImGuiCond_FirstUseEver)
        @c CImGui.Begin("ImPlot Demo", &p_open, ImGuiWindowFlags_MenuBar)

        if CImGui.BeginMenuBar()
            if CImGui.BeginMenu("Tools")
                @c CImGui.MenuItem("Metrics (CImGui)",      C_NULL, &show_imgui_metrics)
                @c CImGui.MenuItem("Metrics (ImPlot)",      C_NULL, &show_implot_metrics)
                @c CImGui.MenuItem("Style Editor (CImGui)", C_NULL, &show_imgui_style_editor)
                @c CImGui.MenuItem("Style Editor (ImPlot)", C_NULL, &show_implot_style_editor)
                # The benchmark tool is implemented in implot_demo.cpp but we don't recreate it here.
                # @c CImGui.MenuItem("Benchmark",           C_NULL, &show_implot_benchmark)
                CImGui.EndMenu()
            end
            CImGui.EndMenuBar()
        end

    end) # cstatic

    #-------------------------------------------------------------------------
    CImGui.Text("ImPlot says hello - v0.17")
    CImGui.Spacing()

    if CImGui.CollapsingHeader("Help")
        CImGui.Text("ABOUT THIS DEMO:")
        CImGui.BulletText("Sections below are demonstrating many aspects of the library.")
        CImGui.BulletText("The \"Tools\" menu above gives access to: Style Editors (ImPlot/CImGui)\n"
                          *"and Metrics (general purpose Dear CImGui debugging tool).")
        CImGui.Separator()
        CImGui.Text("PROGRAMMER GUIDE:")
        CImGui.BulletText("See the ShowDemoWindow() code in implot_demo.cpp. <- you are here!")
        CImGui.BulletText("By default, anti-aliased lines are turned OFF.")
        CImGui.Indent()
            CImGui.BulletText("Software AA can be enabled globally with ImPlotStyle.AntiAliasedLines.")
            CImGui.BulletText("Software AA can be enabled per plot with ImPlotFlags_AntiAliased.")
            CImGui.BulletText("AA for plots can be toggled from the plot's context menu.")
            CImGui.BulletText("If permitable, you are better off using hardware AA (e.g. MSAA).")
        CImGui.Unindent()
        CImGui.BulletText("If you see visual artifacts, do one of the following:")
        CImGui.Indent()
        CImGui.BulletText("Handle ImGuiBackendFlags_RendererHasVtxOffset for 16-bit indices in your backend.")
        CImGui.BulletText("Or, enable 32-bit indices in imconfig.h.")
        CImGui.BulletText("Your current configuration is:")
        CImGui.Indent()
        CImGui.BulletText("ImDrawIdx: $(sizeof(ImDrawIdx)*8)-bit")
        CImGui.BulletText(@sprintf("ImGuiBackendFlags_RendererHasVtxOffset: %s",
                                   (unsafe_load(CImGui.GetIO().BackendFlags) & ImGuiBackendFlags_RendererHasVtxOffset > 0) ? "True" : "False"))
        CImGui.Unindent()
        CImGui.Unindent()
        CImGui.BulletText("The demo data precision is: " * (Sys.WORD_SIZE == 64 ? "double" : "float"))
        CImGui.Separator()
        CImGui.Text("USER GUIDE:")
        ImPlot.ShowUserGuide()
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Configuration")

        CImGui.ShowFontSelector("Font")
        CImGui.ShowStyleSelector("CImGui Style")
        ImPlot.ShowStyleSelector("ImPlot Style")
        ImPlot.ShowColormapSelector("ImPlot Colormap")
        indent = CImGui.CalcItemWidth() - CImGui.GetFrameHeight()
        CImGui.Indent(CImGui.CalcItemWidth() - CImGui.GetFrameHeight())
        # a hack -- works for now
        aaidx = findfirst(x -> x == :AntiAliasedLines, fieldnames(CImGui.ImGuiStyle))
        aaoffset = fieldoffset(CImGui.ImGuiStyle, aaidx)
        CImGui.Checkbox("Anti-Aliased Lines", CImGui.GetStyle() + aaoffset)
        CImGui.Unindent(indent)
    end

    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Line Plots")
        @cstatic(
            xs1 = zeros(Float32, 1001),
            ys1 = zeros(Float32, 1001),
            xs2 = zeros(Float32, 11),
            ys2 = zeros(Float32, 11),
        begin
            for i = 1:1001
                xs1[i] = (i - 1) * 0.001
                ys1[i] = 0.5 + 0.5 * sin(50 * (xs1[i] + DEMO_TIME / 10))
            end
            for i = 1:11
                xs2[i] = (i - 1) * 0.1
                ys2[i] = xs2[i] * xs2[i]
            end
            CImGui.BulletText("Anti-aliasing can be enabled from the Configuration header above.")
            if ImPlot.BeginPlot("Line Plot", "x", "f(x)")
                ImPlot.PlotLine("sin(x)", xs1, ys1, 1001)
                ImPlot.SetNextMarkerStyle(ImPlotMarker_Circle)
                ImPlot.PlotLine("x^2", xs2, ys2, 11)
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Filled Line Plots")
        @cstatic(
            xs1 = zeros(Float64, 101),
            ys1 = zeros(Float64, 101),
            ys2 = zeros(Float64, 101),
            ys3 = zeros(Float64, 101),
            show_lines = true,
            show_fills = true,
            fill_ref = Float32(0.0),
        begin

            Random.seed!(0)

            for i = 1:101
                xs1[i] = (i - 1)
                ys1[i] = RandomRange(400.0, 450.0)
                ys2[i] = RandomRange(275.0, 350.0)
                ys3[i] = RandomRange(150.0, 225.0)
            end

            @c CImGui.Checkbox("Lines", &show_lines); CImGui.SameLine()
            @c CImGui.Checkbox("Fills", &show_fills)
            @c CImGui.DragFloat("Reference", &fill_ref, 1, -100, 500)

            ImPlot.SetNextAxesLimits(0, 100, 0, 500)
            if ImPlot.BeginPlot("Stock Prices", "Days", "Price")
                if show_fills
                    ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
                    ImPlot.PlotShaded("Stock 1", xs1, ys1, 101, fill_ref)
                    ImPlot.PlotShaded("Stock 2", xs1, ys2, 101, fill_ref)
                    ImPlot.PlotShaded("Stock 3", xs1, ys3, 101, fill_ref)
                    ImPlot.PopStyleVar()
                end
                if show_lines
                    ImPlot.PlotLine("Stock 1", xs1, ys1, 101)
                    ImPlot.PlotLine("Stock 2", xs1, ys2, 101)
                    ImPlot.PlotLine("Stock 3", xs1, ys3, 101)
                end
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Shaded Plots##")
        @cstatic(
            xs  = zeros(Float32, 1001),
            ys  = zeros(Float32, 1001),
            ys1 = zeros(Float32, 1001),
            ys2 = zeros(Float32, 1001),
            ys3 = zeros(Float32, 1001),
            ys4 = zeros(Float32, 1001),
            alpha = Float32(0.25),
        begin
            Random.seed!(0)
            for i = 1:1001
                xs[i]  = (i - 1) * 0.001
                ys[i]  = 0.25 + 0.25 * sin(25 * xs[i]) * sin(5 * xs[i]) + RandomRange(-0.01,0.01)
                ys1[i] = ys[i] + RandomRange(0.1, 0.12)
                ys2[i] = ys[i] - RandomRange(0.1, 0.12)
                ys3[i] = 0.75 + 0.2 * sin(25 * xs[i])
                ys4[i] = 0.75 + 0.1 * cos(25 * xs[i])
            end
            @c CImGui.DragFloat("Alpha", &alpha, 0.01, 0, 1)

            if ImPlot.BeginPlot("Shaded Plots", "X-Axis", "Y-Axis")
                ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, alpha)
                ImPlot.PlotShaded("Uncertain Data",xs,ys1,ys2,1001)
                ImPlot.PlotLine("Uncertain Data",xs,ys,1001)
                ImPlot.PlotShaded("Overlapping",xs,ys3,ys4,1001)
                ImPlot.PlotLine("Overlapping",xs,ys3,1001)
                ImPlot.PlotLine("Overlapping",xs,ys4,1001)
                ImPlot.PopStyleVar()
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Scatter Plots")
        Random.seed!(0)
        @cstatic(
            xs1 = zeros(Float32, 100),
            ys1 = zeros(Float32, 100),
            xs2 = zeros(Float32, 50),
            ys2 = zeros(Float32, 50),
        begin
            for i = 1:100
                xs1[i] = (i - 1) * 0.01
                ys1[i] = xs1[i] + 0.1 * rand()
            end
            for i = 1:50
                xs2[i] = 0.25 + 0.2 * rand()
                ys2[i] = 0.75 + 0.2 * rand()
            end

            if ImPlot.BeginPlot("Scatter Plot")
                ImPlot.PlotScatter("Data 1", xs1, ys1, 100)
                ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
                ImPlot.SetNextMarkerStyle(ImPlotMarker_Square, 6, ImVec4(0,1,0,0.5), IMPLOT_AUTO, ImVec4(0,1,0,1))
                ImPlot.PlotScatter("Data 2", xs2, ys2, 50)
                ImPlot.PopStyleVar()
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Stairstep Plots")
        @cstatic ys1 = zeros(Float32, 101) ys2 = zeros(Float32, 101) begin
            for i = 1:101
                ys1[i] = 0.5 + 0.4 * sin(50 * (i - 1) * 0.01)
                ys2[i] = 0.5 + 0.2 * sin(25 * (i - 1) * 0.01)
            end
            if ImPlot.BeginPlot("Stairstep Plot", "x", "f(x)")
                ImPlot.PlotStairs("Signal 1", ys1, 101, 0.01)
                ImPlot.SetNextMarkerStyle(ImPlotMarker_Square, 2.0)
                ImPlot.PlotStairs("Signal 2", ys2, 101, 0.01)
                ImPlot.EndPlot()
            end
        end # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Bar Plots")

        @cstatic(
            horz   = false,
            midtm  = Int8[83, 67, 23, 89, 83, 78, 91, 82, 85, 90],
            final  = Int16[80, 62, 56, 99, 55, 78, 88, 78, 90, 100],
            grade  = Int32[80, 69, 52, 92, 72, 78, 75, 76, 89, 95],
            labels = ["S1","S2","S3","S4","S5","S6","S7","S8","S9","S10"],
            positions = Float64[0,1,2,3,4,5,6,7,8,9],
            begin

                @c CImGui.Checkbox("Horizontal", &horz)

                if horz
                    ImPlot.SetNextAxesLimits(0, 110, -0.5, 9.5, ImGuiCond_Always)
                else
                    ImPlot.SetNextAxesLimits(-0.5, 9.5, 0, 110, ImGuiCond_Always)
                end

                if ImPlot.BeginPlot("Bar Plot", horz ? "Score" :  "Student", horz ? "Student" : "Score",
                                    ImVec2(-1,0), y_flags = horz ? ImPlotAxisFlags_Invert : 0)
                    if horz
                        ImPlot.SetupLegend(ImPlotLocation_West)
                        ImPlot.SetupAxisTicksY(positions, 10, labels)

                        # Upstream ImPlot uses PlotBars() with
                        # ImPlotBarsFlags_Horizontal, but we use PlotBarsH()
                        # here to test our implementation.
                        ImPlot.PlotBarsH("Midterm Exam", midtm; bar_size=0.2, shift=-0.2)
                        ImPlot.PlotBarsH("Final Exam", final; bar_size=0.2, shift=0)
                        ImPlot.PlotBarsH("Course Grade", grade; bar_size=0.2, shift=0.2)
                    else
                        ImPlot.SetupLegend(ImPlotLocation_South, ImPlotLegendFlags_Horizontal)
                        ImPlot.SetupAxisTicksX(positions, 10, labels)

                        ImPlot.PlotBars("Midterm Exam", midtm, 10, 0.2,  -0.2)
                        ImPlot.PlotBars("Final Exam",   final, 10, 0.2,     0)
                        ImPlot.PlotBars("Course Grade", grade, 10, 0.2,   0.2)
                    end
                    ImPlot.EndPlot()
                end
            end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Error Bars")
        @cstatic(
            xs    = Float32[1,2,3,4,5],
            bar   = Float32[1,2,5,3,4],
            lin1  = Float32[8,8,9,7,8],
            lin2  = Float32[6,7,6,9,6],
            err1  = Float32[0.2, 0.4, 0.2, 0.6, 0.4],
            err2  = Float32[0.4, 0.2, 0.4, 0.8, 0.6],
            err3  = Float32[0.09, 0.14, 0.09, 0.12, 0.16],
            err4  = Float32[0.02, 0.08, 0.15, 0.05, 0.2],
        begin

         ImPlot.SetNextAxesLimits(0, 6, 0, 10)
         if ImPlot.BeginPlot("##ErrorBars")

             ImPlot.PlotBars("Bar", xs, bar, 5, 0.5)
             ImPlot.PlotErrorBars("Bar", xs, bar, err1, 5)

             ImPlot.SetNextErrorBarStyle(ImPlot.GetColormapColor(1), 0)
             ImPlot.PlotErrorBars("Line", xs, lin1, err1, err2, 5)
             ImPlot.SetNextMarkerStyle(ImPlotMarker_Circle)
             ImPlot.PlotLine("Line", xs, lin1, 5)

             ImPlot.PushStyleColor(ImPlotCol_ErrorBar, ImPlot.GetColormapColor(2))
             ImPlot.PlotErrorBars("Scatter", xs, lin2, err2, 5)
             ImPlot.PlotErrorBars("Scatter", xs, lin2,  err3, err4, 5, ImPlotErrorBarsFlags_Horizontal)
             ImPlot.PopStyleColor()
             ImPlot.PlotScatter("Scatter", xs, lin2, 5)

             ImPlot.EndPlot()
         end
        end) #cstatic
     end
     if CImGui.CollapsingHeader("Stem Plots##")
         @cstatic xs = zeros(Float64, 51) ys1 = zeros(Float64, 51) ys2 = zeros(Float64, 51) begin
         for i = 1:51
             xs[i] = (i - 1) * 0.02
             ys1[i] = 1.0 + 0.5 * sin(25*xs[i]) * cos(2*xs[i])
             ys2[i] = 0.5 + 0.25  * sin(10*xs[i]) * sin(xs[i])
         end
         ImPlot.SetNextAxesLimits(0,1,0,1.6)
         if ImPlot.BeginPlot("Stem Plots")

             ImPlot.PlotStems("Stems 1", xs, ys1, 50)

             ImPlot.SetNextLineStyle(ImVec4(1,0.5,0,0.75))
             ImPlot.SetNextMarkerStyle(ImPlotMarker_Square,5,ImVec4(1,0.5,0,0.25))
             ImPlot.PlotStems("Stems 2", xs, ys2, 50)

             ImPlot.EndPlot()
         end
        end #cstatic
     end
     #-------------------------------------------------------------------------
     if CImGui.CollapsingHeader("Pie Charts")
         @cstatic(
            labels1 = ["Frogs","Hogs","Dogs","Logs"],
            data1 = Float32[0.15,  0.30,  0.2, 0.05],
            normalize = false,
            labels2 = ["A","B","C","D","E"],
            data2 = [1,1,2,3,5],
            begin
                CImGui.SetNextItemWidth(250)
                @c CImGui.DragFloat4("Values", data1, 0.01, 0, 1)
                if (data1[1] + data1[2] + data1[3] + data1[4]) < 1
                    CImGui.SameLine()
                    @c CImGui.Checkbox("Normalize", &normalize)
                end

                ImPlot.SetNextAxesLimits(0,1,0,1,ImGuiCond_Always)
                if ImPlot.BeginPlot("##Pie1", "", "", ImVec2(250,250),
                                    flags = ImPlotFlags_NoMouseText,
                                    y_flags = ImPlotAxisFlags_NoDecorations,
                                    y2_flags = ImPlotAxisFlags_NoDecorations)

                    piechart_normalize = normalize ? ImPlotPieChartFlags_Normalize : ImPlotPieChartFlags_None
                    ImPlot.PlotPieChart(labels1, data1, 4, 0.5, 0.5, 0.4, "%.2f", 90, piechart_normalize)
                    ImPlot.EndPlot()
                end

                CImGui.SameLine()

                ImPlot.PushColormap(ImPlotColormap_Pastel)
                ImPlot.SetNextAxesLimits(0,1,0,1,ImGuiCond_Always)
                if ImPlot.BeginPlot("##Pie2", "", "", ImVec2(250,250),
                                    flags = ImPlotFlags_NoMouseText,
                                    y_flags = ImPlotAxisFlags_NoDecorations,
                                    y2_flags = ImPlotAxisFlags_NoDecorations)

                    ImPlot.PlotPieChart(labels2, data2, 5, 0.5, 0.5, 0.4, "%.0f", 180, ImPlotPieChartFlags_Normalize)
                    ImPlot.EndPlot()
                end
                ImPlot.PopColormap()
            end) # cstatic
     end
     #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Heatmaps")
        @cstatic(
            # this might need transpose + collect to match C++ precisely
            values1 = Float32[0.8 2.4 2.5 3.9 0.0 4.0 0.0;
                              2.4 0.0 4.0 1.0 2.7 0.0 0.0;
                              1.1 2.4 0.8 4.3 1.9 4.4 0.0;
                              0.6 0.0 0.3 0.0 3.1 0.0 0.0;
                              0.7 1.7 0.6 2.6 2.2 6.2 0.0;
                              1.3 1.2 0.0 0.0 0.0 3.2 5.1;
                              0.1 2.0 0.0 1.4 0.0 1.9 6.3],
                scale_min = Float32(0),
                scale_max = Float32(6.3),
                xlabels = ["C1","C2","C3","C4","C5","C6","C7"],
                ylabels = ["R1","R2","R3","R4","R5","R6","R7"],
                map = Cint(ImPlot.ImPlotColormap_Viridis),
                axes_flags = ImPlotAxisFlags_Lock | ImPlotAxisFlags_NoGridLines | ImPlotAxisFlags_NoTickMarks,
                values2 = zeros(Float64, 100*100),
                gray = [ImVec4(0,0,0,1), ImVec4(1,1,1,1)],
                begin

         if ImPlot.ColormapButton(ImPlot.GetColormapName(map), ImVec2(225,0), map)
             map = (map + 1) % Cint(ImPlot.GetColormapCount())
             ImPlot.BustColorCache("##Heatmap1")
             ImPlot.BustColorCache("##Heatmap2")
         end
         CImGui.SameLine()
         CImGui.LabelText("##Colormap Index", "Change Colormap")
         CImGui.SetNextItemWidth(225)
         @c CImGui.DragFloatRange2("Min / Max",&scale_min, &scale_max, 0.01, -20, 20)

         ImPlot.PushColormap(map)

         if ImPlot.BeginPlot("##Heatmap1", "", "",ImVec2(225,225),
                             flags = ImPlotFlags_NoLegend | ImPlotFlags_NoMouseText,
                             x_flags = axes_flags, y_flags = axes_flags)
             ImPlot.SetupAxisTicksX(0 + 1.0/14.0, 1 - 1.0/14.0, 7, xlabels)
             ImPlot.SetupAxisTicksY(1 - 1.0/14.0, 0 + 1.0/14.0, 7, ylabels)

             ImPlot.PlotHeatmap("heat",values1, 7, 7, scale_min, scale_max)
             ImPlot.EndPlot()
         end

         CImGui.SameLine()
         ImPlot.ColormapScale("##HeatScale", scale_min, scale_max, ImVec2(60,225))

         CImGui.SameLine()

         values2 .= rand(100*100)

         ImPlot.SetNextAxesLimits(-1,1,-1,1)
         if ImPlot.BeginPlot("##Heatmap2", "", "", ImVec2(225,225),
             x_flags = ImPlotAxisFlags_NoDecorations,
             y_flags = ImPlotAxisFlags_NoDecorations)

             ImPlot.PlotHeatmap("heat1", values2,100,100,0,1, "")
             ImPlot.PlotHeatmap("heat2", values2,100,100,0,1, "",ImPlotPoint(-1,-1),ImPlotPoint(0,0))
             ImPlot.EndPlot()
         end
         ImPlot.PopColormap()
        end) # cstatic
     end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Images")
        CImGui.BulletText("Below we are displaying the font texture, which is the only texture we have\naccess to in this demo.")
        CImGui.BulletText("Use the 'ImTextureID' type as storage to pass pointers or identifiers to your\nown texture data.")
        CImGui.BulletText("See ImGui Wiki page 'Image Loading and Displaying Examples'.")
        @cstatic(
            bmin = ImVec2(0,0),
            bmax = ImVec2(1,1),
            uv0 = ImVec2(0,0),
            uv1 = ImVec2(1,1),
            tint = ImVec4(1,1,1,1),
        begin

            bmin_ref, bmax_ref, uv0_ref, uv1_ref, tint_ref = Ref(bmin), Ref(bmax), Ref(uv0), Ref(uv1), Ref(tint)

            CImGui.SliderFloat2("Min", pointer_from_objref(bmin_ref), -2, 2, "%.1f")
            CImGui.SliderFloat2("Max", pointer_from_objref(bmax_ref), -2, 2, "%.1f")
            CImGui.SliderFloat2("UV0", pointer_from_objref(uv0_ref), -2, 2, "%.1f")
            CImGui.SliderFloat2("UV1", pointer_from_objref(uv1_ref), -2, 2, "%.1f")
            CImGui.ColorEdit4("Tint",  pointer_from_objref(tint_ref))

            bmin, bmax, uv0, uv1, tint = bmin_ref[], bmax_ref[], uv0_ref[], uv1_ref[], tint_ref[]

            if ImPlot.BeginPlot("##image", "", "")
                ImPlot.PlotImage("my image", unsafe_load(unsafe_load(CImGui.GetIO().Fonts).TexID),
                                 ImPlotPoint(bmin), ImPlotPoint(bmax), uv0, uv1, tint)
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Realtime Plots")
        CImGui.BulletText("Move your mouse to change the data!")
        CImGui.BulletText("This example assumes 60 FPS. Higher FPS requires larger buffer size.")
        @cstatic(
            sdata1 = ScrollingBuffer(),
            sdata2 = ScrollingBuffer(),
            rdata1 = RollingBuffer(),
            rdata2 = RollingBuffer(),
            t = Float32(0),
            history = Float32(10.0),
            rt_axis = ImPlotAxisFlags_NoTickLabels,
        begin
            mouse = CImGui.GetMousePos()
            t += unsafe_load(CImGui.GetIO().DeltaTime)
            AddPoint(sdata1, t, mouse.x * 0.0005)
            AddPoint(rdata1, t, mouse.x * 0.0005)
            AddPoint(sdata2, t, mouse.y * 0.0005)
            AddPoint(rdata2, t, mouse.y * 0.0005)

            @c CImGui.SliderFloat("History",&history,1,30,"%.1f s")
            rdata1.span = history
            rdata2.span = history

            ImPlot.SetNextAxisLimitsX(t - history, t, ImGuiCond_Always)
            if ImPlot.BeginPlot("##Scrolling", "", "", ImVec2(-1,150);
                flags = 0, x_flags = rt_axis, y_flags = rt_axis | ImPlotAxisFlags_LockMin)
                ImPlot.PlotShaded("Data 1", sdata1.data, :x, :y, 0)
                ImPlot.PlotLine("Data 2", sdata2.data, :x, :y;)
                ImPlot.EndPlot()
            end
            ImPlot.SetNextAxisLimitsX(0, history, ImGuiCond_Always)
            if ImPlot.BeginPlot("##Rolling", "", "", ImVec2(-1,150);
                flags = 0, x_flags = rt_axis, y_flags = rt_axis)
                ImPlot.PlotLine("Data 1", rdata1.data, :x, :y)
                ImPlot.PlotLine("Data 2", rdata2.data, :x, :y)
                ImPlot.EndPlot()
            end
        end) # @cstatic
    end
#     #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Markers and Text")
            mk_size_ptr = ImPlot.GetStyle().MarkerSize
            mk_weight_ptr = ImPlot.GetStyle().MarkerWeight

            CImGui.DragFloat("Marker Size", mk_size_ptr, 0.1,2.0,10.0,"%.2f px")
            CImGui.DragFloat("Marker Weight", mk_weight_ptr, 0.05,0.5,3.0,"%.2f px")

            mk_size = unsafe_load(mk_size_ptr)
            mk_weight = unsafe_load(mk_weight_ptr)

            ImPlot.SetNextAxesLimits(0, 10, 0, 12)
            if ImPlot.BeginPlot("##MarkerStyles", "", "", ImVec2(-1,0);
                                flags = ImPlotFlags_CanvasOnly,
                                x_flags = ImPlotAxisFlags_NoDecorations,
                                y_flags = ImPlotAxisFlags_NoDecorations)

                xs = Int8[1,4]
                ys = Int8[10,11]

                # filled markers
                for m = 0:(ImPlotMarker_COUNT - 1)
                    CImGui.PushID(m)
                    ImPlot.SetNextMarkerStyle(m, mk_size, IMPLOT_AUTO_COL, mk_weight)
                    ImPlot.PlotLine("##Filled", xs, ys, 2)
                    CImGui.PopID()
                    ys[1]-=1; ys[2]-=1
                end
                xs[1] = 6; xs[2] = 9; ys[1] = 10; ys[2] = 11
                # open markers
                for m in 0:(ImPlotMarker_COUNT - 1)
                    CImGui.PushID(m)
                    ImPlot.SetNextMarkerStyle(m, mk_size, ImVec4(0,0,0,0), mk_weight)
                    ImPlot.PlotLine("##Open", xs, ys, 2)
                    CImGui.PopID()
                    ys[1]-=1; ys[2]-=1
                end

                ImPlot.PlotText("Filled Markers", 2.5, 6.0)
                ImPlot.PlotText("Open Markers",   7.5, 6.0)

                ImPlot.PushStyleColor(ImPlotCol_InlayText, ImVec4(1,0,1,1))
                ImPlot.PlotText("Vertical Text", 5.0, 6.0, ImVec2(0, 0), ImPlotTextFlags_Vertical)
                ImPlot.PopStyleColor()

                ImPlot.EndPlot()
            end
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Log Scale")
        @cstatic(
            xs  = zeros(Float64, 1001),
            ys1 = zeros(Float64, 1001),
            ys2 = zeros(Float64, 1001),
            ys3 = zeros(Float64, 1001),
        begin
            for i = 1:1001
                xs[i]  = (i - 1)*0.1
                ys1[i] = sin(xs[i]) + 1
                ys2[i] = log(xs[i])
                ys3[i] = 10.0^xs[i]
            end
            CImGui.BulletText("Open the plot context menu (right click) to change scales.")

            ImPlot.SetNextAxesLimits(0.1, 100, 0, 10)
            if ImPlot.BeginPlot("Log Plot")
                ImPlot.SetupAxisScale(ImPlot.ImAxis_X1, ImPlot.ImPlotScale_Log10)
                ImPlot.PlotLine("f(x) = x", xs, xs, 1001)
                ImPlot.PlotLine("f(x) = sin(x)+1", xs, ys1, 1001)
                ImPlot.PlotLine("f(x) = log(x)", xs, ys2, 1001)
                ImPlot.PlotLine("f(x) = 10^x", xs, ys3, 21)
                ImPlot.EndPlot()
            end
        end)
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Time Formatted Axes")

        CImGui.BulletText("When ImPlotAxisFlags_Time is enabled on the X-Axis, values are "
                          * "interpreted as\nUNIX timestamps in seconds and axis labels are"
                          * " formated as date/time.")
        CImGui.BulletText("By default, labels are in UTC time but can be set to use local "
                          * "time instead.")

        @cstatic(
            use_local_time = false,
            use_ISO8601 = false,
            use_24hour_clock = false,
        begin
            CImGui.Checkbox("Local Time", ImPlot.GetStyle().UseLocalTime)
            CImGui.SameLine()
            CImGui.Checkbox("ISO 8601", ImPlot.GetStyle().UseISO8601)
            CImGui.SameLine()
            CImGui.Checkbox("24 Hour Clock", ImPlot.GetStyle().Use24HourClock)
        end)

        @cstatic(
            t_min = parse(DateTime, "01/01/2021 @ 12:00:00am", dateformat"dd/mm/yyyy @ HH:MM:SSp") |> datetime2unix, # <-- should update this each year, so `now` point is visible
            t_max = parse(DateTime, "01/01/2022 @ 12:00:00am", dateformat"dd/mm/yyyy @ HH:MM:SSp") |> datetime2unix,
            data::Union{Nothing, Huge.TimeData} = nothing,
        begin
            if data === nothing
                CImGui.SameLine()
                if CImGui.Button("Generate Huge Data (~500MB!)")
                    data = Huge.TimeData(t_min)
                end
            end

            ImPlot.SetNextAxesLimits(t_min,t_max,0,1)
            if ImPlot.BeginPlot("##Time")
                ImPlot.SetupAxisScale(ImPlot.ImAxis_X1, ImPlot.ImPlotScale_Time)

                if data !== nothing
                    # downsample our data
                    #downsample = trunc(Int, ImPlot.GetPlotLimits().X.Size() / 1000 + 1) # Note: implot Size() method not wrapped
                    downsample = trunc(Int, (ImPlot.GetPlotLimits().X.Max - ImPlot.GetPlotLimits().X.Min) / 1000 + 1)
                    start = trunc(Int, ImPlot.GetPlotLimits().X.Min - t_min)
                    start = start < 0 ? 0 : start > Huge.SIZE - 1 ? Huge.SIZE - 1 : start
                    end_ = trunc(Int, (ImPlot.GetPlotLimits().X.Max - t_min) + 1000)
                    end_ = end_ < 0 ? 0 : end_ > Huge.SIZE - 1 ? Huge.SIZE - 1 : end_
                    size = (end_ - start) ÷ downsample
                    # plot it
                    #! why `offset = start` is not working properly (always plots from first element?)
                    ImPlot.PlotLine("Time Series", data.ts, data.ys, count = size, offset = start, stride = downsample)
                end
                # plot time now
                t_now = now() |> datetime2unix
                y_now = Huge.GetY(t_now)
                ImPlot.PlotScatter("Now", [t_now], [y_now])

                ImPlot.Annotation(t_now,y_now,ImPlot.GetLastItemColor(),ImVec2(10,10),"Now")
                ImPlot.EndPlot()
            end
        end)

    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Multiple Y-Axes")
        @cstatic(
            xs = zeros(Float32, 1001),
            xs2 = zeros(Float32, 1001),
            ys1 = zeros(Float32, 1001),
            ys2 = zeros(Float32, 1001),
            ys3 = zeros(Float32, 1001),
            y2_axis = true,
            y3_axis = true,
        begin
            for i = 1:1001
                xs[i]  = i*0.1
                ys1[i] = sin(xs[i]) * 3 + 1
                ys2[i] = cos(xs[i]) * 0.2 + 0.5
                ys3[i] = sin(xs[i]+0.5) * 100 + 200
                xs2[i] = xs[i] + 10.0
            end

            @c CImGui.Checkbox("Y-Axis 2", &y2_axis)
            CImGui.SameLine()
            @c CImGui.Checkbox("Y-Axis 3", &y3_axis)
            CImGui.SameLine()

            # you can fit axes programatically
            CImGui.SameLine(); if CImGui.Button("Fit X")  ImPlot.SetNextAxisToFit(ImPlot.ImAxis_X1) end
            CImGui.SameLine(); if CImGui.Button("Fit Y")  ImPlot.SetNextAxisToFit(ImPlot.ImAxis_Y1) end
            CImGui.SameLine(); if CImGui.Button("Fit Y2") ImPlot.SetNextAxisToFit(ImPlot.ImAxis_Y2) end
            CImGui.SameLine(); if CImGui.Button("Fit Y3") ImPlot.SetNextAxisToFit(ImPlot.ImAxis_Y3) end

            ImPlot.SetNextAxesLimits(0.1, 100, 0, 10)
            ImPlot.SetNextAxisLimits(ImPlot.ImAxis_Y2, 0, 1, ImGuiCond_Once)
            ImPlot.SetNextAxisLimits(ImPlot.ImAxis_Y3, 0, 300, ImGuiCond_Once)
            if ImPlot.BeginPlot("Multi-Axis Plot", "X-Axis 1", "Y-Axis 1")
                if y2_axis
                    ImPlot.SetupAxis(ImPlot.ImAxis_Y2, "Y-Axis 2", ImPlotAxisFlags_AuxDefault)
                end
                if y3_axis
                    ImPlot.SetupAxis(ImPlot.ImAxis_Y3, "Y-Axis 3", ImPlotAxisFlags_AuxDefault)
                end

                ImPlot.PlotLine("f(x) = x", xs, xs)
                ImPlot.PlotLine("f(x) = sin(x)*3+1", xs, ys1)
                if y2_axis
                    ImPlot.SetAxes(ImPlot.ImAxis_X1, ImPlot.ImAxis_Y2)
                    ImPlot.PlotLine("f(x) = cos(x)*.2+.5 (Y2)", xs, ys2)
                end
                if y3_axis
                    ImPlot.SetAxes(ImPlot.ImAxis_X1, ImPlot.ImAxis_Y3)
                    ImPlot.PlotLine("f(x) = sin(x+.5)*100+200 (Y3)", xs2, ys3)
                end
                ImPlot.EndPlot()
            end
        end)
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Linked Axes")
        @cstatic(
            xmin = Ref(0.0), xmax = Ref(1.0), ymin = Ref(0.0), ymax = Ref(1.0),
            linkx = true, linky = true,
        begin
            data = [0, 1]
            @c CImGui.Checkbox("Link X", &linkx)
            CImGui.SameLine()
            @c CImGui.Checkbox("Link Y", &linky)

            #! @c macro violates requirement for LinkNextPlotLimits:
            # "The pointer data must remain valid until the matching call to EndPlot."
            #  We therefore use Refs for plot limits instead
            if linkx
                ImPlot.SetNextAxisLinks(ImPlot.ImAxis_X1, xmin, xmax)
            end
            if linky
                ImPlot.SetNextAxisLinks(ImPlot.ImAxis_Y1, ymin, ymax)
            end

            if ImPlot.BeginPlot("##Plot A")
                ImPlot.PlotLine("Line", data)
                ImPlot.EndPlot()
            end

            if linkx
                ImPlot.SetNextAxisLinks(ImPlot.ImAxis_X1, xmin, xmax)
            end
            if linky
                ImPlot.SetNextAxisLinks(ImPlot.ImAxis_Y1, ymin, ymax)
            end

            if ImPlot.BeginPlot("##Plot B")
                ImPlot.PlotLine("Line", data)
                ImPlot.EndPlot()
            end
        end) # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Equal Axes")
        @cstatic xs = zeros(Float64, 1000) ys = zeros(Float64, 1000) begin
            for i = 1:1000
                angle = i * 2 * pi / 999.0
                xs[i] = cos(angle)
                ys[i] = sin(angle)
            end
            ImPlot.SetNextAxesLimits(-1,1,-1,1)
            if ImPlot.BeginPlot("", flags = ImPlotFlags_Equal)
                ImPlot.PlotLine("Circle", xs, ys)
                ImPlot.EndPlot()
            end
        end # cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Querying")
        @cstatic(
            data = ImPlotPoint[],
            range = ImPlotRect(),
            # rect = ImPlotRect(-0.1, 0.1, 0.1, -0.1),
            x1 = Ref(-0.1),
            y1 = Ref(0.1),
            x2 = Ref(0.1),
            y2 = Ref(-0.1),
        begin
            CImGui.BulletText("Ctrl + click in the plot area to draw points.")
            CImGui.BulletText("Middle click (or Ctrl + right click) and drag to create a query rect.")
            CImGui.Indent()
                CImGui.BulletText("Hold Alt to expand query horizontally.")
                CImGui.BulletText("Hold Shift to expand query vertically.")
                CImGui.BulletText("The query rect can be dragged after it's created.")
            CImGui.Unindent()

            if ImPlot.BeginPlot("##Drawing",
                                x_flags = ImPlotAxisFlags_NoDecorations,
                                y_flags = ImPlotAxisFlags_NoDecorations)

                if ImPlot.IsPlotHovered() && CImGui.IsMouseClicked(0) && unsafe_load(CImGui.GetIO().KeyCtrl)
                    pt = ImPlot.GetPlotMousePos()
                    push!(data, pt)
                end
                if length(data) > 0
                    ImPlot.PlotScatter("Points", data, :x, :y)

                    cnt = 0
                    sum_x, sum_y = 0.0, 0.0
                    rect = ImPlotRect(minmax(x1[], x2[])..., minmax(y1[], y2[])...)

                    for i = 1:length(data)
                        if ImPlot.Contains(Ref(rect), data[i].x, data[i].y)
                            sum_x += data[i].x
                            sum_y += data[i].y
                            cnt += 1
                        end
                    end

                    if cnt > 0
                        ImPlot.SetNextMarkerStyle(ImPlotMarker_Square)
                        ImPlot.PlotScatter("Average", [sum_x / cnt], [sum_y / cnt])
                    end
                end

                ImPlot.DragRect(0, x1, y1, x2, y2, ImVec4(1, 0, 1, 0.5))
                range = ImPlot.GetPlotLimits()
                ImPlot.EndPlot()
            end
            CImGui.Text(@sprintf("The current plot limits are:  [%g,%g,%g,%g]", range.X.Min, range.X.Max, range.Y.Min, range.Y.Max))
            CImGui.Text(@sprintf("The current rect limits are: [%g,%g,%g,%g]", x1[], x2[], y1[], y2[]))

        end) #cstatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Views")
        # mimic's soulthread's imgui_plot demo
        @cstatic(
            x_data = zeros(Float32, 512),
            y_data1 = zeros(Float32, 512),
            y_data2 = zeros(Float32, 512),
            y_data3 = zeros(Float32, 512),
            sampling_freq = 44100.0f0,
            freq = 500.0f0,
            x1 = Ref(0.0),
            y1 = Ref(0.0),
            x2 = Ref(0.0),
            y2 = Ref(0.0),
        begin
            # Initialize data
            if all(iszero.(x_data))
                for i = 1:512
                    t = i / sampling_freq
                    x_data[i] = t
                    arg = 2 * 3.14f0 * freq * t
                    y_data1[i] = sin(arg)
                    y_data2[i] = y_data1[i] * -0.6 + sin(2 * arg) * 0.4
                    y_data3[i] = y_data2[i] * -0.6 + sin(3 * arg) * 0.4
                end

                x1[] = x_data[length(x_data) ÷ 4]
                x2[] = x1[] * 3
                y1[] = maximum(y_data1) / 4
                y2[] = y1[] * 3
            end

            CImGui.BulletText("Query the first plot to render a subview in the second plot (see above for controls).")
            ImPlot.SetNextAxesLimits(0,0.01,-1,1)
            flags = ImPlotAxisFlags_NoTickLabels
            # query = ImPlotRect(ImPlotRange(0,0), ImPlotRange(0,0)) #? defaults
            if ImPlot.BeginPlot("##View1","","",ImVec2(-1,150);
                                x_flags = flags, y_flags = flags)
                ImPlot.PlotLine("Signal 1", x_data, y_data1)
                ImPlot.PlotLine("Signal 2", x_data, y_data2)
                ImPlot.PlotLine("Signal 3", x_data, y_data3)
                ImPlot.DragRect(0, x1, y1, x2, y2, ImVec4(1, 0, 1, 0.5))
                ImPlot.EndPlot()
            end

            ImPlot.SetNextAxesLimits(x1[], x2[], y1[], y2[], ImGuiCond_Always)
            if ImPlot.BeginPlot("##View2","","",ImVec2(-1,150);
                                flags = ImPlotFlags_CanvasOnly,
                                x_flags = ImPlotAxisFlags_NoDecorations,
                                y_flags = ImPlotAxisFlags_NoDecorations)
                ImPlot.PlotLine("Signal 1", x_data, y_data1)
                ImPlot.PlotLine("Signal 2", x_data, y_data2)
                ImPlot.PlotLine("Signal 3", x_data, y_data3)
                ImPlot.EndPlot()
            end
        end)
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Legend")
        @cstatic(
            # FIXME: Check if something simpler can be used with CheckboxFlags
            loc = Ref(Cint(ImPlotLocation_East)),
            h = false,
            o = true,
            data1 = Ref(MyImPlot.WaveData(0.001, 0.2, 2, 0.75)),
            data2 = Ref(MyImPlot.WaveData(0.001, 0.2, 4, 0.25)),
            data3 = Ref(MyImPlot.WaveData(0.001, 0.2, 6, 0.5)),
        begin

            CImGui.CheckboxFlags("North", loc, ImPlotLocation_North); CImGui.SameLine()
            CImGui.CheckboxFlags("South", loc, ImPlotLocation_South); CImGui.SameLine()
            CImGui.CheckboxFlags("West",  loc, ImPlotLocation_West);  CImGui.SameLine()
            CImGui.CheckboxFlags("East",  loc, ImPlotLocation_East);  CImGui.SameLine()

            @c CImGui.Checkbox("Horizontal", &h); CImGui.SameLine()
            @c CImGui.Checkbox("Outside", &o)

            CImGui.SliderFloat2("LegendPadding", ImPlot.GetStyle().LegendPadding, 0.0, 20.0, "%.0f")
            CImGui.SliderFloat2("LegendInnerPadding", ImPlot.GetStyle().LegendInnerPadding, 0.0, 10.0, "%.0f")
            CImGui.SliderFloat2("LegendSpacing", ImPlot.GetStyle().LegendSpacing, 0.0, 5.0, "%.0f")

            sinewave_c = @cfunction(MyImPlot.SineWave, Cvoid, (Ptr{Cvoid}, Cint,
            Ptr{ImPlotPoint}))
            sawwave_c = @cfunction(MyImPlot.SawWave, Cvoid, (Ptr{Cvoid}, Cint,
            Ptr{ImPlotPoint}))

            GC.@preserve sinewave_c sawwave_c begin

            if ImPlot.BeginPlot("##Legend","x","y",ImVec2(-1,0))
                legend_flags = h ? ImPlotLegendFlags_Horizontal : ImPlotLegendFlags_None
                legend_flags |= o ? ImPlotLegendFlags_Outside : ImPlotLegendFlags_None
                ImPlot.SetupLegend(loc[], legend_flags)

                ImPlot.PlotLineG("Item 1", sinewave_c, data1, 1000)        # "Item 1" added to legend
                ImPlot.PlotLineG("Item 2##IDText", sawwave_c, data2, 1000) # "Item 2" added to legend, text after ## used for ID only
                ImPlot.PlotLineG("##NotListed", sawwave_c, data3, 1000)    # plotted, but not added to legend
                ImPlot.PlotLineG("Item 3", sinewave_c, data1, 1000)        # "Item 3" added to legend
                ImPlot.PlotLineG("Item 3", sawwave_c, data2, 1000)         # combined with previous "Item 3"
                ImPlot.EndPlot()
            end
            end
        end)
    end
#-------------------------------------------------------------------------
     if CImGui.CollapsingHeader("Drag Lines and Points")
         CImGui.BulletText("Click and drag the horizontal and vertical lines.")
         @cstatic(x1 = 0.2,
                  x2 = 0.8,
                  y1 = 0.25,
                  y2 = 0.75,
                  f = 0.1,
                  clamp = false,
                  P = ImPlotPoint[ImPlotPoint(.05,.05), ImPlotPoint(0.2,0.4),  ImPlotPoint(0.8,0.6),  ImPlotPoint(.95,.95)],
                  B = Vector{ImPlotPoint}(undef, 100),
                  begin
         if ImPlot.BeginPlot("##guides"; y2_flags = ImPlotAxisFlags_None)
             color = ImVec4(1, 1, 1, 1)
             @c ImPlot.DragLineX(0, &x1, color)
             @c ImPlot.DragLineX(1, &x2, color)
             @c ImPlot.DragLineY(2, &y1, color)
             @c ImPlot.DragLineY(3, &y2, color)

             xs = Vector{Float64}(undef, 1000)
             ys = Vector{Float64}(undef, 1000)

             for i = 1:1000
                 xs[i] = (x2 + x1)/2 + abs(x2 - x1) * (i/1000.0 - 0.5)
                 ys[i] = (y1 + y2)/2 + abs(y2 - y1)/2 * sin(f * i/10)
             end

             ImPlot.PlotLine("Interactive Data", xs, ys, 1000)
             ImPlot.SetAxis(ImPlot.ImAxis_Y2)
             @c ImPlot.DragLineY(0, &f, ImVec4(1,0.5,1,1))
             ImPlot.EndPlot()
         end

         CImGui.BulletText("Click and drag any point.")
         flags = ImPlotAxisFlags_NoTickLabels | ImPlotAxisFlags_NoTickMarks

         if ImPlot.BeginPlot("##Bezier", flags = ImPlotFlags_CanvasOnly, x_flags = flags, y_flags = flags)

             for i = 1:100
                 t  = (i - 1) / 99.0
                 u  = 1. - t
                 w1 = u*u*u
                 w2 = 3*u*u*t
                 w3 = 3*u*t*t
                 w4 = t*t*t
                 B[i] = ImPlotPoint(w1*P[1].x + w2*P[2].x + w3*P[3].x + w4*P[4].x,
                                    w1*P[1].y + w2*P[2].y + w3*P[3].y + w4*P[4].y)
             end
             yoff = fieldoffset(ImPlotPoint, 2)

             ImPlot.SetNextLineStyle(ImVec4(0,0.9,0,1), 2)
             ImPlot.PlotLine("##bez", Ptr{Float64}(pointer(B)), Ptr{Float64}(pointer(B) + yoff), 100, 0, 0, sizeof(ImPlotPoint))
             ImPlot.SetNextLineStyle(ImVec4(1,0.5,1,1))
             ImPlot.PlotLine("##h1", Ptr{Float64}(pointer(P)), Ptr{Float64}(pointer(P) + yoff), 2, 0, 0, sizeof(ImPlotPoint))
             ImPlot.SetNextLineStyle(ImVec4(0,0.5,1,1))
             ImPlot.PlotLine("##h2", Ptr{Float64}(pointer(P,3)), Ptr{Float64}(pointer(P,3) + yoff), 2, 0, 0, sizeof(ImPlotPoint))

             ImPlot.DragPoint(0, Ptr{Float64}(pointer(P)), Ptr{Float64}(pointer(P) + yoff), ImVec4(0,0.9,0,1))
             ImPlot.DragPoint(1, Ptr{Float64}(pointer(P, 2)), Ptr{Float64}(pointer(P,2) + yoff), ImVec4(1,0.5,1,1))
             ImPlot.DragPoint(2, Ptr{Float64}(pointer(P,3)), Ptr{Float64}(pointer(P,3) + yoff), ImVec4(0,0.5,1,1))
             ImPlot.DragPoint(3, Ptr{Float64}(pointer(P,4)), Ptr{Float64}(pointer(P,4) + yoff), ImVec4(0,0.9,0,1))

             ImPlot.EndPlot()
         end
     end) # cstatic
     end
     if CImGui.CollapsingHeader("Annotations")
         @cstatic(
                  p = Float32[0.25, 0.25, 0.75, 0.75, 0.25],
                  clamp = false,
                  begin

         @c CImGui.Checkbox("Clamp", &clamp)
         ImPlot.SetNextAxesLimits(0,2,0,1)

         if ImPlot.BeginPlot("##Annotations")

             ImPlot.PlotScatter("##Points", p, Ref(p,2), 4)

             col = ImPlot.GetLastItemColor()

             clamp ? ImPlot.AnnotationClamped(0.25,0.25,col,ImVec2(-15,15),"BL") : ImPlot.Annotation(0.25,0.25,col,ImVec2(-15,15),"BL")
             clamp ? ImPlot.AnnotationClamped(0.75,0.25,col,ImVec2(15,15),"BR") : ImPlot.Annotation(0.75,0.25,col,ImVec2(15,15),"BR")
             clamp ? ImPlot.AnnotationClamped(0.75,0.75,col,ImVec2(15,-15),"TR") : ImPlot.Annotation(0.75,0.75,col,ImVec2(15,-15),"TR")
             clamp ? ImPlot.AnnotationClamped(0.25,0.75,col,ImVec2(-15,-15),"TL") : ImPlot.Annotation(0.25,0.75,col,ImVec2(-15,-15),"TL")
             clamp ? ImPlot.AnnotationClamped(0.5,0.5,col,ImVec2(0,0),"Center") : ImPlot.Annotation(0.5,0.5,col,ImVec2(0,0),"Center")

             bx = Float32[1.2, 1.5, 1.8]
             by = Float32[0.25, 0.5, 0.75]

             ImPlot.PlotBars("##Bars",bx,by,3,0.2)
             for i = 1:3
                 ImPlot.Annotation(bx[i],by[i],ImVec2(0,-5),@sprintf("B[%d]=%.2f",i,by[i]))
             end
             ImPlot.EndPlot()
         end
     end) # cstatic
     end
     #-------------------------------------------------------------------------
     # FIXME: BROKEN
     #=
     if CImGui.CollapsingHeader("Drag and Drop") #! this section is reworked in upstream versions
        Random.seed!(trunc(Int, 10000000 * DEMO_TIME))
        @cstatic(
            init = true,
            K_CHANNELS = 9,
            paused = false,
            data = ScrollingBuffer[],
            show = nothing,
            yAxis = nothing,
            t = Float32(0),
        begin
            if init # workaround for cstatic initialization
                init = false
                show = falses(K_CHANNELS)
                yAxis = zeros(Int, K_CHANNELS)
                for i = 1:K_CHANNELS
                    push!(data, ScrollingBuffer()) #? does Julia have simpler syntax to initialize an array of mutable pobjects?
                end
            end
            CImGui.BulletText("Drag data items from the left column onto the plot or onto a specific y-axis.")
            CImGui.BulletText("Redrag data items from the legend onto other y-axes.")
            CImGui.BeginGroup()
            if CImGui.Button("Clear", ImVec2(100, 0))
                for i = 1:K_CHANNELS
                    show[i] = false
                    Erase(data[i])
                    #empty!(.data)
                    #data[i].Offset = 0
                end
            end
            if CImGui.Button(paused ? "Resume" : "Pause", ImVec2(100,0))
                paused = !paused
            end
            for i = 1:K_CHANNELS
                label = show[i] ? "data_$i (Y$(yAxis[i]))" : "data_$i"
                CImGui.Selectable(label, false, 0, ImVec2(100, 0))
                if ImPlot.BeginDragDropSourceItem(label, ImGuiDragDropFlags_None)
                    @c CImGui.SetDragDropPayload("DND_PLOT", &i, sizeof(Int))
                    CImGui.TextUnformatted(label)
                    CImGui.EndDragDropSource()
                end
            end
            CImGui.EndGroup()
            CImGui.SameLine()
            Random.seed!(trunc(Int, 10000000 * DEMO_TIME))

            if !paused
                t += unsafe_load(CImGui.GetIO().DeltaTime)
                for i = 1:K_CHANNELS
                    if show[i]
                        AddPoint(data[i], t, (i+1)*0.1 + rand(-0.01 : 0.000001 : 0.01))
                    end
                end
            end

            ImPlot.SetNextAxisLimitsX(t - 10, t, paused ? ImGuiCond_Once : ImGuiCond_Always)
            if ImPlot.BeginPlot("##DND", "", "", ImVec2(-1,0);
                                flags = ImPlotFlags_YAxis2 | ImPlotFlags_YAxis3,
                                x_flags = ImPlotAxisFlags_NoTickLabels)

                for i = 1:K_CHANNELS
                    if show[i] && length(data[i].data) > 0
                        label = "data_$i"
                        ImPlot.SetPlotYAxis(yAxis[i])
                        ImPlot.PlotLine(data[i].data, :x, :y, offset = data[i].offset)

                        # allow legend labels to be dragged and dropped
                        if ImPlot.BeginDragDropSourceItem(label, ImGuiDragDropFlags_None) #! no dafults
                            @c CImGui.SetDragDropPayload("DND_PLOT", &i, sizeof(Int))
                            CImGui.TextUnformatted(label)
                            ImPlot.EndDragDropSource()
                        end
                    end
                end
                # make our plot a drag and drop target
                if CImGui.BeginDragDropTarget()
                    payload = CImGui.AcceptDragDropPayload("DND_PLOT")
                    if payload != C_NULL
                        ptr = unsafe_load(payload).Data
                        i = unsafe_load(Ptr{Cint}(ptr))
                        show[i] = true
                        yAxis[i] = 0
                        # set specific y-axis if hovered
                        for y = 0:2 #? 1:3
                            if ImPlot.IsPlotYAxisHovered(y)
                                yAxis[i] = y
                            end
                        end
                    end
                    CImGui.EndDragDropTarget()
                end
                ImPlot.EndPlot()
            end
        end) # @csatic
    end
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Digital and Analog Signals")
        @cstatic(
            init = true,
            K_PLOT_DIGITAL_CH_COUNT = 4,
            K_PLOT_ANALOG_CH_COUNT = 4,
            paused = false,
            dataDigital = ScrollingBuffer[], #ScrollingBuffer dataDigital[K_PLOT_DIGITAL_CH_COUNT],
            dataAnalog = ScrollingBuffer[], #ScrollingBuffer dataAnalog[K_PLOT_ANALOG_CH_COUNT],
            showDigital = nothing, #showDigital[K_PLOT_DIGITAL_CH_COUNT],
            showAnalog = nothing, #showAnalog[K_PLOT_ANALOG_CH_COUNT],

            t = Float32(0),
        begin
            if init #! if inside @cstatic, then LoadError: UndefVarError: K_CHANNELS not defined
                init = false
                showDigital = falses(K_PLOT_DIGITAL_CH_COUNT)
                for i = 1:K_PLOT_DIGITAL_CH_COUNT
                    push!(dataDigital, ScrollingBuffer()) #? does Julia have simpler syntax to initialize an array of mutable pobjects?
                end
                showAnalog = falses(K_PLOT_ANALOG_CH_COUNT)
                for i = 1:K_PLOT_ANALOG_CH_COUNT
                    push!(dataAnalog, ScrollingBuffer()) #? does Julia have simpler syntax to initialize an array of mutable pobjects?
                end
            end

            CImGui.BulletText("You can plot digital and analog signals on the same plot.")
            CImGui.BulletText("Digital signals do not respond to Y drag and zoom, so that")
            CImGui.Indent()
            CImGui.Text("you can drag analog signals over the rising/falling digital edge.")
            CImGui.Unindent()
            CImGui.BeginGroup()
            if CImGui.Button("Clear", ImVec2(100, 0))
                for i = 1:K_PLOT_DIGITAL_CH_COUNT
                    showDigital[i] = false
                end
                for i = 1:K_PLOT_ANALOG_CH_COUNT
                    showAnalog[i] = false
                end
            end
            if CImGui.Button(paused ? "Resume" : "Pause", ImVec2(100,0))
                paused = !paused
            end
            for i = 1:K_PLOT_DIGITAL_CH_COUNT
                label = "digital_$i"
                flag = showDigital[i] #! cannot use @c on bitvector element, so make it manually
                if @c CImGui.Checkbox(label, &flag)
                    showDigital[i] = flag
                end
                if CImGui.BeginDragDropSource(ImGuiDragDropFlags_None)
                    @c CImGui.SetDragDropPayload("DND_DIGITAL_PLOT", &i, sizeof(Int))
                    CImGui.TextUnformatted(label)
                    CImGui.EndDragDropSource()
                end
            end
            for i = 1:K_PLOT_ANALOG_CH_COUNT
                label = "analog_$i"
                flag = showAnalog[i] #! cannot use @c on bitvector element, so make it manually
                if @c CImGui.Checkbox(label, &flag)
                    showAnalog[i] = flag
                end
                if CImGui.BeginDragDropSource(ImGuiDragDropFlags_None)
                    @c CImGui.SetDragDropPayload("DND_ANALOG_PLOT", &i, sizeof(Int))
                    CImGui.TextUnformatted(label)
                    CImGui.EndDragDropSource()
                end
            end
            CImGui.EndGroup()
            CImGui.SameLine()

            if !paused
                t += unsafe_load(CImGui.GetIO().DeltaTime)
                #digital signal values
                i = 1 # 1-based indexing in Julia
                if showDigital[i]
                    AddPoint(dataDigital[i], t, sin(2*t) > 0.45)
                end
                i += 1
                if showDigital[i]
                    AddPoint(dataDigital[i], t, sin(2*t) < 0.45)
                end
                i += 1
                if showDigital[i]
                    AddPoint(dataDigital[i], t, mod(t,5.0))
                end
                i += 1
                if showDigital[i]
                    AddPoint(dataDigital[i], t, sin(2*t) < 0.17)
                end
                #Analog signal values
                i = 1 # 1-based indexing in Julia
                if showAnalog[i]
                    AddPoint(dataAnalog[i], t, sin(2*t))
                end
                i += 1
                if showAnalog[i]
                    AddPoint(dataAnalog[i], t, cos(2*t))
                end
                i += 1
                if showAnalog[i]
                    AddPoint(dataAnalog[i], t, sin(2*t) * cos(2*t))
                end
                i += 1
                if showAnalog[i]
                    AddPoint(dataAnalog[i], t, sin(2*t) - cos(2*t))
                end
            end
            ImPlot.SetNextPlotLimitsY(-1, 1, ImGuiCond_Once, ImPlotYAxis_1) #! no defaults for last 2 args
            ImPlot.SetNextAxisLimitsX(t - 10.0, t, paused ? ImGuiCond_Once : ImGuiCond_Always)
            if ImPlot.BeginPlot("##Digital")
                for i = 1:K_PLOT_DIGITAL_CH_COUNT
                    if showDigital[i] && length(dataDigital[i].data) > 0
                        label = "digital_$i"
                        ImPlot.PlotDigital(label, dataDigital[i].data, :x, :y, offset = dataDigital[i].offset)
                    end
                end
                for i = 1:K_PLOT_ANALOG_CH_COUNT
                    if showAnalog[i]
                        label = "analog_$i"
                        if length(dataAnalog[i].data) > 0
                            ImPlot.PlotLine(label, dataAnalog[i].data, :x, :y, offset = dataAnalog[i].offset)
                        end
                    end
                end
                ImPlot.EndPlot()
            end
            if CImGui.BeginDragDropTarget()
                payload = CImGui.AcceptDragDropPayload("DND_DIGITAL_PLOT")
                if payload != C_NULL
                    ptr = CImGui.Get(payload, :Data)
                    i = unsafe_load(Ptr{Cint}(ptr))
                    showDigital[i] = true
                else
                    payload = CImGui.AcceptDragDropPayload("DND_ANALOG_PLOT")
                    if payload != C_NULL
                        ptr = CImGui.Get(payload, :Data)
                        i = unsafe_load(Ptr{Cint}(ptr))
                        showAnalog[i] = true
                    end
                end
                CImGui.EndDragDropTarget()
            end
        end)
    end
    #-------------------------------------------------------------------------
    =#
    if CImGui.CollapsingHeader("Tables")
        @static if @isdefined(IMGUI_HAS_TABLE) # #ifdef(IMGUI_HAS_TABLE)
            @cstatic(
                flags = ImGuiTableFlags_BordersOuter | ImGuiTableFlags_BordersV | ImGuiTableFlags_RowBg,
                anim = true,
                offset = 0,
                data = zeros(Float32, 100),
            begin
                CImGui.BulletText("Plots can be used inside of ImGui tables.")
                @c CImGui.Checkbox("Animate",&anim)
                if anim
                    offset = (offset + 1) % 100
                end
                if CImGui.BeginTable("##table", 3, flags, ImVec2(-1,0))
                    CImGui.TableSetupColumn("Electrode", ImGuiTableColumnFlags_WidthFixed, 75.0)
                    CImGui.TableSetupColumn("Voltage", ImGuiTableColumnFlags_WidthFixed, 75.0)
                    CImGui.TableSetupColumn("EMG Signal")
                    CImGui.TableHeadersRow()
                    ImPlot.PushColormap(ImPlotColormap_Cool)
                    for row = 0:9  #? 1:10
                        CImGui.TableNextRow()
                        Random.seed!(row)
                        for i = 1:100
                            data[i] = rand(0.0 : 0.0001 : 10.0)
                        end
                        CImGui.TableSetColumnIndex(0)
                        CImGui.Text(@sprintf("EMG %d", row))
                        CImGui.TableSetColumnIndex(1)
                        CImGui.Text(@sprintf("%.3f V", data[offset + 1]))
                        CImGui.TableSetColumnIndex(2)
                        CImGui.PushID(row)
                        MyImPlot.Sparkline("##spark",data,100,0,11.0,offset,ImPlot.GetColormapColor(row),ImVec2(-1, 35))
                        CImGui.PopID()
                    end
                    ImPlot.PopColormap()
                    CImGui.EndTable()
                end
            end)
        else
            CImGui.BulletText("You need to merge the ImGui 'tables' branch for this section.")
        end
    end

    #-------------------------------------------------------------------------
if CImGui.CollapsingHeader("Offset and Stride")

    @cstatic(
        init = true,
        k_circles = 11,
        k_points_per = 50,
        k_size = 0,
        interleaved_data = Vector{Float64}(),
        offset = Int32(0),
    begin
        if init
            init = false
            k_size = 2 * k_points_per * k_circles
            interleaved_data = zeros(Float64, k_size)
        end

        for p = 0:k_points_per-1
            for c = 0:k_circles-1
                r = c / (k_circles - 1) * 0.2 + 0.2
                interleaved_data[1 + p*2*k_circles + 2*c + 0] = 0.5 + r * cos(p/k_points_per * 6.28)
                interleaved_data[1 + p*2*k_circles + 2*c + 1] = 0.5 + r * sin(p/k_points_per * 6.28)
            end
        end

        CImGui.BulletText("Offsetting is useful for realtime plots (see above) and circular buffers.")
        CImGui.BulletText("Striding is useful for interleaved data (e.g. audio) or plotting structs.")
        CImGui.BulletText("Here, all circle data is stored in a single interleaved buffer:")
        CImGui.BulletText("[c0.x0 c0.y0 ... cn.x0 cn.y0 c0.x1 c0.y1 ... cn.x1 cn.y1 ... cn.xm cn.ym]")
        CImGui.BulletText("The offset value indicates which circle point index is considered the first.")
        CImGui.BulletText("Offsets can be negative and/or larger than the actual data count.")

        @c CImGui.SliderInt("Offset", &offset, -2*k_points_per, 2*k_points_per)
        if ImPlot.BeginPlot("##strideoffset")
            ImPlot.PushColormap(ImPlotColormap_Jet)
            for c = 0:k_circles-1
                buff = "Circle $c"
                ImPlot.PlotLine(buff, Ref(interleaved_data, c*2 + 1), Ref(interleaved_data, c*2 + 2), k_points_per, ImPlotLineFlags_None, offset, 2*k_circles*sizeof(Float64))
            end
            ImPlot.EndPlot()
            ImPlot.PopColormap()
        end
        #offset += 1 # uncomment this line + comment out SliderInt for animation!
    end)
end
     #-------------------------------------------------------------------------
     if CImGui.CollapsingHeader("Custom Data and Getters")
         CImGui.BulletText("You can plot custom structs using the stride feature.")
         CImGui.BulletText("Most plotters can also be passed a function pointer for getting data.")
         CImGui.Indent()
             CImGui.BulletText("You can optionally pass user data to be given to your getter function.")
             CImGui.BulletText("C++ lambdas can be passed as function pointers as well!")
         CImGui.Unindent()

         vec2_data = [MyImPlot.Vector2f(0,0), MyImPlot.Vector2f(1,1)]

         if ImPlot.BeginPlot("##Custom Data")

             # custom structs using stride example:
             vecyoffset = fieldoffset(MyImPlot.Vector2f, 2) # offset of :y field
             vec_ptr = Ptr{typeof(vec2_data[1].x)}(pointer(vec2_data))
             ImPlot.PlotLine("Vector2f", vec_ptr, vec_ptr + vecyoffset, 2, ImPlotLineFlags_None, 0, sizeof(MyImPlot.Vector2f))

             # custom getter example 1:
             spiral_c = @cfunction(MyImPlot.Spiral, Cvoid, (Ptr{Cvoid}, Cint,
             Ptr{ImPlotPoint}))
             GC.@preserve spiral_c begin
             ImPlot.PlotLineG("Spiral", spiral_c, C_NULL, 1000)
             end

             # custom getter example 2:
             data1 = Ref(MyImPlot.WaveData(0.001, 0.2, 2, 0.75))
             data2 = Ref(MyImPlot.WaveData(0.001, 0.2, 4, 0.25))
             sinewave_c = @cfunction(MyImPlot.SineWave, Cvoid, (Ptr{Cvoid}, Cint,
             Ptr{ImPlotPoint}))
             sawwave_c = @cfunction(MyImPlot.SawWave, Cvoid, (Ptr{Cvoid}, Cint,
             Ptr{ImPlotPoint}))

             GC.@preserve sinewave_c sawwave_c begin
                 ImPlot.PlotLineG("Waves", sinewave_c, data1, 1000)
                 ImPlot.PlotLineG("Waves", sawwave_c, data2, 1000)
                 ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
                 ImPlot.PlotShadedG("Waves", sinewave_c, data1, sawwave_c, data2, 1000)
                 ImPlot.PopStyleVar()
             end

             ImPlot.EndPlot()
         end
     end
     #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Custom Ticks##")
        @cstatic(
            custom_ticks  = true,
            custom_labels = true,
            yticks = Float64[1,3,7,9],
            ylabels = ["One","Three","Seven","Nine"],
            yticks_aux = [0.2,0.4,0.6],
            ylabels_aux = ["A","B","C","D","E","F"],
            begin

        @c CImGui.Checkbox("Show Custom Ticks", &custom_ticks)
        if custom_ticks
            CImGui.SameLine()
            @c CImGui.Checkbox("Show Custom Labels", &custom_labels)
        end

        pi_str = ["PI"]

        ImPlot.SetNextAxesLimits(2.5,5,0,10)
        if ImPlot.BeginPlot("Custom Ticks", "", "", ImVec2(-1,0);
                            y2_flags = ImPlotAxisFlags_None,
                            y3_flags = ImPlotAxisFlags_None)
            if custom_ticks
                @c ImPlot.SetupAxisTicksX(Float64[pi], 1, custom_labels ? pi_str : C_NULL, true)
                ImPlot.SetupAxisTicksY(yticks, 4, custom_labels ? ylabels : C_NULL)
                ImPlot.SetupAxisTicks(ImPlot.ImAxis_Y2, yticks_aux, 3, custom_labels ? ylabels_aux : C_NULL, false)
                ImPlot.SetupAxisTicks(ImPlot.ImAxis_Y3, 0, 1, 6, custom_labels ? ylabels_aux : C_NULL, false)
            end

            ImPlot.EndPlot()
        end
        end) # cstatic
     end
     #-------------------------------------------------------------------------
     if CImGui.CollapsingHeader("Custom Styles")
         ImPlot.PushColormap(ImPlotColormap_Deep)
         # normally you wouldn't change the entire style each frame
         backup = deepcopy(unsafe_load(ImPlot.GetStyle()))
         MyImPlot.StyleSeaborn()
         ImPlot.SetNextAxesLimits(-0.5, 9.5, 0, 10)
         if ImPlot.BeginPlot("seaborn style", "x-axis", "y-axis")
             lin = UInt32[8,8,9,7,8,8,8,9,7,8]
             bar = UInt32[1,2,5,3,4,1,2,5,3,4]
             dot = UInt32[7,6,6,7,8,5,6,5,8,7]
             ImPlot.PlotBars("Bars", bar, 10, 0.5)
             ImPlot.PlotLine("Line", lin, 10)
             ImPlot.NextColormapColor() # skip green
             ImPlot.PlotScatter("Scatter", dot, 10)
             ImPlot.EndPlot()
         end
         unsafe_store!(ImPlot.GetStyle(), backup)
         ImPlot.PopColormap()
     end
     #-------------------------------------------------------------------------
     # FIXME: BROKEN
     #=
     if CImGui.CollapsingHeader("Custom Rendering")
         if ImPlot.BeginPlot("##CustomRend")
             cntr = ImPlot.PlotToPixels(ImPlotPoint(0.5,  0.5))
             rmin = ImPlot.PlotToPixels(ImPlotPoint(0.25, 0.75))
             rmax = ImPlot.PlotToPixels(ImPlotPoint(0.75, 0.25))

             ImPlot.PushPlotClipRect()
             CImGui.AddCircleFilled(ImPlot.GetPlotDrawList(), cntr, 20, CImGui.IM_COL32(255,255,0,255), 20)
             CImGui.AddRect(ImPlot.GetPlotDrawList(), rmin, rmax, CImGui.IM_COL32(128,0,255,255))
             ImPlot.PopPlotClipRect()

             ImPlot.EndPlot()
         end
     end
     =#
    #-------------------------------------------------------------------------
    if CImGui.CollapsingHeader("Custom Context Menus")
        CImGui.BulletText("You can implement legend context menus to inject per-item controls and widgets.")
        CImGui.BulletText("Right click the legend label/icon to edit custom item attributes.")

        @cstatic(
            init = true,
            frequency = Float32(0.1),
            amplitude = Float32(0.5),
            color     = Ref(ImVec4(1,1,0,1)),
            alpha     = Float32(1.0),
            line      = false,
            thickness = Float32(1),
            markers   = false,
            shaded    = false,
            vals = zeros(Float32, 101),
        begin

        for i = 1:101
            vals[i] = amplitude * sin(frequency * i)
        end

        ImPlot.SetNextAxesLimits(0,100,-1,1)
        if ImPlot.BeginPlot("Right Click the Legend")

            # rendering logic
            ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, alpha)
            if !line
                ImPlot.SetNextFillStyle(color[])
                ImPlot.PlotBars("Right Click Me", vals, 101)
            else
                markers && ImPlot.SetNextMarkerStyle(ImPlotMarker_Circle)
                ImPlot.SetNextLineStyle(color[], thickness)
                ImPlot.PlotLine("Right Click Me", vals, 101)
                shaded && ImPlot.PlotShaded("Right Click Me",vals,101)
            end
            ImPlot.PopStyleVar()

            # custom legend context menu
            if ImPlot.BeginLegendPopup("Right Click Me")
                @c CImGui.SliderFloat("Frequency",&frequency,0,1,"%0.2f")
                @c CImGui.SliderFloat("Amplitude",&amplitude,0,1,"%0.2f")
                CImGui.Separator()
                CImGui.ColorEdit3("Color",Ptr{Float32}(pointer_from_objref(color)))
                @c CImGui.SliderFloat("Transparency",&alpha,0,1,"%.2f")
                @c CImGui.Checkbox("Line Plot", &line)
                if line
                    @c CImGui.SliderFloat("Thickness", &thickness, 0, 5)
                    @c CImGui.Checkbox("Markers", &markers)
                    @c CImGui.Checkbox("Shaded",&shaded)
                end
                ImPlot.EndLegendPopup()
            end
            ImPlot.EndPlot()
        end
    end) # cstatic
    end
    #-------------------------------------------------------------------------
#= Custom plotting requires imgui_internal.h--not available until post v0.9 cimplot
     if CImGui.CollapsingHeader("Custom Plotters and Tooltips"))
         CImGui.BulletText("You can create custom plotters or extend ImPlot using implot_internal.h.")

dates  =
[1546300800,1546387200,1546473600,1546560000,1546819200,1546905600,1546992000,1547078400,
 1547164800,1547424000,1547510400,1547596800,1547683200,1547769600,1547942400,1548028800,
 1548115200,1548201600,1548288000,1548374400,1548633600,1548720000,1548806400,1548892800,
 1548979200,1549238400,1549324800,1549411200,1549497600,1549584000,1549843200,1549929600,
 1550016000,1550102400,1550188800,1550361600,1550448000,1550534400,1550620800,1550707200,
 1550793600,1551052800,1551139200,1551225600,1551312000,1551398400,1551657600,1551744000,
 1551830400,1551916800,1552003200,1552262400,1552348800,1552435200,1552521600,1552608000,
 1552867200,1552953600,1553040000,1553126400,1553212800,1553472000,1553558400,1553644800,
 1553731200,1553817600,1554076800,1554163200,1554249600,1554336000,1554422400,1554681600,
 1554768000,1554854400,1554940800,1555027200,1555286400,1555372800,1555459200,1555545600,
 1555632000,1555891200,1555977600,1556064000,1556150400,1556236800,1556496000,1556582400,
 1556668800,1556755200,1556841600,1557100800,1557187200,1557273600,1557360000,1557446400,
 1557705600,1557792000,1557878400,1557964800,1558051200,1558310400,1558396800,1558483200,
 1558569600,1558656000,1558828800,1558915200,1559001600,1559088000,1559174400,1559260800,
 1559520000,1559606400,1559692800,1559779200,1559865600,1560124800,1560211200,1560297600,
 1560384000,1560470400,1560729600,1560816000,1560902400,1560988800,1561075200,1561334400,
 1561420800,1561507200,1561593600,1561680000,1561939200,1562025600,1562112000,1562198400,
 1562284800,1562544000,1562630400,1562716800,1562803200,1562889600,1563148800,1563235200,
 1563321600,1563408000,1563494400,1563753600,1563840000,1563926400,1564012800,1564099200,
 1564358400,1564444800,1564531200,1564617600,1564704000,1564963200,1565049600,1565136000,
 1565222400,1565308800,1565568000,1565654400,1565740800,1565827200,1565913600,1566172800,
 1566259200,1566345600,1566432000,1566518400,1566777600,1566864000,1566950400,1567036800,
 1567123200,1567296000,1567382400,1567468800,1567555200,1567641600,1567728000,1567987200,
 1568073600,1568160000,1568246400,1568332800,1568592000,1568678400,1568764800,1568851200,
 1568937600,1569196800,1569283200,1569369600,1569456000,1569542400,1569801600,1569888000,
 1569974400,1570060800,1570147200,1570406400,1570492800,1570579200,1570665600,1570752000,
 1571011200,1571097600,1571184000,1571270400,1571356800,1571616000,1571702400,1571788800,
 1571875200,1571961600]

opens =
[1284.7,1319.9,1318.7,1328,1317.6,1321.6,1314.3,1325,1319.3,1323.1,1324.7,1321.3,1323.5,
 1322,1281.3,1281.95,1311.1,1315,1314,1313.1,1331.9,1334.2,1341.3,1350.6,1349.8,1346.4,
 1343.4,1344.9,1335.6,1337.9,1342.5,1337,1338.6,1337,1340.4,1324.65,1324.35,1349.5,1371.3,
 1367.9,1351.3,1357.8,1356.1,1356,1347.6,1339.1,1320.6,1311.8,1314,1312.4,1312.3,1323.5,
 1319.1,1327.2,1332.1,1320.3,1323.1,1328,1330.9,1338,1333,1335.3,1345.2,1341.1,1332.5,1314,
 1314.4,1310.7,1314,1313.1,1315,1313.7,1320,1326.5,1329.2,1314.2,1312.3,1309.5,1297.4,
 1293.7,1277.9,1295.8,1295.2,1290.3,1294.2,1298,1306.4,1299.8,1302.3,1297,1289.6,1302,
 1300.7,1303.5,1300.5,1303.2,1306,1318.7,1315,1314.5,1304.1,1294.7,1293.7,1291.2,1290.2,
 1300.4,1284.2,1284.25,1301.8,1295.9,1296.2,1304.4,1323.1,1340.9,1341,1348,1351.4,1351.4,
 1343.5,1342.3,1349,1357.6,1357.1,1354.7,1361.4,1375.2,1403.5,1414.7,1433.2,1438,1423.6,
 1424.4,1418,1399.5,1435.5,1421.25,1434.1,1412.4,1409.8,1412.2,1433.4,1418.4,1429,1428.8,
 1420.6,1441,1460.4,1441.7,1438.4,1431,1439.3,1427.4,1431.9,1439.5,1443.7,1425.6,1457.5,
 1451.2,1481.1,1486.7,1512.1,1515.9,1509.2,1522.3,1513,1526.6,1533.9,1523,1506.3,1518.4,
 1512.4,1508.8,1545.4,1537.3,1551.8,1549.4,1536.9,1535.25,1537.95,1535.2,1556,1561.4,1525.6,
 1516.4,1507,1493.9,1504.9,1506.5,1513.1,1506.5,1509.7,1502,1506.8,1521.5,1529.8,1539.8,
 1510.9,1511.8,1501.7,1478,1485.4,1505.6,1511.6,1518.6,1498.7,1510.9,1510.8,1498.3,1492,
 1497.7,1484.8,1494.2,1495.6,1495.6,1487.5,1491.1,1495.1,1506.4]

highs =
[1284.75,1320.6,1327,1330.8,1326.8,1321.6,1326,1328,1325.8,1327.1,1326,1326,1323.5,1322.1,
 1282.7,1282.95,1315.8,1316.3,1314,1333.2,1334.7,1341.7,1353.2,1354.6,1352.2,1346.4,1345.7,
 1344.9,1340.7,1344.2,1342.7,1342.1,1345.2,1342,1350,1324.95,1330.75,1369.6,1374.3,1368.4,
 1359.8,1359,1357,1356,1353.4,1340.6,1322.3,1314.1,1316.1,1312.9,1325.7,1323.5,1326.3,1336,
 1332.1,1330.1,1330.4,1334.7,1341.1,1344.2,1338.8,1348.4,1345.6,1342.8,1334.7,1322.3,1319.3,
 1314.7,1316.6,1316.4,1315,1325.4,1328.3,1332.2,1329.2,1316.9,1312.3,1309.5,1299.6,1296.9,
 1277.9,1299.5,1296.2,1298.4,1302.5,1308.7,1306.4,1305.9,1307,1297.2,1301.7,1305,1305.3,
 1310.2,1307,1308,1319.8,1321.7,1318.7,1316.2,1305.9,1295.8,1293.8,1293.7,1304.2,1302,
 1285.15,1286.85,1304,1302,1305.2,1323,1344.1,1345.2,1360.1,1355.3,1363.8,1353,1344.7,1353.6,
 1358,1373.6,1358.2,1369.6,1377.6,1408.9,1425.5,1435.9,1453.7,1438,1426,1439.1,1418,1435,
 1452.6,1426.65,1437.5,1421.5,1414.1,1433.3,1441.3,1431.4,1433.9,1432.4,1440.8,1462.3,1467,
 1443.5,1444,1442.9,1447,1437.6,1440.8,1445.7,1447.8,1458.2,1461.9,1481.8,1486.8,1522.7,
 1521.3,1521.1,1531.5,1546.1,1534.9,1537.7,1538.6,1523.6,1518.8,1518.4,1514.6,1540.3,1565,
 1554.5,1556.6,1559.8,1541.9,1542.9,1540.05,1558.9,1566.2,1561.9,1536.2,1523.8,1509.1,1506.2,
 1532.2,1516.6,1519.7,1515,1519.5,1512.1,1524.5,1534.4,1543.3,1543.3,1542.8,1519.5,1507.2,
 1493.5,1511.4,1525.8,1522.2,1518.8,1515.3,1518,1522.3,1508,1501.5,1503,1495.5,1501.1,1497.9,
 1498.7,1492.1,1499.4,1506.9,1520.9]

lows =
[1282.85,1315,1318.7,1309.6,1317.6,1312.9,1312.4,1319.1,1319,1321,1318.1,1321.3,1319.9,1312,
 1280.5,1276.15,1308,1309.9,1308.5,1312.3,1329.3,1333.1,1340.2,1347,1345.9,1338,1340.8,1335,
 1332,1337.9,1333,1336.8,1333.2,1329.9,1340.4,1323.85,1324.05,1349,1366.3,1351.2,1349.1,
 1352.4,1350.7,1344.3,1338.9,1316.3,1308.4,1306.9,1309.6,1306.7,1312.3,1315.4,1319,1327.2,
 1317.2,1320,1323,1328,1323,1327.8,1331.7,1335.3,1336.6,1331.8,1311.4,1310,1309.5,1308,
 1310.6,1302.8,1306.6,1313.7,1320,1322.8,1311,1312.1,1303.6,1293.9,1293.5,1291,1277.9,1294.1,
 1286,1289.1,1293.5,1296.9,1298,1299.6,1292.9,1285.1,1288.5,1296.3,1297.2,1298.4,1298.6,1302,
 1300.3,1312,1310.8,1301.9,1292,1291.1,1286.3,1289.2,1289.9,1297.4,1283.65,1283.25,1292.9,
 1295.9,1290.8,1304.2,1322.7,1336.1,1341,1343.5,1345.8,1340.3,1335.1,1341.5,1347.6,1352.8,
 1348.2,1353.7,1356.5,1373.3,1398,1414.7,1427,1416.4,1412.7,1420.1,1396.4,1398.8,1426.6,
 1412.85,1400.7,1406,1399.8,1404.4,1415.5,1417.2,1421.9,1415,1413.7,1428.1,1434,1435.7,
 1427.5,1429.4,1423.9,1425.6,1427.5,1434.8,1422.3,1412.1,1442.5,1448.8,1468.2,1484.3,1501.6,
 1506.2,1498.6,1488.9,1504.5,1518.3,1513.9,1503.3,1503,1506.5,1502.1,1503,1534.8,1535.3,
 1541.4,1528.6,1525.6,1535.25,1528.15,1528,1542.6,1514.3,1510.7,1505.5,1492.1,1492.9,1496.8,
 1493.1,1503.4,1500.9,1490.7,1496.3,1505.3,1505.3,1517.9,1507.4,1507.1,1493.3,1470.5,1465,
 1480.5,1501.7,1501.4,1493.3,1492.1,1505.1,1495.7,1478,1487.1,1480.8,1480.6,1487,1488.3,
 1484.8,1484,1490.7,1490.4,1503.1]

closes =
[1283.35,1315.3,1326.1,1317.4,1321.5,1317.4,1323.5,1319.2,1321.3,1323.3,1319.7,1325.1,
 1323.6,1313.8,1282.05,1279.05,1314.2,1315.2,1310.8,1329.1,1334.5,1340.2,1340.5,1350,1347.1,
 1344.3,1344.6,1339.7,1339.4,1343.7,1337,1338.9,1340.1,1338.7,1346.8,1324.25,1329.55,1369.6,
 1372.5,1352.4,1357.6,1354.2,1353.4,1346,1341,1323.8,1311.9,1309.1,1312.2,1310.7,1324.3,
 1315.7,1322.4,1333.8,1319.4,1327.1,1325.8,1330.9,1325.8,1331.6,1336.5,1346.7,1339.2,1334.7,
 1313.3,1316.5,1312.4,1313.4,1313.3,1312.2,1313.7,1319.9,1326.3,1331.9,1311.3,1313.4,1309.4,
 1295.2,1294.7,1294.1,1277.9,1295.8,1291.2,1297.4,1297.7,1306.8,1299.4,1303.6,1302.2,1289.9,
 1299.2,1301.8,1303.6,1299.5,1303.2,1305.3,1319.5,1313.6,1315.1,1303.5,1293,1294.6,1290.4,
 1291.4,1302.7,1301,1284.15,1284.95,1294.3,1297.9,1304.1,1322.6,1339.3,1340.1,1344.9,1354,
 1357.4,1340.7,1342.7,1348.2,1355.1,1355.9,1354.2,1362.1,1360.1,1408.3,1411.2,1429.5,1430.1,
 1426.8,1423.4,1425.1,1400.8,1419.8,1432.9,1423.55,1412.1,1412.2,1412.8,1424.9,1419.3,1424.8,
 1426.1,1423.6,1435.9,1440.8,1439.4,1439.7,1434.5,1436.5,1427.5,1432.2,1433.3,1441.8,1437.8,
 1432.4,1457.5,1476.5,1484.2,1519.6,1509.5,1508.5,1517.2,1514.1,1527.8,1531.2,1523.6,1511.6,
 1515.7,1515.7,1508.5,1537.6,1537.2,1551.8,1549.1,1536.9,1529.4,1538.05,1535.15,1555.9,
 1560.4,1525.5,1515.5,1511.1,1499.2,1503.2,1507.4,1499.5,1511.5,1513.4,1515.8,1506.2,1515.1,
 1531.5,1540.2,1512.3,1515.2,1506.4,1472.9,1489,1507.9,1513.8,1512.9,1504.4,1503.9,1512.8,
 1500.9,1488.7,1497.6,1483.5,1494,1498.3,1494.1,1488.1,1487.5,1495.7,1504.7,1505.3]

         @cstatic ( begin end) tooltip = true
         CImGui.Checkbox("Show Tooltip", &tooltip)
         CImGui.SameLine()
         @cstatic ( begin end) bullCol = ImVec4(0.000, 1.000, 0.441, 1.000)
         @cstatic ( begin end) bearCol = ImVec4(0.853, 0.050, 0.310, 1.000)
         CImGui.SameLine() CImGui.ColorEdit4("##Bull", &bullCol.x, ImGuiColorEditFlags_NoInputs)
         CImGui.SameLine() CImGui.ColorEdit4("##Bear", &bearCol.x, ImGuiColorEditFlags_NoInputs)
         ImPlot.GetStyle().UseLocalTime = false
         ImPlot.SetNextPlotLimits(1546300800, 1571961600, 1250, 1600)
         if ImPlot.BeginPlot("Candlestick Chart","Day","USD",ImVec2(-1,0),0,ImPlotAxisFlags_Time))
             MyImPlot.PlotCandlestick("GOOGL",dates, opens, closes, lows, highs, 218, tooltip, 0.25, bullCol, bearCol)
             ImPlot.EndPlot()
         end
     end
   #-------------------------------------------------------------------------
=#
    CImGui.End()

end

# main functinon
function full_demo(; engine=nothing)
    ctx = CImGui.CreateContext()
    pctx = ImPlot.CreateContext()
    CImGui.render(ctx; engine, on_exit=() -> ImPlot.DestroyContext(pctx),
                  window_size=(1360, 780), window_title="Demo plots") do
        ShowDemoWindow()
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    full_demo()
end
