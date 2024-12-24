import CImGui as ig
import GLFW, ModernGL
import CSyntax: @c, @cstatic
using Printf
using ImPlot

ig.set_backend(:GlfwOpenGL3)


function official_demo(; engine=nothing)
    # setup Dear ImGui context
    ctx = ig.CreateContext()
    pctx = ImPlot.CreateContext()
    ImPlot.SetImGuiContext(ctx)

    show_demo_window = true

    ig.render(ctx; engine, on_exit=() -> ImPlot.DestroyContext(pctx)) do
        # show the big demo window
        show_demo_window && @c ImPlot.ShowDemoWindow(&show_demo_window)
        
        # show a simple window that we create ourselves.
        # we use a Begin/End pair to created a named window.
        @cstatic f=Cfloat(0.0) counter=Cint(0) begin
            if ig.Begin("Hello, world!")
                framerate = unsafe_load(ig.GetIO().Framerate)

                @c ig.Checkbox("Show ImPlot Demo", &show_demo_window)
                ig.Text(@sprintf("Application average %.3f ms/frame (%.1f FPS)",
                                 1000 / framerate, framerate))

                ig.End()
            end
        end
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    official_demo()
end
