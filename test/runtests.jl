using Test

using ImGuiTestEngine
import ImGuiTestEngine as te
import CImGui as ig
using ImPlot

import GLFW
import ModernGL
ig.set_backend(:GlfwOpenGL3)


include(joinpath(@__DIR__, "..", "demo", "demo.jl"))

@testset "Official demo" begin
    engine = te.CreateContext(; exit_on_completion=true)

    @register_test(engine, "Official demo", "Hiding demo window") do ctx
        @imcheck GetWindowByRef("ImPlot Demo") != nothing
        SetRef("Hello, world!")
        ItemClick("Show ImPlot Demo") # This will hide the demo window
        @imcheck GetWindowByRef("ImPlot Demo") == nothing
    end

    official_demo(; engine)

    te.DestroyContext(engine)
end

include(joinpath(@__DIR__, "..", "demo", "example_plots.jl"))

@testset "Simple demo" begin
    engine = te.CreateContext(; exit_on_completion=true)

    @register_test(engine, "Simple demo", "All plots") do ctx
        @imcheck GetWindowByRef("Examples Window") != nothing

        SetRef("Examples Window")
        ItemOpen("Line plots")
        ItemOpen("Scatter plot")
        ItemOpen("Bar plot")
        ItemOpen("Shaded plot")
    end

    simple_demo(; engine)
    te.DestroyContext(engine)
end

include(joinpath(@__DIR__, "..", "demo", "implot_demo.jl"))

@testset "Full demo" begin
    engine = te.CreateContext(; exit_on_completion=true)

    @register_test(engine, "Full demo", "Tools menu") do ctx
        @imcheck GetWindowByRef("ImPlot Demo") != nothing

        # Metrics window
        SetRef("ImPlot Demo")
        MenuClick("Tools/Metrics (ImPlot)")
        Yield()
        @imcheck GetWindowByRef("//ImPlot Metrics") != nothing

        # Style window
        MenuClick("Tools/Style Editor (ImPlot)")
        Yield()
        @imcheck GetWindowByRef("//Style Editor (ImPlot)") != nothing
    end

    @register_test(engine, "Full demo", "All plots") do ctx
        SetRef("ImPlot Demo")

        OpenAndClose("Help")
        OpenAndClose("Configuration")
        OpenAndClose("Line Plots")

        OpenAndClose("Filled Line Plots") do
            ItemClick("Lines")
            ItemClick("Fills")
        end

        OpenAndClose("Shaded Plots##")
        OpenAndClose("Scatter Plots")
        OpenAndClose("Stairstep Plots")

        OpenAndClose("Bar Plots") do
            ItemClick("Horizontal")
        end

        OpenAndClose("Error Bars")
        OpenAndClose("Stem Plots##")

        OpenAndClose("Pie Charts") do
            ItemClick("Normalize")
        end

        OpenAndClose("Heatmaps")
        OpenAndClose("Images")
        OpenAndClose("Realtime Plots")
        OpenAndClose("Markers and Text")
        OpenAndClose("Log Scale")

        OpenAndClose("Time Formatted Axes") do
            ItemClick("Generate Huge Data (~500MB!)")
        end

        OpenAndClose("Multiple Y-Axes") do
            ItemDoubleClick("Y-Axis 2")
            ItemDoubleClick("Y-Axis 3")
            ItemClick("Fit X")
            ItemClick("Fit Y")
            ItemClick("Fit Y2")
            ItemClick("Fit Y3")
        end

        OpenAndClose("Linked Axes") do
            ItemClick("Link X")
            ItemClick("Link Y")
        end

        OpenAndClose("Equal Axes")
        OpenAndClose("Querying")
        OpenAndClose("Views")

        OpenAndClose("Legend") do
            ItemClick("North")
            ItemClick("South")
            ItemClick("West")
            ItemClick("East")
            ItemClick("Horizontal")
            ItemClick("Outside")
        end

        OpenAndClose("Drag Lines and Points")

        OpenAndClose("Annotations") do
            ItemClick("Clamp")
        end

        OpenAndClose("Tables") do
            ItemClick("Animate")
        end

        OpenAndClose("Offset and Stride")
        OpenAndClose("Custom Data and Getters")

        OpenAndClose("Custom Ticks##") do
            ItemCheck("Show Custom Ticks")
            ItemClick("Show Custom Labels")
        end

        OpenAndClose("Custom Styles")
        OpenAndClose("Custom Context Menus")
    end

    full_demo(; engine)
    te.DestroyContext(engine)
end
