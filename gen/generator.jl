using Clang.Generators
using ExprTools, MacroTools, JSON
using MacroTools: postwalk
using JuliaFormatter: format_file
import CImGuiPack_jll

const CIMGUI_INCLUDE_DIR = joinpath(CImGuiPack_jll.artifact_dir, "include")
const CIMPLOT_H = normpath(CIMGUI_INCLUDE_DIR, "cimplot.h")

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
pushfirst!(args, "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS")
pushfirst!(args, "-isystem$CIMGUI_INCLUDE_DIR")

# add definitions
@add_def ImVec2
@add_def ImVec2_c
@add_def ImVec4
@add_def ImVec4_c
@add_def ImGuiMouseButton
@add_def ImGuiKeyModFlags
@add_def ImS8 
@add_def ImU8
@add_def ImS16
@add_def ImU16
@add_def ImS32
@add_def ImU32
@add_def ImS64
@add_def ImU64
@add_def ImTextureID
@add_def ImTextureRef_c
@add_def ImTextureData
@add_def ImTextureStatus
@add_def ImTextureFormat
@add_def ImTextureRect
@add_def ImGuiCond
@add_def ImGuiDragDropFlags
@add_def ImDrawList
@add_def ImGuiContext

@add_def ImGuiStyleVar
@add_def ImGuiStyleMod
@add_def ImGuiCol
@add_def ImGuiColorMod
@add_def ImGuiID
@add_def ImGuiStoragePair
@add_def ImGuiTextBuffer
@add_def ImGuiStorage

@add_def ImVector_float
@add_def ImVector_ImU32
@add_def ImVector_ImGuiStyleMod
@add_def ImRect
@add_def ImRect_c
@add_def ImPoolIdx
@add_def ImVector_ImGuiColorMod
@add_def ImVector_ImTextureRect

include(joinpath(@__DIR__, "helpers.jl"))

# GLOBALS
const DESPECIALIZE = ["LinkNextPlotLimits"]
const IMDATATYPES = [:Cfloat, :Cdouble, :ImS8, :ImU8, :ImS16, :ImU16, :ImS32, :ImU32, :ImS64, :ImU64]
const JLDATATYPES = [:Float32, :Float64, :Int8, :UInt8, :Int16, :UInt16, :Int32, :UInt32, :Int64, :UInt64] 
const IMTOJL_LOOKUP = Dict(zip(IMDATATYPES, JLDATATYPES))
const IMGUI_ISBITS_TYPES = [:ImPlotPoint, :ImPlotRange, :ImVec2, :ImVec4, :ImPlotRect, :ImPlotSpec,
                            :ImPlotPoint_c, :ImPlotRange_c, :ImVec2_c, :ImVec4_c, :ImPlotRect_c, :ImPlotSpec_c]

# Read in JSON metadata
FUNCTION_METADATA, STRUCTS_AND_ENUMS, ENUMS, ENUM_CONSTANTS = read_metadata();

# We generate the exports ourselves in generate_exports() so that internal types
# aren't exported, that's why export_symbol_prefixes is empty in generator.toml.
const EXPORT_PREFIXES = ["ImPlot", "IMPLOT"]

function get_docstring(node, doc, docstrings)
    id = string(node.id)
    if haskey(docstrings, id)
        push!(doc, docstrings[id])
    end

    return doc
end

function generate()
    docstrings = Dict{String, String}()
    public_names = Set{Symbol}()
    options["general"]["callback_documentation"] = (node, doc) -> get_docstring(node, doc, docstrings)

    cd(@__DIR__) do
        output_file = joinpath(@__DIR__, "..", "src", "libcimplot.jl")

        ctx = create_context(CIMPLOT_H, args, options)
        build!(ctx, BUILDSTAGE_NO_PRINTING)
        rewrite!(ctx.dag, FUNCTION_METADATA, options, docstrings, public_names)
        build!(ctx, BUILDSTAGE_PRINTING_ONLY)

        # The functions in the epilogue are all public
        union!(public_names, function_names(options["general"]["epilogue_file_path"]))
        open(output_file, "a") do io
            write(io, generate_exports(public_names, EXPORT_PREFIXES))
        end

        format_file(output_file; margin=120)

        generate_plot_wrappers(FUNCTION_METADATA, joinpath(@__DIR__, "..", "src", "plotting.jl"))
    end
end
