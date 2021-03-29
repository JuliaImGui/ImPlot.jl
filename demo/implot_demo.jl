
include("Renderer.jl")
using .Renderer
using Printf

using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

import CImGui:  # do we need to import this separately?
    ImVec2, # I don't get all of this Im*, ImGui_* and so on - instead of a consistent namespace CImGui.* (or Im::*)
    ImVec4,
    ImGuiCond_Always,
    ImGuiCond_Appearing, # CImGui.Cond_Appearing would be cleaner, but probably too excessive to replace all...
    ImGuiCond_FirstUseEver,
    ImGuiCond_Once,
    ImGuiWindowFlags_MenuBar,
    ImGuiBackendFlags_RendererHasVtxOffset

import CImGui.LibCImGui:  # do we need to import this separately?
    ImDrawIdx

using ImPlot

import ImPlot.LibCImPlot: # do we need to import this separately?
    ImPlotMarker_Circle,
    ImPlotMarker_Square,
    ShowUserGuide,
    ShowMetricsWindow,
    ShowStyleSelector,
    ShowColormapSelector,
    SetNextMarkerStyle,
    IMPLOT_AUTO,
    IMPLOT_AUTO_COL,
    ImPlotStyleVar_FillAlpha,
    ImPlotLocation_West,
    ImPlotLocation_South,
    ImPlotOrientation_Horizontal,
    ImPlotOrientation_Vertical,
    ImPlotAxisFlags_Invert

using Random

# ==== fixes in api (should be fixed after auto-generation...) ====
function SetNextMarkerStyle_fix(marker = IMPLOT_AUTO, size = IMPLOT_AUTO, fill = IMPLOT_AUTO_COL, weight = IMPLOT_AUTO, outline = IMPLOT_AUTO_COL)
    ccall((:ImPlot_SetNextMarkerStyle, ImPlot.LibCImPlot.libcimplot), Cvoid, 
        (ImPlot.LibCImPlot.ImPlotMarker, Cfloat, CImGui.ImVec4, Cfloat, CImGui.ImVec4), marker, size, fill, weight, outline)
end
function SetNextLineStyle_fix(col = IMPLOT_AUTO_COL, weight = IMPLOT_AUTO)
    ccall((:ImPlot_SetNextLineStyle, ImPlot.LibCImPlot.libcimplot), Cvoid, 
        (CImGui.ImVec4, Cfloat), col, weight)
end
# ======================


function ShowDemoWindow()

    DEMO_TIME = CImGui.GetTime()
    #? ouch... maybe a mutable state will handle these fields?
    #? bool* p_open was input argument
    @cstatic p_open, show_imgui_metrics, show_implot_metrics, show_imgui_style_editor, show_implot_style_editor, show_implot_benchmark = false, false, false, false, false, false begin
        if (show_imgui_metrics) 
            @c CImGui.ShowMetricsWindow(&show_imgui_metrics)
        end
        if (show_implot_metrics) 
            @c ShowMetricsWindow(&show_implot_metrics) #? ImPlot.LibCImPlot.
        end
        if (show_imgui_style_editor) 
            @c CImGui.Begin("Style Editor (CImGui)", &show_imgui_style_editor)
            CImGui.ShowStyleEditor()
            CImGui.End()
        end
        if (show_implot_style_editor) 
            CImGui.SetNextWindowSize(ImVec2(415,762), ImGuiCond_Appearing)
            @c CImGui.Begin("Style Editor (ImPlot)", &show_implot_style_editor)
            ImPlot.ShowStyleEditor()
            CImGui.End()
        end
        if (show_implot_benchmark) 
            CImGui.SetNextWindowSize(ImVec2(530,740), ImGuiCond_Appearing)
            @c CImGui.Begin("ImPlot Benchmark Tool", &show_implot_benchmark)
            ImPlot.ShowBenchmarkTool()
            CImGui.End()
            return
        end

        CImGui.SetNextWindowPos(ImVec2(50, 50), ImGuiCond_FirstUseEver)
        CImGui.SetNextWindowSize(ImVec2(600, 750), ImGuiCond_FirstUseEver) 
        @c CImGui.Begin("ImPlot Demo", &p_open, ImGuiWindowFlags_MenuBar)
        if (CImGui.BeginMenuBar()) 
            if (CImGui.BeginMenu("Tools")) 
                @c CImGui.MenuItem("Metrics (CImGui)",      "", &show_imgui_metrics) # NULL -> ""
                @c CImGui.MenuItem("Metrics (ImPlot)",      "", &show_implot_metrics)
                @c CImGui.MenuItem("Style Editor (CImGui)", "", &show_imgui_style_editor)
                @c CImGui.MenuItem("Style Editor (ImPlot)", "", &show_implot_style_editor)
                @c CImGui.MenuItem("Benchmark",             "", &show_implot_benchmark)
                CImGui.EndMenu()
            end
            CImGui.EndMenuBar()
        end
    end # @cstatic
    
    #-------------------------------------------------------------------------
    CImGui.Text("ImPlot says hello - but what version?") #! IMPLOT_VERSION)
    CImGui.Spacing()

    if (CImGui.CollapsingHeader("Help")) 
        CImGui.Text("ABOUT THIS DEMO:")
        CImGui.BulletText("Sections below are demonstrating many aspects of the library.")
        CImGui.BulletText("The \"Tools\" menu above gives access to: Style Editors (ImPlot/CImGui)\nand Metrics (general purpose Dear CImGui debugging tool).")
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
        CImGui.BulletText(@sprintf("ImDrawIdx: %d-bit", sizeof(ImDrawIdx) * 8)) #? why not $interpolate
        CImGui.BulletText(@sprintf("ImGuiBackendFlags_RendererHasVtxOffset: %s", (CImGui.GetIO().BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset > 0) ? "True" : "False"))
        CImGui.Unindent()
        CImGui.Unindent()
#ifdef IMPLOT_DEMO_USE_DOUBLE -- Maybe just use Sys.WORD_SIZE? Since that's default precision in Julia per system.
        CImGui.BulletText("The demo data precision is: Float64")
