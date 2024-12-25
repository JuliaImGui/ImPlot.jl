using CImGuiPack_jll

import CImGui:
    ImVec2, ImVec4,
    ImGuiMouseButton, ImGuiKey, ImGuiCond, ImGuiDragDropFlags,
    ImS8, ImU8, ImS16, ImU16, ImS32, ImU32, ImS64, ImU64,
    ImTextureID,
    ImDrawList,
    ImGuiContext,
    ImGuiStyleVar,
    ImGuiStyleMod,
    ImGuiCol,
    ImGuiColorMod,
    ImGuiID,
    ImGuiStoragePair,
    ImGuiTextBuffer,
    ImGuiStorage,
    ImVector_float,
    ImVector_ImU32,
    ImVector_ImGuiStyleMod,
    ImVector_ImGuiColorMod,
    ImRect,
    ImPoolIdx

#Temporary patch; CImGui.jl v1.79.0 aliases ImS8 incorrectly; add to imports in new versions
#const ImS8 = Int8
const IMPLOT_AUTO = Cint(-1)
const IMPLOT_AUTO_COL = ImVec4(0,0,0,-1)
export IMPLOT_AUTO, IMPLOT_AUTO_COL
