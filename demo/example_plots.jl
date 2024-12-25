import CImGui as ig
import GLFW, ModernGL
import CSyntax: @c, @cstatic
using Printf
using ImPlot

ig.set_backend(:GlfwOpenGL3)

function simple_demo(; engine)
    ctx = ig.CreateContext()
    ctxp = ImPlot.CreateContext()
    ImPlot.SetImGuiContext(ctx)

    show_another_window = true
    # make up some data
    xs1 = Float64.(collect(1:100))
    ys1 = rand(6000)
    noise = rand(length(xs1))
    bar_vals = Vector{Vector{Float64}}(undef, 5)
    bar_maxes = zeros(5)
    bar_mins = zeros(5)
    for i in 1:length(bar_vals)
        bar_vals[i] = Float64.(collect(range(rand(1:10), step=rand([-2,-1,1,2]), length=120)))
        bar_maxes[i] = maximum(bar_vals[i])
        bar_mins[i] = minimum(bar_vals[i])
    end
    bar_max = maximum(bar_maxes)
    bar_min = minimum(bar_mins)
    bar_counter = 1

    ig.render(ctx; window_title="ImPlot Demo", engine, on_exit=() -> ImPlot.DestroyContext(ctxp)) do
        ig.Begin("Example Plots")

        @c ig.Checkbox("Show Examples", &show_another_window)
        framerate = unsafe_load(ig.GetIO().Framerate)
        ig.Text(@sprintf("Application average %.3f ms/frame (%.1f FPS)",
                         1000 / framerate, framerate))

        ig.End()

        if show_another_window
            @c ig.Begin("Examples Window", &show_another_window)

            if ig.CollapsingHeader("Line plots")
                ys1 .= rand(6000)
                ImPlot.SetNextAxesLimits(0.0, 6000, 0.0, 1.0, ig.ImGuiCond_Always)
                # Using '##' in the label name hides the plot label, but lets
                # us keep the label ID unique for modifying styling etc.
                if ImPlot.BeginPlot("##line", "x1", "y1", ig.ImVec2(-1,300))
                    ImPlot.PlotLine("data", ys1)
                    ImPlot.EndPlot()
                end
            end

            if ig.CollapsingHeader("Scatter plot")
                noise .= xs1 .+ rand(-5.0:0.1:5.0, length(xs1))
                ImPlot.SetNextAxesLimits(0,100,-5,105, ig.ImGuiCond_Always)
                if ImPlot.BeginPlot("##scatter", "x2", "y2", ig.ImVec2(-1,300))
                    ImPlot.PlotScatter("data", xs1, noise)
                    ImPlot.EndPlot()
                end
            end

            if ig.CollapsingHeader("Bar plot")
                bar_val_step = [bar_vals[j][bar_counter] for j in 1:length(bar_vals)]

                ImPlot.SetNextAxesLimits(-0.5,4.5,bar_min, bar_max, ig.ImGuiCond_Always)
                if ImPlot.BeginPlot("##bars", "", "", ig.ImVec2(-1,300))
                    ImPlot.PlotBars("data", bar_val_step)
                    ImPlot.EndPlot()
                end

                if bar_counter == 120
                    bar_counter = 1
                else
                    bar_counter += 1
                end
            end

            if ig.CollapsingHeader("Shaded plot")
                x = 1:1000
                y1 = [sin(x) for x in range(0,2π, length = length(x))]
                y_ref = -2.0
                # ImPlot.SetNextAxesLimits(0,1000,-2,1, ig.ImGuiCond_Always)
                if ImPlot.BeginPlot("##shaded", "", "", ig.ImVec2(-1,300))
                    ImPlot.PlotShaded("data", x, y1, y_ref)
                    ImPlot.EndPlot()
                end
            end
            ig.End()
        end
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    simple_demo()
end