#else
#        CImGui.BulletText("The demo data precision is: Float32") #?
#endif

        CImGui.Separator()
        CImGui.Text("USER GUIDE:")
        ShowUserGuide()
    end
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Configuration")) 
        CImGui.ShowFontSelector("Font")
        CImGui.ShowStyleSelector("CImGui Style")
        ShowStyleSelector("ImPlot Style") #? ImPlot.LibCImPlot
        ShowColormapSelector("ImPlot Colormap") #? ImPlot.LibCImPlot
        indent = CImGui.CalcItemWidth() - CImGui.GetFrameHeight()
        CImGui.Indent(CImGui.CalcItemWidth() - CImGui.GetFrameHeight())
        #! CImGui.Checkbox("Anti-Aliased Lines", &ImPlot.GetStyle().AntiAliasedLines)
        CImGui.Unindent(indent)
    end
    
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Line Plots")) 
        #? ouch...
        @cstatic xs1, ys1, xs2, ys2 = zeros(Float32, 1001), zeros(Float32, 1001), zeros(Float32, 11), zeros(Float32, 11) begin
            for i = 1:1001 #! not 0-based 
                xs1[i] = i * 0.001
                ys1[i] = 0.5 + 0.5 * sin(50 * (xs1[i] + DEMO_TIME / 10))
            end
            for i = 1:11 #! not 0-based 
                xs2[i] = i * 0.1
                ys2[i] = xs2[i] * xs2[i]
            end
            CImGui.BulletText("Anti-aliasing can be enabled from the plot's context menu (see Help).")
            if ImPlot.BeginPlot("Line Plot", "x", "f(x)")
                ImPlot.PlotLine(xs1, ys1, label = "sin(x)")
                SetNextMarkerStyle_fix(ImPlotMarker_Circle) #! error in api #? ImPlot.LibCImPlot #? no default values
                ImPlot.PlotLine(xs2, ys2, label = "x^2")
                ImPlot.EndPlot()
            end
        end
    end
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Filled Line Plots")) 
        @cstatic xs1, ys1, ys2, ys3, show_lines, show_fills, fill_ref = zeros(Float64, 101), zeros(Float64, 101), zeros(Float64, 101), zeros(Float64, 101), true, true, Float32(0.0) begin
            Random.seed!(0)
            for i = 1:101 
                xs1[i] = i
                ys1[i] = rand(400.0 : 0.001 : 450.0)
                ys2[i] = rand(275.0 : 0.001 : 350.0)
                ys3[i] = rand(150.0 : 0.001 : 225.0)
            end

            @c CImGui.Checkbox("Lines", &show_lines) 
            CImGui.SameLine()
            @c CImGui.Checkbox("Fills", &show_fills)
            @c CImGui.DragFloat("Reference", &fill_ref, 1, -100, 500)

            ImPlot.SetNextPlotLimits(0, 100, 0, 500, ImGuiCond_Once) #? no default cond argument
            if (ImPlot.BeginPlot("Stock Prices", "Days", "Price"))
                if (show_fills) 
                    ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
                    ImPlot.PlotShaded(xs1, ys1, fill_ref, label = "Stock 1")
                    ImPlot.PlotShaded(xs1, ys2, fill_ref, label = "Stock 2")
                    ImPlot.PlotShaded(xs1, ys3, fill_ref, label = "Stock 3")
                    ImPlot.PopStyleVar()
                end
                if (show_lines) 
                    ImPlot.PlotLine(xs1, ys1, label = "Stock 1")
                    ImPlot.PlotLine(xs1, ys2, label = "Stock 2")
                    ImPlot.PlotLine(xs1, ys3, label = "Stock 3")
                end
                ImPlot.EndPlot()
            end
        end
    end
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Shaded Plots##")) 
        @cstatic xs, ys, ys1, ys2, ys3, ys4, alpha = zeros(Float32, 1001), zeros(Float32, 1001), zeros(Float32, 1001), zeros(Float32, 1001), zeros(Float32, 1001), zeros(Float32, 1001), Float32(0.25) begin
            Random.seed!(0)
            for i = 1:1001
                xs[i]  = i * 0.001
                ys[i]  = 0.25 + 0.25 * sin(25 * xs[i]) * sin(5 * xs[i]) + rand(-0.01 : 0.00001 : 0.01)
                ys1[i] = ys[i] + rand(0.1 : 0.00001 : 0.12)
                ys2[i] = ys[i] - rand(0.1 : 0.00001 : 0.12)
                ys3[i] = 0.75 + 0.2 * sin(25 * xs[i])
                ys4[i] = 0.75 + 0.1 * cos(25 * xs[i])
            end
            @c CImGui.DragFloat("Alpha", &alpha, 0.01, 0, 1)

            if (ImPlot.BeginPlot("Shaded Plots", "X-Axis", "Y-Axis"))
                ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, alpha)
                ImPlot.PlotShaded(xs, ys1, ys2, label = "Uncertain Data")
                ImPlot.PlotLine(xs, ys, label = "Uncertain Data")
                ImPlot.PlotShaded(xs, ys3, ys4, label = "Overlapping")
                ImPlot.PlotLine(xs, ys3, label = "Overlapping")
                ImPlot.PlotLine(xs, ys4, label = "Overlapping")
                ImPlot.PopStyleVar()
                ImPlot.EndPlot()
            end
        end
    end

    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Scatter Plots")) 
        Random.seed!(0)
        @cstatic xs1, ys1 = zeros(Float32, 100), zeros(Float32, 100) xs2, ys2 = zeros(Float32, 50), zeros(Float32, 50) begin
            for i = 1:100
                xs1[i] = i * 0.01
                ys1[i] = xs1[i] + 0.1 * rand(0 : 0.0001 : 1)
            end
            for i = 1:50 
                xs2[i] = 0.25 + 0.2 * rand(0 : 0.0001 : 1)
                ys2[i] = 0.75 + 0.2 * rand(0 : 0.0001 : 1)
            end

            if ImPlot.BeginPlot("Scatter Plot", "", "")
                ImPlot.PlotScatter(xs1, ys1, label = "Data 1")
                ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
                SetNextMarkerStyle_fix(ImPlotMarker_Square, 6, ImVec4(0,1,0,0.5), IMPLOT_AUTO, ImVec4(0,1,0,1))
                ImPlot.PlotScatter(xs2, ys2, label = "Data 2")
                ImPlot.PopStyleVar()
                ImPlot.EndPlot()
            end
        end
    end
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Stairstep Plots")) 
        @cstatic ys1 = zeros(Float32, 101) ys2 = zeros(Float32, 101) begin
            for i = 1:101
                ys1[i] = 0.5 + 0.4 * sin(50 * i * 0.01)
                ys2[i] = 0.5 + 0.2 * sin(25 * i * 0.01)
            end
            if ImPlot.BeginPlot("Stairstep Plot", "x", "f(x)")
                ImPlot.PlotStairs(ys1, xscale = 0.01, label = "Signal 1")
                SetNextMarkerStyle_fix(ImPlotMarker_Square, 2.0)
                ImPlot.PlotStairs(ys2, xscale = 0.01, label = "Signal 2")
                ImPlot.EndPlot()
            end
        end
    end
    #-------------------------------------------------------------------------
    # the rest code is copy-pasted from C++, fast find-and-change patterns applied and some shallow errors fixed
    # TODO: make this code working one-by-one
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Bar Plots")) 

        @cstatic(
            horz   = false,
            midtm  = Int8[83, 67, 23, 89, 83, 78, 91, 82, 85, 90],
            final  = Int16[80, 62, 56, 99, 55, 78, 88, 78, 90, 100],
            grade  = Int32[80, 69, 52, 92, 72, 78, 75, 76, 89, 95],
            labels = ["S1","S2","S3","S4","S5","S6","S7","S8","S9","S10"],
            positions = Float64[0,1,2,3,4,5,6,7,8,9],
            begin

                @c CImGui.Checkbox("Horizontal", &horz)

                if (horz) 
                    ImPlot.SetNextPlotLimits(0, 110, -0.5, 9.5, ImGuiCond_Always)
                    ImPlot.SetNextPlotTicksY(positions, 10; labels = labels)
                else 
                    ImPlot.SetNextPlotLimits(-0.5, 9.5, 0, 110, ImGuiCond_Always)
                    ImPlot.SetNextPlotTicksX(positions, 10; labels = labels)
                end
                if (ImPlot.BeginPlot("Bar Plot", horz ? "Score" :  "Student", horz ? "Student" : "Score",
                                      ImVec2(-1,0), y_flags = horz ? ImPlotAxisFlags_Invert : ImPlotAxisFlags_None))
                    if (horz) 
                        ImPlot.SetLegendLocation(ImPlotLocation_West, ImPlotOrientation_Vertical)
                        ImPlot.PlotBarsH(midtm, label_id = "Midterm Exam", count = 10, width = 0.2, shift = -0.2)
                        ImPlot.PlotBarsH(final, label_id = "Final Exam", count = 10, width = 0.2, shift = 0)
                        ImPlot.PlotBarsH(grade, label_id = "Course Grade", count = 10, width = 0.2, shift = 0.2)
                    else 
                        ImPlot.SetLegendLocation(ImPlotLocation_South, ImPlotOrientation_Horizontal)
                        ImPlot.PlotBars(midtm, label_id = "Midterm Exam", count = 10, width = 0.2, shift = -0.2)
                        ImPlot.PlotBars(final, label_id = "Final Exam", count = 10, width = 0.2, shift = 0)
                        ImPlot.PlotBars(grade, label_id = "Course Grade", count = 10, width = 0.2, shift = 0.2)
                    end
                    ImPlot.EndPlot()
                end
            end) # cstatic end
    end
    #-------------------------------------------------------------------------
    if (CImGui.CollapsingHeader("Error Bars")) 
        @cstatic(xs    = Float32[1,2,3,4,5],
            bar   = Float32[1,2,5,3,4],
            lin1  = Float32[8,8,9,7,8],
            lin2  = Float32[6,7,6,9,6],
            err1  = Float32[0.2, 0.4, 0.2, 0.6, 0.4],
            err2  = Float32[0.4, 0.2, 0.4, 0.8, 0.6],
            err3  = Float32[0.09, 0.14, 0.09, 0.12, 0.16],
            err4  = Float32[0.02, 0.08, 0.15, 0.05, 0.2],
            begin


         ImPlot.SetNextPlotLimits(0, 6, 0, 10)
         if ImPlot.BeginPlot("##ErrorBars","","")

             ImPlot.PlotBars(xs, bar, count = 5, width = 0.5, label_id = "Bar")
             ImPlot.PlotErrorBars(xs, bar, err1, count = 5, label_id = "Bar")

#             ImPlot.SetNextErrorBarStyle(ImPlot.GetColormapColor(1), 0)
             ImPlot.PlotErrorBars(xs, lin1, err1, err2, count = 5, label_id = "Line")
#             ImPlot.SetNextMarkerStyle_fix(ImPlotMarker_Circle)
             ImPlot.PlotLine(xs, lin1, count = 5, label = "Line") # FIXME: consistency of label/label_id

#             ImPlot.PushStyleColor(ImPlotCol_ErrorBar, ImPlot.GetColormapColor(2))
             ImPlot.PlotErrorBars(xs, lin2, err2, count = 5, label_id = "Scatter")
             ImPlot.PlotErrorBarsH(xs, lin2,  err3, err4, count = 5, label_id = "Scatter")
#             ImPlot.PopStyleColor()
             ImPlot.PlotScatter(xs, lin2, count = 5, label = "Scatter")

             ImPlot.EndPlot()
         end
        end) #cstatic 
     end
#     if (CImGui.CollapsingHeader("Stem Plots##")) 
#         @cstatic xs = zeros(Float64, 51) ys1 = zeros(Float64, 51) ys2 = zeros(Float64, 51)
#         for i = 1:51
#             xs[i] = i * 0.02
#             ys1[i] = 1.0 + 0.5 * sin(25*xs[i]) * cos(2*xs[i])
#             ys2[i] = 0.5 + 0.25  * sin(10*xs[i]) * sin(xs[i])
#         end
#         ImPlot.SetNextPlotLimits(0,1,0,1.6)
#         if ImPlot.BeginPlot("Stem Plots", "", "", ImVec2(-1, 200)) #? no default size 

#             ImPlot.PlotStems("Stems 1",xs,ys1,51)

#             ImPlot.SetNextLineStyle(ImVec4(1,0.5,0,0.75))
#             ImPlot.SetNextMarkerStyle(ImPlotMarker_Square,5,ImVec4(1,0.5,0,0.25))
#             ImPlot.PlotStems("Stems 2", xs, ys2,51)

#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Pie Charts")) 
#         @cstatic labels1 = ["Frogs","Hogs","Dogs","Logs"]
#         @cstatic data1[]           = Float32[0.15,  0.30,  0.2, 0.05]
#         @cstatic normalize         = false
#         CImGui.SetNextItemWidth(250)
#         CImGui.DragFloat4("Values", data1, 0.01, 0, 1)
#         if ((data1[0] + data1[1] + data1[2] + data1[3]) < 1) 
#             CImGui.SameLine()
#             CImGui.Checkbox("Normalize", &normalize)
#         end

#         ImPlot.SetNextPlotLimits(0,1,0,1,ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##Pie1", "", "", ImVec2(250,250), ImPlotFlags_Equal | ImPlotFlags_NoMousePos, ImPlotAxisFlags_NoDecorations, ImPlotAxisFlags_NoDecorations)) 
#             ImPlot.PlotPieChart(labels1, data1, 4, 0.5, 0.5, 0.4, normalize, "%.2f")
#             ImPlot.EndPlot()
#         end

#         CImGui.SameLine()

#         @cstatic labels2 = ["A","B","C","D","E"]
#         @cstatic data2 = [1,1,2,3,5]

#         ImPlot.PushColormap(ImPlotColormap_Pastel)
#         ImPlot.SetNextPlotLimits(0,1,0,1,ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##Pie2", "", "", ImVec2(250,250), ImPlotFlags_Equal | ImPlotFlags_NoMousePos, ImPlotAxisFlags_NoDecorations, ImPlotAxisFlags_NoDecorations)) 
#             ImPlot.PlotPieChart(labels2, data2, 5, 0.5, 0.5, 0.4, true, "%.0f", 180)
#             ImPlot.EndPlot()
#         end
#         ImPlot.PopColormap()
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Heatmaps")) 
#         @cstatic  values1 = [Float32[0.8, 2.4, 2.5, 3.9, 0.0, 4.0, 0.0],
#                             Float32[2.4, 0.0, 4.0, 1.0, 2.7, 0.0, 0.0],
#                             Float32[1.1, 2.4, 0.8, 4.3, 1.9, 4.4, 0.0],
#                             Float32[0.6, 0.0, 0.3, 0.0, 3.1, 0.0, 0.0],
#                             Float32[0.7, 1.7, 0.6, 2.6, 2.2, 6.2, 0.0],
#                             Float32[1.3, 1.2, 0.0, 0.0, 0.0, 3.2, 5.1],
#                             Float32[0.1, 2.0, 0.0, 1.4, 0.0, 1.9, 6.3]]
#         @cstatic scale_min       = Float32(0)
#         @cstatic scale_max       = Float32(6.3)
#         @cstatic xlabels = ["C1","C2","C3","C4","C5","C6","C7"]
#         @cstatic ylabels = ["R1","R2","R3","R4","R5","R6","R7"]

