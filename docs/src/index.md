# ImPlot.jl
This is a plotting extension library that can be used in conjunction with
[CImGui.jl](https://juliaimgui.github.io/ImGuiDocs.jl/cimgui) to provide
enhanced immediate-mode data visualization.

ImPlot.jl provides an interface to [cimplot](https://github.com/cimgui/cimplot),
which is an auto-generated C API to [implot](https://github.com/epezent/implot), a C++
plotting extension library for [imgui](https://github.com/ocornut/imgui).

## Installation

Simple installation via the package registry:
```julia
] add ImPlot
```

## Example Usage
Use `demo/implot_demo.jl` to check if things are working via:

```julia
include("implot_demo.jl")
show_demo()
```

`implot_demo.jl` replicates all the plotting functionality visible in
`implot_demo.cpp` of implot v0.8, with the exception of examples using Tables
(depends on upstream imgui) and custom plotting with `implot_internal.h`
functions (depends on cimplot v0.9).

Aside from the replication of the C++ interface, we have some convenience for
some things that are slightly less verbose. See `demo/example_plots.jl` and
below.

```julia
import CImGui as ig, ModernGL, GLFW
import ImPlot

ig.set_backend(:GlfwOpenGL3)

ctx = ig.CreateContext()
p_ctx =ImPlot.CreateContext()

ig.render(ctx; on_exit=() -> ImPlot.DestroyContext(p_ctx)) do
    ig.Begin("Plot Window")
    y = rand(1000)
    ImPlot.SetNextAxesLimits(0.0,1000,0.0,1.0, ig.ImGuiCond_Once)
    if ImPlot.BeginPlot("Foo", "x1", "y1", ig.ImVec2(-1, 300))
        ImPlot.PlotLine("data", y)
        ImPlot.EndPlot()
    end
    ig.End()
end
```
