import ImPlot
import Revise
using Documenter
import Changelog

# Revise to catch any docstring changes
Revise.revise()

# Note that the changelog file is named `_changelog.md` so we can use
# `changelog.md` as the generated name, which makes for a prettier URL.
Changelog.generate(
    Changelog.Documenter(),
    joinpath(@__DIR__, "src/_changelog.md"),
    joinpath(@__DIR__, "src/changelog.md"),
    repo="JuliaImGui/ImPlot.jl"
)

makedocs(;
    modules=[ImPlot],
    authors="Wiktor Phillips <wsphillips@gmail.com>",
    sitename="ImPlot.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://juliaimgui.github.io/ImPlot.jl",
        assets=String[],
        size_threshold=2_000_000,
        size_threshold_warn=2_000_000
    ),
    pages=["index.md", "api.md", "changelog.md"]
)

deploydocs(;
    repo="github.com/JuliaImGui/ImPlot.jl.git",
)