#         @cstatic ImPlotColormap map = ImPlotColormap_Viridis
#         if (CImGui.Button("Change Colormap",ImVec2(225,0)))
#             map = (map + 1) % ImPlotColormap_COUNT
#         end
#         CImGui.SameLine()
#         CImGui.LabelText("##Colormap Index", "%s", ImPlot.GetColormapName(map))
#         CImGui.SetNextItemWidth(225)
#         CImGui.DragFloatRange2("Min / Max",&scale_min, &scale_max, 0.01, -20, 20)
#         @cstatic ImPlotAxisFlags axes_flags = ImPlotAxisFlags_Lock | ImPlotAxisFlags_NoGridLines | ImPlotAxisFlags_NoTickMarks

#         ImPlot.PushColormap(map)
#         SetNextPlotTicksX(0 + 1.0/14.0, 1 - 1.0/14.0, 7, xlabels)
#         SetNextPlotTicksY(1 - 1.0/14.0, 0 + 1.0/14.0, 7, ylabels)
#         if (ImPlot.BeginPlot("##Heatmap1","","",ImVec2(225,225),ImPlotFlags_NoLegend|ImPlotFlags_NoMousePos,axes_flags,axes_flags)) 
#             ImPlot.PlotHeatmap("heat",values1[0],7,7,scale_min,scale_max)
#             ImPlot.EndPlot()
#         end
#         CImGui.SameLine()
#         ImPlot.ShowColormapScale(scale_min, scale_max, 225)
#         ImPlot.PopColormap()

#         CImGui.SameLine()

#         @cstatic values2 = zeros(Float64, 100*100)
#         Random.seed!(DEMO_TIME*1000000)
#         for i = 1:100*100
#             values2[i] = rand(0 : 0.0001 : 1)
#         end
#         @cstatic gray = [ImVec4(0,0,0,1), ImVec4(1,1,1,1)]
#         ImPlot.PushColormap(gray, 2)
#         ImPlot.SetNextPlotLimits(-1,1,-1,1)
#         if (ImPlot.BeginPlot("##Heatmap2","","",ImVec2(225,225),0,ImPlotAxisFlags_NoDecorations,ImPlotAxisFlags_NoDecorations)) 
#             ImPlot.PlotHeatmap("heat1",values2,100,100,0,1,"")
#             ImPlot.PlotHeatmap("heat2",values2,100,100,0,1,"", ImPlotPoint(-1,-1), ImPlotPoint(0,0))
#             ImPlot.EndPlot()
#         end
#         ImPlot.PopColormap()
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Images")) 
#         CImGui.BulletText("Below we are displaying the font texture, which is the only texture we have\naccess to in this demo.")
#         CImGui.BulletText("Use the 'ImTextureID' type as storage to pass pointers or identifiers to your\nown texture data.")
#         CImGui.BulletText("See ImGui Wiki page 'Image Loading and Displaying Examples'.")
#         @cstatic ImVec2 bmin(0,0)
#         @cstatic ImVec2 bmax(1,1)
#         @cstatic ImVec2 uv0(0,0)
#         @cstatic ImVec2 uv1(1,1)
#         @cstatic ImVec4 tint(1,1,1,1)
#         CImGui.SliderFloat2("Min", &bmin.x, -2, 2, "%.1f")
#         CImGui.SliderFloat2("Max", &bmax.x, -2, 2, "%.1f")
#         CImGui.SliderFloat2("UV0", &uv0.x, -2, 2, "%.1f")
#         CImGui.SliderFloat2("UV1", &uv1.x, -2, 2, "%.1f")
#         CImGui.ColorEdit4("Tint",&tint.x)
#         if (ImPlot.BeginPlot("##image", "", "", ImVec2(-1, 200)) #? no default size
#             ImPlot.PlotImage("my image",CImGui.GetIO().Fonts->TexID, bmin, bmax, uv0, uv1, tint)
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Realtime Plots")) 
#         CImGui.BulletText("Move your mouse to change the data!")
#         CImGui.BulletText("This example assumes 60 FPS. Higher FPS requires larger buffer size.")
#         @cstatic ScrollingBuffer sdata1, sdata2
#         @cstatic RollingBuffer   rdata1, rdata2
#         mouse = CImGui.GetMousePos()
#         @cstatic  t = Float32(0)
#         t += CImGui.GetIO().DeltaTime
#         sdata1.AddPoint(t, mouse.x * 0.0005)
#         rdata1.AddPoint(t, mouse.x * 0.0005)
#         sdata2.AddPoint(t, mouse.y * 0.0005)
#         rdata2.AddPoint(t, mouse.y * 0.0005)

#         @cstatic history = Float32(10.0)
#         CImGui.SliderFloat("History",&history,1,30,"%.1f s")
#         rdata1.Span = history
#         rdata2.Span = history

#         @cstatic ImPlotAxisFlags rt_axis = ImPlotAxisFlags_NoTickLabels
#         ImPlot.SetNextPlotLimitsX(t - history, t, ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##Scrolling", NULL, NULL, ImVec2(-1,150), 0, rt_axis, rt_axis | ImPlotAxisFlags_LockMin)) 
#             ImPlot.PlotShaded("Data 1", &sdata1.Data[0].x, &sdata1.Data[0].y, sdata1.Data.size(), 0, sdata1.Offset, 2 * sizeof(Float32))
#             ImPlot.PlotLine("Data 2", &sdata2.Data[0].x, &sdata2.Data[0].y, sdata2.Data.size(), sdata2.Offset, 2*sizeof(Float32))
#             ImPlot.EndPlot()
#         end
#         ImPlot.SetNextPlotLimitsX(0, history, ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##Rolling", NULL, NULL, ImVec2(-1,150), 0, rt_axis, rt_axis)) 
#             ImPlot.PlotLine("Data 1", &rdata1.Data[0].x, &rdata1.Data[0].y, rdata1.Data.size(), 0, 2 * sizeof(Float32))
#             ImPlot.PlotLine("Data 2", &rdata2.Data[0].x, &rdata2.Data[0].y, rdata2.Data.size(), 0, 2 * sizeof(Float32))
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Markers and Text")) 
#         @cstatic mk_size = ImPlot.GetStyle().MarkerSize
#         @cstatic mk_weight = ImPlot.GetStyle().MarkerWeight
#         CImGui.DragFloat("Marker Size",&mk_size,0.1,2.0,10.0,"%.2f px")
#         CImGui.DragFloat("Marker Weight", &mk_weight,0.05,0.5,3.0,"%.2f px")

#         ImPlot.SetNextPlotLimits(0, 10, 0, 12)
#         if (ImPlot.BeginPlot("##MarkerStyles", NULL, NULL, ImVec2(-1,0), ImPlotFlags_CanvasOnly, ImPlotAxisFlags_NoDecorations, ImPlotAxisFlags_NoDecorations)) 
#             xs[2] = ImS8[1,4]
#             ys[2] = ImS8[10,11]

#             # filled markers
#             for m = 1:ImPlotMarker_COUNT 
#                 CImGui.PushID(m)
#                 ImPlot.SetNextMarkerStyle(m, mk_size, IMPLOT_AUTO_COL, mk_weight)
#                 ImPlot.PlotLine("##Filled", xs, ys, 2)
#                 CImGui.PopID()
#                 ys[0]-=1; ys[1]-=1
#             end
#             xs[0] = 6; xs[1] = 9; ys[0] = 10; ys[1] = 11
#             # open markers
#             for m = 1:ImPlotMarker_COUNT 
#                 CImGui.PushID(m)
#                 ImPlot.SetNextMarkerStyle(m, mk_size, ImVec4(0,0,0,0), mk_weight)
#                 ImPlot.PlotLine("##Open", xs, ys, 2)
#                 CImGui.PopID()
#                 ys[0]-=1; ys[1]-=1
#             end

#             ImPlot.PlotText("Filled Markers", 2.5, 6.0)
#             ImPlot.PlotText("Open Markers",   7.5, 6.0)

#             ImPlot.PushStyleColor(ImPlotCol_InlayText, ImVec4(1,0,1,1))
#             ImPlot.PlotText("Vertical Text", 5.0, 6.0, true)
#             ImPlot.PopStyleColor()

#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Log Scale")) 
#         @cstatic xs, ys1, ys2, ys3 = zeros(Float64, 1001), zeros(Float64, 1001), zeros(Float64, 1001), zeros(Float64, 1001) begin
#         for i = 1:1001
#             xs[i]  = i*0.1
#             ys1[i] = sin(xs[i]) + 1
#             ys2[i] = log(xs[i])
#             ys3[i] = pow(10.0, xs[i])
#         end
#         CImGui.BulletText("Open the plot context menu (Float64 right click) to change scales.")

#         ImPlot.SetNextPlotLimits(0.1, 100, 0, 10)
#         if (ImPlot.BeginPlot("Log Plot", NULL, NULL, ImVec2(-1,0), 0, ImPlotAxisFlags_LogScale )) 
#             ImPlot.PlotLine("f(x) = x",        xs, xs,  1001)
#             ImPlot.PlotLine("f(x) = sin(x)+1", xs, ys1, 1001)
#             ImPlot.PlotLine("f(x) = log(x)",   xs, ys2, 1001)
#             ImPlot.PlotLine("f(x) = 10^x",     xs, ys3, 21)
#             ImPlot.EndPlot()
#         end
#     end
#     if (CImGui.CollapsingHeader("Time Formatted Axes")) 

#         #@cstatic t_min = Float64(1577836800) # 01/01/2020 @ 12:00:00am (UTC)
#         #@cstatic t_max = Float64(1609459200) # 01/01/2021 @ 12:00:00am (UTC)
#         t_min = parse(DateTime, "01/01/2020 @ 12:00:00am", dateformat"dd/mm/yyyy @ HH:MM:SSp") |> datetime2unix
#         t_min = parse(DateTime, "01/01/2021 @ 12:00:00am", dateformat"dd/mm/yyyy @ HH:MM:SSp") |> datetime2unix

#         CImGui.BulletText("When ImPlotAxisFlags_Time is enabled on the X-Axis, values are interpreted as\n"
#                           "UNIX timestamps in seconds and axis labels are formated as date/time.")
#         CImGui.BulletText("By default, labels are in UTC time but can be set to use local time instead.")

#         CImGui.Checkbox("Local Time",&ImPlot.GetStyle().UseLocalTime)
#         CImGui.SameLine()
#         CImGui.Checkbox("ISO 8601",&ImPlot.GetStyle().UseISO8601)
#         CImGui.SameLine()
#         CImGui.Checkbox("24 Hour Clock",&ImPlot.GetStyle().Use24HourClock)

#         @cstatic HugeTimeData* data = NULL #???
#         if (data == NULL) 
#             CImGui.SameLine()
#             if (CImGui.Button("Generate Huge Data (~500MB!)")) 
#                 @cstatic HugeTimeData sdata(t_min)
#                 data = &sdata
#             end
#         end

#         ImPlot.SetNextPlotLimits(t_min,t_max,0,1)
#         if (ImPlot.BeginPlot("##Time", NULL, NULL, ImVec2(-1,0), 0, ImPlotAxisFlags_Time)) 
#             if (data != NULL) 
#                 # downsample our data
#                 downsample = Int(ImPlot.GetPlotLimits().X.Size() / 1000 + 1)
#                 start = Int(ImPlot.GetPlotLimits().X.Min - t_min)
#                 start = start < 0 ? 0 : start > HugeTimeData.Size - 1 ? HugeTimeData.Size - 1 : start
#                 end_ = Int(ImPlot.GetPlotLimits().X.Max - t_min) + 1000
#                 end_ = end_ < 0 ? 0 : end_ > HugeTimeData.Size - 1 ? HugeTimeData.Size - 1 : end_
#                 size = (end_ - start) ÷ downsample
#                 # plot it
#                 ImPlot.PlotLine("Time Series", &data->Ts[start], &data->Ys[start], size, 0, sizeof(Float64)*downsample)
#             end
#             # plot time now
#             t_now = (Float64)time(0)
#             y_now = HugeTimeData.GetY(t_now)
#             ImPlot.PlotScatter("Now",&t_now,&y_now,1)
#             ImPlot.Annotate(t_now,y_now,ImVec2(10,10),ImPlot.GetLastItemColor(),"Now")
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Multiple Y-Axes")) 
#         @cstatic xs = zeros(Float32, 1001) xs2 = zeros(Float32, 1001) ys1 = zeros(Float32, 1001) ys2 = zeros(Float32, 1001) ys3 = zeros(Float32, 1001)
#         for i = 1:1001
#             xs[i]  = i*0.1
#             ys1[i] = sin(xs[i]) * 3 + 1
#             ys2[i] = cos(xs[i]) * 0.2 + 0.5
#             ys3[i] = sin(xs[i]+0.5) * 100 + 200
#             xs2[i] = xs[i] + 10.0
#         end
#         @cstatic y2_axis = true
#         @cstatic y3_axis = true
#         CImGui.Checkbox("Y-Axis 2", &y2_axis)
#         CImGui.SameLine()
#         CImGui.Checkbox("Y-Axis 3", &y3_axis)
#         CImGui.SameLine()

#         # you can fit axes programatically
#         CImGui.SameLine(); if (CImGui.Button("Fit X"))  ImPlot.FitNextPlotAxes(true, false, false, false)
#         CImGui.SameLine(); if (CImGui.Button("Fit Y"))  ImPlot.FitNextPlotAxes(false, true, false, false)
#         CImGui.SameLine(); if (CImGui.Button("Fit Y2")) ImPlot.FitNextPlotAxes(false, false, true, false)
#         CImGui.SameLine(); if (CImGui.Button("Fit Y3")) ImPlot.FitNextPlotAxes(false, false, false, true)

#         ImPlot.SetNextPlotLimits(0.1, 100, 0, 10)
#         ImPlot.SetNextPlotLimitsY(0, 1, ImGuiCond_Once, 1)
#         ImPlot.SetNextPlotLimitsY(0, 300, ImGuiCond_Once, 2)
#         if (ImPlot.BeginPlot("Multi-Axis Plot", NULL, NULL, ImVec2(-1,0),
#                              (y2_axis ? ImPlotFlags_YAxis2 : 0) |
#                              (y3_axis ? ImPlotFlags_YAxis3 : 0))) 
#             ImPlot.PlotLine("f(x) = x", xs, xs, 1001)
#             ImPlot.PlotLine("f(x) = sin(x)*3+1", xs, ys1, 1001)
#             if (y2_axis) 
#                 ImPlot.SetPlotYAxis(ImPlotYAxis_2)
#                 ImPlot.PlotLine("f(x) = cos(x)*.2+.5 (Y2)", xs, ys2, 1001)
#             end
#             if (y3_axis) 
#                 ImPlot.SetPlotYAxis(ImPlotYAxis_3)
#                 ImPlot.PlotLine("f(x) = sin(x+.5)*100+200 (Y3)", xs2, ys3, 1001)
#             end
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Linked Axes")) 
#         @cstatic xmin = 0., xmax = 1., ymin = 0., ymax = 1.
#         @cstatic linkx = true, linky = true
#         data = [0, 1]
#         CImGui.Checkbox("Link X", &linkx)
#         CImGui.SameLine()
#         CImGui.Checkbox("Link Y", &linky)
#         ImPlot.LinkNextPlotLimits(linkx ? &xmin : NULL , linkx ? &xmax : NULL, linky ? &ymin : NULL, linky ? &ymax : NULL)
#         if (ImPlot.BeginPlot("Plot A")) 
#             ImPlot.PlotLine("Line",data,2)
#             ImPlot.EndPlot()
#         end
#         ImPlot.LinkNextPlotLimits(linkx ? &xmin : NULL , linkx ? &xmax : NULL, linky ? &ymin : NULL, linky ? &ymax : NULL)
#         if (ImPlot.BeginPlot("Plot B")) 
#             ImPlot.PlotLine("Line",data,2)
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Equal Axes")) 
#         @cstatic xs = zeros(Float64, 1000) ys = zeros(Float64, 1000)
#         for i = 1:1000
#             angle = i * 2 * PI / 999.0
#             xs[i] = cos(angle)
#             ys[i] = sin(angle)
#         end
#         ImPlot.SetNextPlotLimits(-1,1,-1,1)
#         if (ImPlot.BeginPlot("",0,0,ImVec2(-1,0),ImPlotFlags_Equal)) 
#             ImPlot.PlotLine("Circle",xs,ys,1000)
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Querying")) 
#         @cstatic data = ImPlotPoint[] #? ImVector<ImPlotPoint> data
#         @cstatic ImPlotLimits range, query

#         CImGui.BulletText("Ctrl + click in the plot area to draw points.")
#         CImGui.BulletText("Middle click (or Ctrl + right click) and drag to create a query rect.")
#         CImGui.Indent()
#             CImGui.BulletText("Hold Alt to expand query horizontally.")
#             CImGui.BulletText("Hold Shift to expand query vertically.")
#             CImGui.BulletText("The query rect can be dragged after it's created.")
#         CImGui.Unindent()

#         if (ImPlot.BeginPlot("##Drawing", NULL, NULL, ImVec2(-1,0), ImPlotFlags_Query, ImPlotAxisFlags_NoDecorations, ImPlotAxisFlags_NoDecorations)) 
#             if (ImPlot.IsPlotHovered() && CImGui.IsMouseClicked(0) && CImGui.GetIO().KeyCtrl) 
#                 pt = ImPlot.GetPlotMousePos()
#                 data.push_back(pt)
#             end
#             if (data.size() > 0)
#                 ImPlot.PlotScatter("Points", &data[0].x, &data[0].y, data.size(), 0, 2 * sizeof(Float64))
#             if (ImPlot.IsPlotQueried() && data.size() > 0) 
#                 range2 = ImPlot.GetPlotQuery()
#                 cnt = 0
#                 avg::ImPlotPoint
#                 for i = 1:data.size()
#                     if (range2.Contains(data[i].x, data[i].y)) 
#                         avg.x += data[i].x
#                         avg.y += data[i].y
#                         cnt+=1
#                     end
#                 end
#                 if (cnt > 0) 
#                     avg.x = avg.x / cnt
#                     avg.y = avg.y / cnt
#                     ImPlot.SetNextMarkerStyle(ImPlotMarker_Square)
#                     ImPlot.PlotScatter("Average", &avg.x, &avg.y, 1)
#                 end
#             end
#             range = ImPlot.GetPlotLimits()
#             query = ImPlot.GetPlotQuery()
#             ImPlot.EndPlot()
#         end
#         CImGui.Text("The current plot limits are:  [%g,%g,%g,%g]", range.X.Min, range.X.Max, range.Y.Min, range.Y.Max)
#         CImGui.Text("The current query limits are: [%g,%g,%g,%g]", query.X.Min, query.X.Max, query.Y.Min, query.Y.Max)
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Views")) 
#         # mimic's soulthread's imgui_plot demo
#         @cstatic x_data = zeros(Float32, 512)
#         @cstatic y_data1 = zeros(Float32, 512)
#         @cstatic y_data2 = zeros(Float32, 512)
#         @cstatic y_data3 = zeros(Float32, 512)
#         @cstatic sampling_freq = Float32(44100)
#         @cstatic freq = Float32(500)
#         for i = 1:512
#             t = Float32(i / sampling_freq)
#             x_data[i] = t
#             arg = Float32(2 * 3.14 * freq * t)
#             y_data1[i] = sin(arg)
#             y_data2[i] = y_data1[i] * -0.6 + sin(2 * arg) * 0.4
#             y_data3[i] = y_data2[i] * -0.6 + sin(3 * arg) * 0.4
#         end
#         CImGui.BulletText("Query the first plot to render a subview in the second plot (see above for controls).")
#         ImPlot.SetNextPlotLimits(0,0.01,-1,1)
#         flags = ImPlotAxisFlags_NoTickLabels
#         query = ImPlotLimits() #? defaults
#         if (ImPlot.BeginPlot("##View1",NULL,NULL,ImVec2(-1,150), ImPlotFlags_Query, flags, flags)) 
#             ImPlot.PlotLine("Signal 1", x_data, y_data1, 512)
#             ImPlot.PlotLine("Signal 2", x_data, y_data2, 512)
#             ImPlot.PlotLine("Signal 3", x_data, y_data3, 512)
#             query = ImPlot.GetPlotQuery()
#             ImPlot.EndPlot()
#         end
#         ImPlot.SetNextPlotLimits(query.X.Min, query.X.Max, query.Y.Min, query.Y.Max, ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##View2",NULL,NULL,ImVec2(-1,150), ImPlotFlags_CanvasOnly, ImPlotAxisFlags_NoDecorations, ImPlotAxisFlags_NoDecorations)) 
#             ImPlot.PlotLine("Signal 1", x_data, y_data1, 512)
#             ImPlot.PlotLine("Signal 2", x_data, y_data2, 512)
#             ImPlot.PlotLine("Signal 3", x_data, y_data3, 512)
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Legend")) 
#         @cstatic loc = ImPlotLocation_East h = false o = true
#             CImGui.CheckboxFlags("North", (unsigned Int*)&loc, ImPlotLocation_North); CImGui.SameLine()
#             CImGui.CheckboxFlags("South", (unsigned Int*)&loc, ImPlotLocation_South); CImGui.SameLine()
#             CImGui.CheckboxFlags("West",  (unsigned Int*)&loc, ImPlotLocation_West);  CImGui.SameLine()
#             CImGui.CheckboxFlags("East",  (unsigned Int*)&loc, ImPlotLocation_East);  CImGui.SameLine()
#             CImGui.Checkbox("Horizontal", &h); CImGui.SameLine()
#             CImGui.Checkbox("Outside", &o)

#             CImGui.SliderFloat2("LegendPadding", (Float32*)&GetStyle().LegendPadding, 0.0, 20.0, "%.0f")
#             CImGui.SliderFloat2("LegendInnerPadding", (Float32*)&GetStyle().LegendInnerPadding, 0.0, 10.0, "%.0f")
#             CImGui.SliderFloat2("LegendSpacing", (Float32*)&GetStyle().LegendSpacing, 0.0, 5.0, "%.0f")

#             if (ImPlot.BeginPlot("##Legend","x","y",ImVec2(-1,0))) 
#                 ImPlot.SetLegendLocation(loc, h ? ImPlotOrientation_Horizontal : ImPlotOrientation_Vertical, o)
#                 @cstatic data1 = MyImPlot.WaveData(0.001, 0.2, 2, 0.75)
#                 @cstatic data2 = MyImPlot.WaveData(0.001, 0.2, 4, 0.25)
#                 @cstatic data3 = MyImPlot.WaveData(0.001, 0.2, 6, 0.5)
#                 ImPlot.PlotLineG("Item 1", MyImPlot.SineWave, &data1, 1000)         # "Item 1" added to legend
#                 ImPlot.PlotLineG("Item 2##IDText", MyImPlot.SawWave, &data2, 1000)  # "Item 2" added to legend, text after ## used for ID only
#                 ImPlot.PlotLineG("##NotListed", MyImPlot.SawWave, &data3, 1000)     # plotted, but not added to legend
#                 ImPlot.PlotLineG("Item 3", MyImPlot.SineWave, &data1, 1000)         # "Item 3" added to legend
#                 ImPlot.PlotLineG("Item 3", MyImPlot.SawWave,  &data2, 1000)         # combined with previous "Item 3"
#                 ImPlot.EndPlot()
#             end
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Drag Lines and Points")) 
#         CImGui.BulletText("Click and drag the horizontal and vertical lines.")
#         @cstatic x1 = 0.2
#         @cstatic x2 = 0.8
#         @cstatic y1 = 0.25
#         @cstatic y2 = 0.75
#         @cstatic f = 0.1
#         @cstatic show_labels = true
#         CImGui.Checkbox("Show Labels##1",&show_labels)
#         if (ImPlot.BeginPlot("##guides",0,0,ImVec2(-1,0),ImPlotFlags_YAxis2)) 
#             ImPlot.DragLineX("x1",&x1,show_labels)
#             ImPlot.DragLineX("x2",&x2,show_labels)
#             ImPlot.DragLineY("y1",&y1,show_labels)
#             ImPlot.DragLineY("y2",&y2,show_labels)
#             xs = zeros(Float64, 1000)
#             ys = zeros(Float64, 1000)
#             for i = 1:1000
#                 xs[i] = (x2+x1)/2+abs(x2-x1)*(i/1000.0 - 0.5)
#                 ys[i] = (y1+y2)/2+abs(y2-y1)/2*sin(f*i/10)
#             end
#             ImPlot.PlotLine("Interactive Data", xs, ys, 1000)
#             ImPlot.SetPlotYAxis(ImPlotYAxis_2)
#             ImPlot.DragLineY("f",&f,show_labels,ImVec4(1,0.5,1,1))
#             ImPlot.EndPlot()
#         end
#         CImGui.BulletText("Click and drag any point.")
#         CImGui.Checkbox("Show Labels##2",&show_labels)
#         ImPlotAxisFlags flags = ImPlotAxisFlags_NoTickLabels | ImPlotAxisFlags_NoTickMarks
#         if (ImPlot.BeginPlot("##Bezier",0,0,ImVec2(-1,0),ImPlotFlags_CanvasOnly,flags,flags)) 
#             @cstatic ImPlotPoint P[] = ImPlotPoint(.05,.05), ImPlotPoint(0.2,0.4),  ImPlotPoint(0.8,0.6),  ImPlotPoint(.95,.95)end
#             @cstatic ImPlotPoint B[100]
#             for i = 1:100
#                 t  = i / 99.0
#                 u  = 1 - t
#                 w1 = u*u*u
#                 w2 = 3*u*u*t
#                 w3 = 3*u*t*t
#                 w4 = t*t*t
#                 B[i] = ImPlotPoint(w1*P[0].x + w2*P[1].x + w3*P[2].x + w4*P[3].x, w1*P[0].y + w2*P[1].y + w3*P[2].y + w4*P[3].y)
#             end
#             ImPlot.SetNextLineStyle(ImVec4(0,0.9,0,1), 2)
#             ImPlot.PlotLine("##bez",&B[0].x, &B[0].y, 100, 0, sizeof(ImPlotPoint))
#             ImPlot.SetNextLineStyle(ImVec4(1,0.5,1,1))
#             ImPlot.PlotLine("##h1",&P[0].x, &P[0].y, 2, 0, sizeof(ImPlotPoint))
#             ImPlot.SetNextLineStyle(ImVec4(0,0.5,1,1))
#             ImPlot.PlotLine("##h2",&P[2].x, &P[2].y, 2, 0, sizeof(ImPlotPoint))
#             ImPlot.DragPoint("P0",&P[0].x,&P[0].y, show_labels, ImVec4(0,0.9,0,1))
#             ImPlot.DragPoint("P1",&P[1].x,&P[1].y, show_labels, ImVec4(1,0.5,1,1))
#             ImPlot.DragPoint("P2",&P[2].x,&P[2].y, show_labels, ImVec4(0,0.5,1,1))
#             ImPlot.DragPoint("P3",&P[3].x,&P[3].y, show_labels, ImVec4(0,0.9,0,1))
#             ImPlot.EndPlot()
#         end
#     end
#     if (CImGui.CollapsingHeader("Annotations")) 
#         @cstatic clamp = false
#         CImGui.Checkbox("Clamp",&clamp)
#         ImPlot.SetNextPlotLimits(0,2,0,1)
#         if (ImPlot.BeginPlot("##Annotations")) 

#             @cstatic p = Float32[0.25, 0.25, 0.75, 0.75, 0.25]
#             ImPlot.PlotScatter("##Points",&p[0],&p[1],4)
#             ImVec4 col = GetLastItemColor()
#             clamp ? ImPlot.AnnotateClamped(0.25,0.25,ImVec2(-15,15),col,"BL") : ImPlot.Annotate(0.25,0.25,ImVec2(-15,15),col,"BL")
#             clamp ? ImPlot.AnnotateClamped(0.75,0.25,ImVec2(15,15),col,"BR") : ImPlot.Annotate(0.75,0.25,ImVec2(15,15),col,"BR")
#             clamp ? ImPlot.AnnotateClamped(0.75,0.75,ImVec2(15,-15),col,"TR") : ImPlot.Annotate(0.75,0.75,ImVec2(15,-15),col,"TR")
#             clamp ? ImPlot.AnnotateClamped(0.25,0.75,ImVec2(-15,-15),col,"TL") : ImPlot.Annotate(0.25,0.75,ImVec2(-15,-15),col,"TL")
#             clamp ? ImPlot.AnnotateClamped(0.5,0.5,ImVec2(0,0),col,"Center") : ImPlot.Annotate(0.5,0.5,ImVec2(0,0),col,"Center")

#             bx = Float32[1.2, 1.5, 1.8]
#             by = Float32[0.25, 0.5, 0.75]
#             ImPlot.PlotBars("##Bars",bx,by,3,0.2)
#             for i = 1:3
#                 ImPlot.Annotate(bx[i],by[i],ImVec2(0,-5),"B[%d]=%.2f",i,by[i])
#             end
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Drag and Drop")) 
#         K_CHANNELS = 9
#         Random.seed!(10000000 * DEMO_TIME)
#         @cstatic paused = false
#         @cstatic init = true
#         @cstatic data = ScrollingBuffer(K_CHANNELS) # ???
#         @cstatic show = falses[K_CHANNELS]
#         @cstatic yAxis = zeros(Int, K_CHANNELS)
#         if (init) 
#             for i = 1:K_CHANNELS
#                 show[i] = false
# 				yAxis[i] = 0
#             end
#             init = false
#         end
#         CImGui.BulletText("Drag data items from the left column onto the plot or onto a specific y-axis.")
#         CImGui.BulletText("Redrag data items from the legend onto other y-axes.")
#         CImGui.BeginGroup()
#         if (CImGui.Button("Clear", ImVec2(100, 0))) 
#             for i = 1:K_CHANNELS
#                 show[i] = false
#                 data[i].Data.shrink(0)
#                 data[i].Offset = 0
#             end
#         end
#         if (CImGui.Button(paused ? "Resume" : "Pause", ImVec2(100,0)))
#             paused = !paused
#         for i = 1:K_CHANNELS
#             char label[16]
#             sprintf(label, show[i] ? "data_%d (Y%d)" : "data_%d", i, yAxis[i]+1)
#             CImGui.Selectable(label, false, 0, ImVec2(100, 0))
#             if (CImGui.BeginDragDropSource(ImGuiDragDropFlags_None)) 
#                 CImGui.SetDragDropPayload("DND_PLOT", &i, sizeof(Int))
#                 CImGui.TextUnformatted(label)
#                 CImGui.EndDragDropSource()
#             end
#         end
#         CImGui.EndGroup()
#         CImGui.SameLine()
#         Random.seed!(10000000 * DEMO_TIME)
#         @cstatic t = Float32(0)
#         if (!paused) 
#             t += CImGui.GetIO().DeltaTime
#             for i = 1:K_CHANNELS
#                 if (show[i])
#                     data[i].AddPoint(t, (i+1)*0.1 + rand(-0.01 : 0.000001 : 0.01))
#             end
#         end
#         ImPlot.SetNextPlotLimitsX((Float64)t - 10, t, paused ? ImGuiCond_Once : ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##DND", NULL, NULL, ImVec2(-1,0), ImPlotFlags_YAxis2 | ImPlotFlags_YAxis3, ImPlotAxisFlags_NoTickLabels)) 
#             for i = 1:K_CHANNELS
#                 if (show[i] && data[i].Data.size() > 0) 
#                     char label[K_CHANNELS]
#                     sprintf(label, "data_%d", i)
# 					ImPlot.SetPlotYAxis(yAxis[i])
#                     ImPlot.PlotLine(label, &data[i].Data[0].x, &data[i].Data[0].y, data[i].Data.size(), data[i].Offset, 2 * sizeof(Float32))
#                     # allow legend labels to be dragged and dropped
#                     if (ImPlot.BeginLegendDragDropSource(label)) 
#                         CImGui.SetDragDropPayload("DND_PLOT", &i, sizeof(Int))
#                         CImGui.TextUnformatted(label)
#                         ImPlot.EndLegendDragDropSource()
#                     end
#                 end
#             end
#             # make our plot a drag and drop target
# 			if (CImGui.BeginDragDropTarget()) 
# 				if (const ImGuiPayload* payload = CImGui.AcceptDragDropPayload("DND_PLOT")) 
# 					Int i = *(Int*)payload->Data
# 					show[i] = true
#                     yAxis[i] = 0
#                     # set specific y-axis if hovered
# 					for y = 0:2 #? 1:3 
# 						if (ImPlot.IsPlotYAxisHovered(y))
# 							yAxis[i] = y
# 					end
# 				end
# 				CImGui.EndDragDropTarget()
# 			end
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Digital and Analog Signals")) 
#         @cstatic paused = false
#         #define K_PLOT_DIGITAL_CH_COUNT 4
#         #define K_PLOT_ANALOG_CH_COUNT  4
#         @cstatic ScrollingBuffer dataDigital[K_PLOT_DIGITAL_CH_COUNT]
#         @cstatic ScrollingBuffer dataAnalog[K_PLOT_ANALOG_CH_COUNT]
#         @cstatic showDigital[K_PLOT_DIGITAL_CH_COUNT]
#         @cstatic showAnalog[K_PLOT_ANALOG_CH_COUNT]

#         CImGui.BulletText("You can plot digital and analog signals on the same plot.")
#         CImGui.BulletText("Digital signals do not respond to Y drag and zoom, so that")
#         CImGui.Indent()
#         CImGui.Text("you can drag analog signals over the rising/falling digital edge.")
#         CImGui.Unindent()
#         CImGui.BeginGroup()
#         if (CImGui.Button("Clear", ImVec2(100, 0))) 
#             for i = 1:K_PLOT_DIGITAL_CH_COUNT
#                 showDigital[i] = false
#             for i = 1:K_PLOT_ANALOG_CH_COUNT
#                 showAnalog[i] = false
#         end
#         if (CImGui.Button(paused ? "Resume" : "Pause", ImVec2(100,0)))
#             paused = !paused
#         for i = 1:K_PLOT_DIGITAL_CH_COUNT
#             char label[32]
#             sprintf(label, "digital_%d", i)
#             CImGui.Checkbox(label, &showDigital[i])
#             if (CImGui.BeginDragDropSource(ImGuiDragDropFlags_None)) 
#                 CImGui.SetDragDropPayload("DND_DIGITAL_PLOT", &i, sizeof(Int))
#                 CImGui.TextUnformatted(label)
#                 CImGui.EndDragDropSource()
#             end
#         end
#         for i = 1:K_PLOT_ANALOG_CH_COUNT
#             char label[32]
#             sprintf(label, "analog_%d", i)
#             CImGui.Checkbox(label, &showAnalog[i])
#             if (CImGui.BeginDragDropSource(ImGuiDragDropFlags_None)) 
#                 CImGui.SetDragDropPayload("DND_ANALOG_PLOT", &i, sizeof(Int))
#                 CImGui.TextUnformatted(label)
#                 CImGui.EndDragDropSource()
#             end
#         end
#         CImGui.EndGroup()
#         CImGui.SameLine()
#         @cstatic t = Float32(0)
#         if (!paused) 
#             t += CImGui.GetIO().DeltaTime
#             #digital signal values
#             i = 0
#             if (showDigital[i])
#                 dataDigital[i].AddPoint(t, sinf(2*t) > 0.45)
#             end
#             i += 1
#             if (showDigital[i])
#                 dataDigital[i].AddPoint(t, sinf(2*t) < 0.45)
#             end
#             i += 1
#             if (showDigital[i])
#                 dataDigital[i].AddPoint(t, fmodf(t,5.0))
#             end
#             i += 1
#             if (showDigital[i])
#                 dataDigital[i].AddPoint(t, sinf(2*t) < 0.17)
#             end
#             #Analog signal values
#             i = 0
#             if (showAnalog[i])
#                 dataAnalog[i].AddPoint(t, sinf(2*t))
#             end
#             i += 1
#             if (showAnalog[i])
#                 dataAnalog[i].AddPoint(t, cosf(2*t))
#             end
#             i += 1
#             if (showAnalog[i])
#                 dataAnalog[i].AddPoint(t, sinf(2*t) * cosf(2*t))
#             end
#             i += 1
#             if (showAnalog[i])
#                 dataAnalog[i].AddPoint(t, sinf(2*t) - cosf(2*t))
#             end
#         end
#         ImPlot.SetNextPlotLimitsY(-1, 1)
#         ImPlot.SetNextPlotLimitsX(t - 10.0, t, paused ? ImGuiCond_Once : ImGuiCond_Always)
#         if (ImPlot.BeginPlot("##Digital")) 
#             for i = 1:K_PLOT_DIGITAL_CH_COUNT
#                 if (showDigital[i] && dataDigital[i].Data.size() > 0) 
#                     char label[32]
#                     sprintf(label, "digital_%d", i)
#                     ImPlot.PlotDigital(label, &dataDigital[i].Data[0].x, &dataDigital[i].Data[0].y, dataDigital[i].Data.size(), dataDigital[i].Offset, 2 * sizeof(Float32))
#                 end
#             end
#             for i = 1:K_PLOT_ANALOG_CH_COUNT
#                 if (showAnalog[i]) 
#                     char label[32]
#                     sprintf(label, "analog_%d", i)
#                     if (dataAnalog[i].Data.size() > 0)
#                         ImPlot.PlotLine(label, &dataAnalog[i].Data[0].x, &dataAnalog[i].Data[0].y, dataAnalog[i].Data.size(), dataAnalog[i].Offset, 2 * sizeof(Float32))
#                 end
#             end
#             ImPlot.EndPlot()
#         end
#         if (CImGui.BeginDragDropTarget()) 
#            #=const ImGuiPayload*=# payload = CImGui.AcceptDragDropPayload("DND_DIGITAL_PLOT")
#             if (payload) 
#                 i = payload.Data #? int i = *(int*)payload->Data
#                 showDigital[i] = true

#             else
            
#                 payload = CImGui.AcceptDragDropPayload("DND_ANALOG_PLOT")
#                 if (payload) 
#                     i = payload.Data #int i = *(int*)payload->Data
#                     showAnalog[i] = true
#                 end
#             end
#             CImGui.EndDragDropTarget()
#         end
#     end
#     if (CImGui.CollapsingHeader("Tables")) 
# #ifdef IMGUI_HAS_TABLE
#         @cstatic ImGuiTableFlags flags = ImGuiTableFlags_BordersOuter | ImGuiTableFlags_BordersV | ImGuiTableFlags_RowBg
#         @cstatic anim = true
#         @cstatic offset = 0
#         CImGui.BulletText("Plots can be used inside of ImGui tables.")
#         CImGui.Checkbox("Animate",&anim)
#         if (anim)
#             offset = (offset + 1) % 100
#         if (CImGui.BeginTable("##table", 3, flags, ImVec2(-1,0))) 
#             CImGui.TableSetupColumn("Electrode", ImGuiTableColumnFlags_WidthFixed, 75.0)
#             CImGui.TableSetupColumn("Voltage", ImGuiTableColumnFlags_WidthFixed, 75.0)
#             CImGui.TableSetupColumn("EMG Signal")
#             CImGui.TableHeadersRow()
#             ImPlot.PushColormap(ImPlotColormap_Cool)
#             for row = 0:9  #? 1:10
#                 CImGui.TableNextRow()
#                 @cstatic data = zeros(Float32, 100)
#                 Random.seed!(row)
#                 for i = 1:100
#                     data[i] = rand(0.0 : 0.0001 : 10.0)
#                 end
#                 CImGui.TableSetColumnIndex(0)
#                 CImGui.Text("EMG %d", row)
#                 CImGui.TableSetColumnIndex(1)
#                 CImGui.Text("%.3f V", data[offset])
#                 CImGui.TableSetColumnIndex(2)
#                 CImGui.PushID(row)
#                 MyImPlot.Sparkline("##spark",data,100,0,11.0,offset,ImPlot.GetColormapColor(row),ImVec2(-1, 35))
#                 CImGui.PopID()
#             end
#             ImPlot.PopColormap()
#             CImGui.EndTable()
#         end
# #else
#     CImGui.BulletText("You need to merge the ImGui 'tables' branch for this section.")
# #endif
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Offset and Stride")) 
#         @cstatic k_circles    = 11
#         @cstatic k_points_per = 50
#         @cstatic k_size       = 2 * k_points_per * k_circles
#         @cstatic interleaved_data = zeros(Float64, k_size)
#         for p = 0:k_points_per-1 #? 1:k_points_per
#             for c = 0:k_circles-1  #? 1:k_circles
#                 r = c / (k_circles - 1) * 0.2 + 0.2
#                 interleaved_data[1 + p*2*k_circles + 2*c + 0] = 0.5 + r * cos(p/k_points_per * 6.28)
#                 interleaved_data[1 + p*2*k_circles + 2*c + 1] = 0.5 + r * sin(p/k_points_per * 6.28)
#             end
#         end
#         @cstatic offset = 0
#         CImGui.BulletText("Offsetting is useful for realtime plots (see above) and circular buffers.")
#         CImGui.BulletText("Striding is useful for interleaved data (e.g. audio) or plotting structs.")
#         CImGui.BulletText("Here, all circle data is stored in a single interleaved buffer:")
#         CImGui.BulletText("[c0.x0 c0.y0 ... cn.x0 cn.y0 c0.x1 c0.y1 ... cn.x1 cn.y1 ... cn.xm cn.ym]")
#         CImGui.BulletText("The offset value indicates which circle point index is considered the first.")
#         CImGui.BulletText("Offsets can be negative and/or larger than the actual data count.")
#         CImGui.SliderInt("Offset", &offset, -2*k_points_per, 2*k_points_per)
#         if (ImPlot.BeginPlot("##strideoffset",0,0,ImVec2(-1,0), ImPlotFlags_Equal)) 
#             ImPlot.PushColormap(ImPlotColormap_Jet)
#             char buff[16]
#             for c = 0:k_circles-1 #? 1:k_circles
#                 sprintf(buff, "Circle %d", c)
#                 ImPlot.PlotLine(buff, &interleaved_data[c*2 + 0], &interleaved_data[c*2 + 1], k_points_per, offset, 2*k_circles*sizeof(Float64))
#             end
#             ImPlot.EndPlot()
#             ImPlot.PopColormap()
#         end
#         # offset++ uncomment for animation!
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Data and Getters")) 
#         CImGui.BulletText("You can plot custom structs using the stride feature.")
#         CImGui.BulletText("Most plotters can also be passed a function pointer for getting data.")
#         CImGui.Indent()
#             CImGui.BulletText("You can optionally pass user data to be given to your getter function.")
#             CImGui.BulletText("C++ lambdas can be passed as function pointers as well!")
#         CImGui.Unindent()

#         vec2_data = [MyImPlot.Vector2f(0,0), MyImPlot.Vector2f(1,1)]

#         if (ImPlot.BeginPlot("##Custom Data")) 

#             # custom structs using stride example:
#             ImPlot.PlotLine("Vector2f", &vec2_data[0].x, &vec2_data[0].y, 2, 0, sizeof(MyImPlot.Vector2f) /* or sizeof(Float32) * 2 */)

#             # custom getter example 1:
#             ImPlot.PlotLineG("Spiral", MyImPlot.Spiral, NULL, 1000)

#             # custom getter example 2:
#             @cstatic data1 = MyImPlot.WaveData(0.001, 0.2, 2, 0.75)
#             @cstatic data2 = MyImPlot.WaveData(0.001, 0.2, 4, 0.25)
#             ImPlot.PlotLineG("Waves", MyImPlot.SineWave, &data1, 1000)
#             ImPlot.PlotLineG("Waves", MyImPlot.SawWave, &data2, 1000)
#             ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, 0.25)
#             ImPlot.PlotShadedG("Waves", MyImPlot.SineWave, &data1, MyImPlot.SawWave, &data2, 1000)
#             ImPlot.PopStyleVar()

#             # you can also pass C++ lambdas:
#             # auto lamda = [](void* data, Int idx)  ... return ImPlotPoint(x,y) end
#             # ImPlot.PlotLine("My Lambda", lambda, data, 1000)

#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Ticks##")) 
#         @cstatic custom_ticks  = true
#         @cstatic custom_labels = true
#         CImGui.Checkbox("Show Custom Ticks", &custom_ticks)
#         if (custom_ticks) 
#             CImGui.SameLine()
#             CImGui.Checkbox("Show Custom Labels", &custom_labels)
#         end
#         pi = 3.14
#         pi_str = "PI"
#         @cstatic yticks[] = Float64[1,3,7,9]
#         @cstatic ylabels[] = ["One","Three","Seven","Nine"]
#         @cstatic yticks_aux[] = [0.2,0.4,0.6]
#         @cstatic ylabels_aux[] = ["A","B","C","D","E","F"]
#         if (custom_ticks)
#             ImPlot.SetNextPlotTicksX(&pi,1,custom_labels ? pi_str : NULL, true)
#             ImPlot.SetNextPlotTicksY(yticks, 4, custom_labels ? ylabels : NULL)
#             ImPlot.SetNextPlotTicksY(yticks_aux, 3, custom_labels ? ylabels_aux : NULL, false, 1)
#             ImPlot.SetNextPlotTicksY(0, 1, 6, custom_labels ? ylabels_aux : NULL, false, 2)
#         end
#         ImPlot.SetNextPlotLimits(2.5,5,0,10)
#         if (ImPlot.BeginPlot("Custom Ticks", NULL, NULL, ImVec2(-1,0), ImPlotFlags_YAxis2 | ImPlotFlags_YAxis3)) 
#             # nothing to see here, just the ticks
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Styles")) 
#         ImPlot.PushColormap(ImPlotColormap_Deep)
#         # normally you wouldn't change the entire style each frame
#         ImPlotStyle backup = ImPlot.GetStyle()
#         MyImPlot.StyleSeaborn()
#         ImPlot.SetNextPlotLimits(-0.5, 9.5, 0, 10)
#         if (ImPlot.BeginPlot("seaborn style", "x-axis", "y-axis")) 
#             lin = UInt[8,8,9,7,8,8,8,9,7,8]
#             bar = UInt[1,2,5,3,4,1,2,5,3,4]
#             dot = UInt[7,6,6,7,8,5,6,5,8,7]
#             ImPlot.PlotBars("Bars", bar, 10, 0.5)
#             ImPlot.PlotLine("Line", lin, 10)
#             ImPlot.NextColormapColor() # skip green
#             ImPlot.PlotScatter("Scatter", dot, 10)
#             ImPlot.EndPlot()
#         end
#         ImPlot.GetStyle() = backup
#         ImPlot.PopColormap()
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Rendering")) 
#         if (ImPlot.BeginPlot("##CustomRend")) 
#             ImVec2 cntr = ImPlot.PlotToPixels(ImPlotPoint(0.5,  0.5))
#             ImVec2 rmin = ImPlot.PlotToPixels(ImPlotPoint(0.25, 0.75))
#             ImVec2 rmax = ImPlot.PlotToPixels(ImPlotPoint(0.75, 0.25))
#             ImPlot.PushPlotClipRect()
#             ImPlot.GetPlotDrawList()->AddCircleFilled(cntr,20,IM_COL32(255,255,0,255),20)
#             ImPlot.GetPlotDrawList()->AddRect(rmin, rmax, IM_COL32(128,0,255,255))
#             ImPlot.PopPlotClipRect()
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Context Menus")) 
#         CImGui.BulletText("You can implement legend context menus to inject per-item controls and widgets.")
#         CImGui.BulletText("Right click the legend label/icon to edit custom item attributes.")

#         @cstatic frequency = Float32(0.1) #? is it critical to use Float32 here?
#         @cstatic amplitude = Float32(0.5)
#         @cstatic color     = ImVec4(1,1,0,1)
#         @cstatic alpha     = Float32(1.0)
#         @cstatic line      = false
#         @cstatic thickness = Float32(1)
#         @cstatic markers   = false
#         @cstatic shaded    = false

#         @cstatic vals = zeros(Float32, 101)
#         for i = 1:101
#             vals[i] = amplitude * sin(frequency * i)
#         end
#         ImPlot.SetNextPlotLimits(0,100,-1,1)
#         if (ImPlot.BeginPlot("Right Click the Legend")) 
#             # rendering logic
#             ImPlot.PushStyleVar(ImPlotStyleVar_FillAlpha, alpha)
#             if (!line) 
#                 ImPlot.SetNextFillStyle(color)
#                 ImPlot.PlotBars("Right Click Me", vals, 101)
#             else 
#                 if (markers) ImPlot.SetNextMarkerStyle(ImPlotMarker_Circle)
#                 ImPlot.SetNextLineStyle(color, thickness)
#                 ImPlot.PlotLine("Right Click Me", vals, 101)
#                 if (shaded) ImPlot.PlotShaded("Right Click Me",vals,101)
#             end
#             ImPlot.PopStyleVar()
#             # custom legend context menu
#             if (ImPlot.BeginLegendPopup("Right Click Me")) 
#                 CImGui.SliderFloat("Frequency",&frequency,0,1,"%0.2f")
#                 CImGui.SliderFloat("Amplitude",&amplitude,0,1,"%0.2f")
#                 CImGui.Separator()
#                 CImGui.ColorEdit3("Color",&color.x)
#                 CImGui.SliderFloat("Transparency",&alpha,0,1,"%.2f")
#                 CImGui.Checkbox("Line Plot", &line)
#                 if (line) 
#                     CImGui.SliderFloat("Thickness", &thickness, 0, 5)
#                     CImGui.Checkbox("Markers", &markers)
#                     CImGui.Checkbox("Shaded",&shaded)
#                 end
#                 ImPlot.EndLegendPopup()
#             end
#             ImPlot.EndPlot()
#         end
#     end
#     #-------------------------------------------------------------------------
#     if (CImGui.CollapsingHeader("Custom Plotters and Tooltips")) 
#         CImGui.BulletText("You can create custom plotters or extend ImPlot using implot_internal.h.")
# 		dates  = [1546300800,1546387200,1546473600,1546560000,1546819200,1546905600,1546992000,1547078400,1547164800,1547424000,1547510400,1547596800,1547683200,1547769600,1547942400,1548028800,1548115200,1548201600,1548288000,1548374400,1548633600,1548720000,1548806400,1548892800,1548979200,1549238400,1549324800,1549411200,1549497600,1549584000,1549843200,1549929600,1550016000,1550102400,1550188800,1550361600,1550448000,1550534400,1550620800,1550707200,1550793600,1551052800,1551139200,1551225600,1551312000,1551398400,1551657600,1551744000,1551830400,1551916800,1552003200,1552262400,1552348800,1552435200,1552521600,1552608000,1552867200,1552953600,1553040000,1553126400,1553212800,1553472000,1553558400,1553644800,1553731200,1553817600,1554076800,1554163200,1554249600,1554336000,1554422400,1554681600,1554768000,1554854400,1554940800,1555027200,1555286400,1555372800,1555459200,1555545600,1555632000,1555891200,1555977600,1556064000,1556150400,1556236800,1556496000,1556582400,1556668800,1556755200,1556841600,1557100800,1557187200,1557273600,1557360000,1557446400,1557705600,1557792000,1557878400,1557964800,1558051200,1558310400,1558396800,1558483200,1558569600,1558656000,1558828800,1558915200,1559001600,1559088000,1559174400,1559260800,1559520000,1559606400,1559692800,1559779200,1559865600,1560124800,1560211200,1560297600,1560384000,1560470400,1560729600,1560816000,1560902400,1560988800,1561075200,1561334400,1561420800,1561507200,1561593600,1561680000,1561939200,1562025600,1562112000,1562198400,1562284800,1562544000,1562630400,1562716800,1562803200,1562889600,1563148800,1563235200,1563321600,1563408000,1563494400,1563753600,1563840000,1563926400,1564012800,1564099200,1564358400,1564444800,1564531200,1564617600,1564704000,1564963200,1565049600,1565136000,1565222400,1565308800,1565568000,1565654400,1565740800,1565827200,1565913600,1566172800,1566259200,1566345600,1566432000,1566518400,1566777600,1566864000,1566950400,1567036800,1567123200,1567296000,1567382400,1567468800,1567555200,1567641600,1567728000,1567987200,1568073600,1568160000,1568246400,1568332800,1568592000,1568678400,1568764800,1568851200,1568937600,1569196800,1569283200,1569369600,1569456000,1569542400,1569801600,1569888000,1569974400,1570060800,1570147200,1570406400,1570492800,1570579200,1570665600,1570752000,1571011200,1571097600,1571184000,1571270400,1571356800,1571616000,1571702400,1571788800,1571875200,1571961600]
# 		opens  = [1284.7,1319.9,1318.7,1328,1317.6,1321.6,1314.3,1325,1319.3,1323.1,1324.7,1321.3,1323.5,1322,1281.3,1281.95,1311.1,1315,1314,1313.1,1331.9,1334.2,1341.3,1350.6,1349.8,1346.4,1343.4,1344.9,1335.6,1337.9,1342.5,1337,1338.6,1337,1340.4,1324.65,1324.35,1349.5,1371.3,1367.9,1351.3,1357.8,1356.1,1356,1347.6,1339.1,1320.6,1311.8,1314,1312.4,1312.3,1323.5,1319.1,1327.2,1332.1,1320.3,1323.1,1328,1330.9,1338,1333,1335.3,1345.2,1341.1,1332.5,1314,1314.4,1310.7,1314,1313.1,1315,1313.7,1320,1326.5,1329.2,1314.2,1312.3,1309.5,1297.4,1293.7,1277.9,1295.8,1295.2,1290.3,1294.2,1298,1306.4,1299.8,1302.3,1297,1289.6,1302,1300.7,1303.5,1300.5,1303.2,1306,1318.7,1315,1314.5,1304.1,1294.7,1293.7,1291.2,1290.2,1300.4,1284.2,1284.25,1301.8,1295.9,1296.2,1304.4,1323.1,1340.9,1341,1348,1351.4,1351.4,1343.5,1342.3,1349,1357.6,1357.1,1354.7,1361.4,1375.2,1403.5,1414.7,1433.2,1438,1423.6,1424.4,1418,1399.5,1435.5,1421.25,1434.1,1412.4,1409.8,1412.2,1433.4,1418.4,1429,1428.8,1420.6,1441,1460.4,1441.7,1438.4,1431,1439.3,1427.4,1431.9,1439.5,1443.7,1425.6,1457.5,1451.2,1481.1,1486.7,1512.1,1515.9,1509.2,1522.3,1513,1526.6,1533.9,1523,1506.3,1518.4,1512.4,1508.8,1545.4,1537.3,1551.8,1549.4,1536.9,1535.25,1537.95,1535.2,1556,1561.4,1525.6,1516.4,1507,1493.9,1504.9,1506.5,1513.1,1506.5,1509.7,1502,1506.8,1521.5,1529.8,1539.8,1510.9,1511.8,1501.7,1478,1485.4,1505.6,1511.6,1518.6,1498.7,1510.9,1510.8,1498.3,1492,1497.7,1484.8,1494.2,1495.6,1495.6,1487.5,1491.1,1495.1,1506.4]
# 		highs  = [1284.75,1320.6,1327,1330.8,1326.8,1321.6,1326,1328,1325.8,1327.1,1326,1326,1323.5,1322.1,1282.7,1282.95,1315.8,1316.3,1314,1333.2,1334.7,1341.7,1353.2,1354.6,1352.2,1346.4,1345.7,1344.9,1340.7,1344.2,1342.7,1342.1,1345.2,1342,1350,1324.95,1330.75,1369.6,1374.3,1368.4,1359.8,1359,1357,1356,1353.4,1340.6,1322.3,1314.1,1316.1,1312.9,1325.7,1323.5,1326.3,1336,1332.1,1330.1,1330.4,1334.7,1341.1,1344.2,1338.8,1348.4,1345.6,1342.8,1334.7,1322.3,1319.3,1314.7,1316.6,1316.4,1315,1325.4,1328.3,1332.2,1329.2,1316.9,1312.3,1309.5,1299.6,1296.9,1277.9,1299.5,1296.2,1298.4,1302.5,1308.7,1306.4,1305.9,1307,1297.2,1301.7,1305,1305.3,1310.2,1307,1308,1319.8,1321.7,1318.7,1316.2,1305.9,1295.8,1293.8,1293.7,1304.2,1302,1285.15,1286.85,1304,1302,1305.2,1323,1344.1,1345.2,1360.1,1355.3,1363.8,1353,1344.7,1353.6,1358,1373.6,1358.2,1369.6,1377.6,1408.9,1425.5,1435.9,1453.7,1438,1426,1439.1,1418,1435,1452.6,1426.65,1437.5,1421.5,1414.1,1433.3,1441.3,1431.4,1433.9,1432.4,1440.8,1462.3,1467,1443.5,1444,1442.9,1447,1437.6,1440.8,1445.7,1447.8,1458.2,1461.9,1481.8,1486.8,1522.7,1521.3,1521.1,1531.5,1546.1,1534.9,1537.7,1538.6,1523.6,1518.8,1518.4,1514.6,1540.3,1565,1554.5,1556.6,1559.8,1541.9,1542.9,1540.05,1558.9,1566.2,1561.9,1536.2,1523.8,1509.1,1506.2,1532.2,1516.6,1519.7,1515,1519.5,1512.1,1524.5,1534.4,1543.3,1543.3,1542.8,1519.5,1507.2,1493.5,1511.4,1525.8,1522.2,1518.8,1515.3,1518,1522.3,1508,1501.5,1503,1495.5,1501.1,1497.9,1498.7,1492.1,1499.4,1506.9,1520.9]
# 		lows   = [1282.85,1315,1318.7,1309.6,1317.6,1312.9,1312.4,1319.1,1319,1321,1318.1,1321.3,1319.9,1312,1280.5,1276.15,1308,1309.9,1308.5,1312.3,1329.3,1333.1,1340.2,1347,1345.9,1338,1340.8,1335,1332,1337.9,1333,1336.8,1333.2,1329.9,1340.4,1323.85,1324.05,1349,1366.3,1351.2,1349.1,1352.4,1350.7,1344.3,1338.9,1316.3,1308.4,1306.9,1309.6,1306.7,1312.3,1315.4,1319,1327.2,1317.2,1320,1323,1328,1323,1327.8,1331.7,1335.3,1336.6,1331.8,1311.4,1310,1309.5,1308,1310.6,1302.8,1306.6,1313.7,1320,1322.8,1311,1312.1,1303.6,1293.9,1293.5,1291,1277.9,1294.1,1286,1289.1,1293.5,1296.9,1298,1299.6,1292.9,1285.1,1288.5,1296.3,1297.2,1298.4,1298.6,1302,1300.3,1312,1310.8,1301.9,1292,1291.1,1286.3,1289.2,1289.9,1297.4,1283.65,1283.25,1292.9,1295.9,1290.8,1304.2,1322.7,1336.1,1341,1343.5,1345.8,1340.3,1335.1,1341.5,1347.6,1352.8,1348.2,1353.7,1356.5,1373.3,1398,1414.7,1427,1416.4,1412.7,1420.1,1396.4,1398.8,1426.6,1412.85,1400.7,1406,1399.8,1404.4,1415.5,1417.2,1421.9,1415,1413.7,1428.1,1434,1435.7,1427.5,1429.4,1423.9,1425.6,1427.5,1434.8,1422.3,1412.1,1442.5,1448.8,1468.2,1484.3,1501.6,1506.2,1498.6,1488.9,1504.5,1518.3,1513.9,1503.3,1503,1506.5,1502.1,1503,1534.8,1535.3,1541.4,1528.6,1525.6,1535.25,1528.15,1528,1542.6,1514.3,1510.7,1505.5,1492.1,1492.9,1496.8,1493.1,1503.4,1500.9,1490.7,1496.3,1505.3,1505.3,1517.9,1507.4,1507.1,1493.3,1470.5,1465,1480.5,1501.7,1501.4,1493.3,1492.1,1505.1,1495.7,1478,1487.1,1480.8,1480.6,1487,1488.3,1484.8,1484,1490.7,1490.4,1503.1]
# 		closes = [1283.35,1315.3,1326.1,1317.4,1321.5,1317.4,1323.5,1319.2,1321.3,1323.3,1319.7,1325.1,1323.6,1313.8,1282.05,1279.05,1314.2,1315.2,1310.8,1329.1,1334.5,1340.2,1340.5,1350,1347.1,1344.3,1344.6,1339.7,1339.4,1343.7,1337,1338.9,1340.1,1338.7,1346.8,1324.25,1329.55,1369.6,1372.5,1352.4,1357.6,1354.2,1353.4,1346,1341,1323.8,1311.9,1309.1,1312.2,1310.7,1324.3,1315.7,1322.4,1333.8,1319.4,1327.1,1325.8,1330.9,1325.8,1331.6,1336.5,1346.7,1339.2,1334.7,1313.3,1316.5,1312.4,1313.4,1313.3,1312.2,1313.7,1319.9,1326.3,1331.9,1311.3,1313.4,1309.4,1295.2,1294.7,1294.1,1277.9,1295.8,1291.2,1297.4,1297.7,1306.8,1299.4,1303.6,1302.2,1289.9,1299.2,1301.8,1303.6,1299.5,1303.2,1305.3,1319.5,1313.6,1315.1,1303.5,1293,1294.6,1290.4,1291.4,1302.7,1301,1284.15,1284.95,1294.3,1297.9,1304.1,1322.6,1339.3,1340.1,1344.9,1354,1357.4,1340.7,1342.7,1348.2,1355.1,1355.9,1354.2,1362.1,1360.1,1408.3,1411.2,1429.5,1430.1,1426.8,1423.4,1425.1,1400.8,1419.8,1432.9,1423.55,1412.1,1412.2,1412.8,1424.9,1419.3,1424.8,1426.1,1423.6,1435.9,1440.8,1439.4,1439.7,1434.5,1436.5,1427.5,1432.2,1433.3,1441.8,1437.8,1432.4,1457.5,1476.5,1484.2,1519.6,1509.5,1508.5,1517.2,1514.1,1527.8,1531.2,1523.6,1511.6,1515.7,1515.7,1508.5,1537.6,1537.2,1551.8,1549.1,1536.9,1529.4,1538.05,1535.15,1555.9,1560.4,1525.5,1515.5,1511.1,1499.2,1503.2,1507.4,1499.5,1511.5,1513.4,1515.8,1506.2,1515.1,1531.5,1540.2,1512.3,1515.2,1506.4,1472.9,1489,1507.9,1513.8,1512.9,1504.4,1503.9,1512.8,1500.9,1488.7,1497.6,1483.5,1494,1498.3,1494.1,1488.1,1487.5,1495.7,1504.7,1505.3]
#         @cstatic tooltip = true
#         CImGui.Checkbox("Show Tooltip", &tooltip)
#         CImGui.SameLine()
#         @cstatic bullCol = ImVec4(0.000, 1.000, 0.441, 1.000)
#         @cstatic bearCol = ImVec4(0.853, 0.050, 0.310, 1.000)
#         CImGui.SameLine() CImGui.ColorEdit4("##Bull", &bullCol.x, ImGuiColorEditFlags_NoInputs)
#         CImGui.SameLine() CImGui.ColorEdit4("##Bear", &bearCol.x, ImGuiColorEditFlags_NoInputs)
#         ImPlot.GetStyle().UseLocalTime = false
#         ImPlot.SetNextPlotLimits(1546300800, 1571961600, 1250, 1600)
#         if (ImPlot.BeginPlot("Candlestick Chart","Day","USD",ImVec2(-1,0),0,ImPlotAxisFlags_Time)) 
#             MyImPlot.PlotCandlestick("GOOGL",dates, opens, closes, lows, highs, 218, tooltip, 0.25, bullCol, bearCol)
#             ImPlot.EndPlot()
#         end
#     end
    #-------------------------------------------------------------------------
    CImGui.End()

end

# main functinon
function show() 

    Renderer.render(
        ()->ShowDemoWindow(), 
        width = 1360, 
        height = 780, 
        title = "Demo plots", 
        hotloading = true
    )
end

