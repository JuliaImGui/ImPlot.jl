using CEnum

using CImPlot_jll

import CImGui: 
    ImVec2, ImVec4,
    ImGuiMouseButton, ImGuiKeyModFlags, ImGuiCond, ImGuiDragDropFlags,
    ImU8, ImS16, ImU16, ImS32, ImU32, ImS64, ImU64,
    ImTextureID,
    ImDrawList,
    ImGuiContext
            
#Temporary patch; CImGui.jl v1.79.0 aliases ImS8 incorrectly; add to imports in new versions
const ImS8 = Int8
const IMPLOT_AUTO = Cint(-1)
const IMPLOT_AUTO_COL = ImVec4(0,0,0,-1)
export IMPLOT_AUTO, IMPLOT_AUTO_COL


struct ImPlotInputMap
    PanButton::ImGuiMouseButton
    PanMod::ImGuiKeyModFlags
    FitButton::ImGuiMouseButton
    ContextMenuButton::ImGuiMouseButton
    BoxSelectButton::ImGuiMouseButton
    BoxSelectMod::ImGuiKeyModFlags
    BoxSelectCancelButton::ImGuiMouseButton
    QueryButton::ImGuiMouseButton
    QueryMod::ImGuiKeyModFlags
    QueryToggleMod::ImGuiKeyModFlags
    HorizontalMod::ImGuiKeyModFlags
    VerticalMod::ImGuiKeyModFlags
end

function Base.getproperty(x::Ptr{ImPlotInputMap}, f::Symbol)
    f === :PanButton && return Ptr{ImGuiMouseButton}(x + 0)
    f === :PanMod && return Ptr{ImGuiKeyModFlags}(x + 4)
    f === :FitButton && return Ptr{ImGuiMouseButton}(x + 8)
    f === :ContextMenuButton && return Ptr{ImGuiMouseButton}(x + 12)
    f === :BoxSelectButton && return Ptr{ImGuiMouseButton}(x + 16)
    f === :BoxSelectMod && return Ptr{ImGuiKeyModFlags}(x + 20)
    f === :BoxSelectCancelButton && return Ptr{ImGuiMouseButton}(x + 24)
    f === :QueryButton && return Ptr{ImGuiMouseButton}(x + 28)
    f === :QueryMod && return Ptr{ImGuiKeyModFlags}(x + 32)
    f === :QueryToggleMod && return Ptr{ImGuiKeyModFlags}(x + 36)
    f === :HorizontalMod && return Ptr{ImGuiKeyModFlags}(x + 40)
    f === :VerticalMod && return Ptr{ImGuiKeyModFlags}(x + 44)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImPlotInputMap}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImPlotStyle
    LineWeight::Cfloat
    Marker::Cint
    MarkerSize::Cfloat
    MarkerWeight::Cfloat
    FillAlpha::Cfloat
    ErrorBarSize::Cfloat
    ErrorBarWeight::Cfloat
    DigitalBitHeight::Cfloat
    DigitalBitGap::Cfloat
    PlotBorderSize::Cfloat
    MinorAlpha::Cfloat
    MajorTickLen::ImVec2
    MinorTickLen::ImVec2
    MajorTickSize::ImVec2
    MinorTickSize::ImVec2
    MajorGridSize::ImVec2
    MinorGridSize::ImVec2
    PlotPadding::ImVec2
    LabelPadding::ImVec2
    LegendPadding::ImVec2
    LegendInnerPadding::ImVec2
    LegendSpacing::ImVec2
    MousePosPadding::ImVec2
    AnnotationPadding::ImVec2
    FitPadding::ImVec2
    PlotDefaultSize::ImVec2
    PlotMinSize::ImVec2
    Colors::NTuple{24, ImVec4}
    AntiAliasedLines::Bool
    UseLocalTime::Bool
    UseISO8601::Bool
    Use24HourClock::Bool
end

function Base.getproperty(x::Ptr{ImPlotStyle}, f::Symbol)
    f === :LineWeight && return Ptr{Cfloat}(x + 0)
    f === :Marker && return Ptr{Cint}(x + 4)
    f === :MarkerSize && return Ptr{Cfloat}(x + 8)
    f === :MarkerWeight && return Ptr{Cfloat}(x + 12)
    f === :FillAlpha && return Ptr{Cfloat}(x + 16)
    f === :ErrorBarSize && return Ptr{Cfloat}(x + 20)
    f === :ErrorBarWeight && return Ptr{Cfloat}(x + 24)
    f === :DigitalBitHeight && return Ptr{Cfloat}(x + 28)
    f === :DigitalBitGap && return Ptr{Cfloat}(x + 32)
    f === :PlotBorderSize && return Ptr{Cfloat}(x + 36)
    f === :MinorAlpha && return Ptr{Cfloat}(x + 40)
    f === :MajorTickLen && return Ptr{ImVec2}(x + 44)
    f === :MinorTickLen && return Ptr{ImVec2}(x + 52)
    f === :MajorTickSize && return Ptr{ImVec2}(x + 60)
    f === :MinorTickSize && return Ptr{ImVec2}(x + 68)
    f === :MajorGridSize && return Ptr{ImVec2}(x + 76)
    f === :MinorGridSize && return Ptr{ImVec2}(x + 84)
    f === :PlotPadding && return Ptr{ImVec2}(x + 92)
    f === :LabelPadding && return Ptr{ImVec2}(x + 100)
    f === :LegendPadding && return Ptr{ImVec2}(x + 108)
    f === :LegendInnerPadding && return Ptr{ImVec2}(x + 116)
    f === :LegendSpacing && return Ptr{ImVec2}(x + 124)
    f === :MousePosPadding && return Ptr{ImVec2}(x + 132)
    f === :AnnotationPadding && return Ptr{ImVec2}(x + 140)
    f === :FitPadding && return Ptr{ImVec2}(x + 148)
    f === :PlotDefaultSize && return Ptr{ImVec2}(x + 156)
    f === :PlotMinSize && return Ptr{ImVec2}(x + 164)
    f === :Colors && return Ptr{NTuple{24, ImVec4}}(x + 172)
    f === :AntiAliasedLines && return Ptr{Bool}(x + 556)
    f === :UseLocalTime && return Ptr{Bool}(x + 557)
    f === :UseISO8601 && return Ptr{Bool}(x + 558)
    f === :Use24HourClock && return Ptr{Bool}(x + 559)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImPlotStyle}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImPlotRange
    Min::Cdouble
    Max::Cdouble
end

struct ImPlotLimits
    X::ImPlotRange
    Y::ImPlotRange
end

struct ImPlotPoint
    x::Cdouble
    y::Cdouble
end

mutable struct ImPlotContext end

const ImPlotFlags = Cint

const ImPlotAxisFlags = Cint

const ImPlotCol = Cint

const ImPlotStyleVar = Cint

const ImPlotMarker = Cint

const ImPlotColormap = Cint

const ImPlotLocation = Cint

const ImPlotOrientation = Cint

const ImPlotYAxis = Cint

@cenum ImPlotFlags_::UInt32 begin
    ImPlotFlags_None = 0
    ImPlotFlags_NoTitle = 1
    ImPlotFlags_NoLegend = 2
    ImPlotFlags_NoMenus = 4
    ImPlotFlags_NoBoxSelect = 8
    ImPlotFlags_NoMousePos = 16
    ImPlotFlags_NoHighlight = 32
    ImPlotFlags_NoChild = 64
    ImPlotFlags_Equal = 128
    ImPlotFlags_YAxis2 = 256
    ImPlotFlags_YAxis3 = 512
    ImPlotFlags_Query = 1024
    ImPlotFlags_Crosshairs = 2048
    ImPlotFlags_AntiAliased = 4096
    ImPlotFlags_CanvasOnly = 31
end

@cenum ImPlotAxisFlags_::UInt32 begin
    ImPlotAxisFlags_None = 0
    ImPlotAxisFlags_NoGridLines = 1
    ImPlotAxisFlags_NoTickMarks = 2
    ImPlotAxisFlags_NoTickLabels = 4
    ImPlotAxisFlags_LogScale = 8
    ImPlotAxisFlags_Time = 16
    ImPlotAxisFlags_Invert = 32
    ImPlotAxisFlags_LockMin = 64
    ImPlotAxisFlags_LockMax = 128
    ImPlotAxisFlags_Lock = 192
    ImPlotAxisFlags_NoDecorations = 7
end

@cenum ImPlotCol_::UInt32 begin
    ImPlotCol_Line = 0
    ImPlotCol_Fill = 1
    ImPlotCol_MarkerOutline = 2
    ImPlotCol_MarkerFill = 3
    ImPlotCol_ErrorBar = 4
    ImPlotCol_FrameBg = 5
    ImPlotCol_PlotBg = 6
    ImPlotCol_PlotBorder = 7
    ImPlotCol_LegendBg = 8
    ImPlotCol_LegendBorder = 9
    ImPlotCol_LegendText = 10
    ImPlotCol_TitleText = 11
    ImPlotCol_InlayText = 12
    ImPlotCol_XAxis = 13
    ImPlotCol_XAxisGrid = 14
    ImPlotCol_YAxis = 15
    ImPlotCol_YAxisGrid = 16
    ImPlotCol_YAxis2 = 17
    ImPlotCol_YAxisGrid2 = 18
    ImPlotCol_YAxis3 = 19
    ImPlotCol_YAxisGrid3 = 20
    ImPlotCol_Selection = 21
    ImPlotCol_Query = 22
    ImPlotCol_Crosshairs = 23
    ImPlotCol_COUNT = 24
end

@cenum ImPlotStyleVar_::UInt32 begin
    ImPlotStyleVar_LineWeight = 0
    ImPlotStyleVar_Marker = 1
    ImPlotStyleVar_MarkerSize = 2
    ImPlotStyleVar_MarkerWeight = 3
    ImPlotStyleVar_FillAlpha = 4
    ImPlotStyleVar_ErrorBarSize = 5
    ImPlotStyleVar_ErrorBarWeight = 6
    ImPlotStyleVar_DigitalBitHeight = 7
    ImPlotStyleVar_DigitalBitGap = 8
    ImPlotStyleVar_PlotBorderSize = 9
    ImPlotStyleVar_MinorAlpha = 10
    ImPlotStyleVar_MajorTickLen = 11
    ImPlotStyleVar_MinorTickLen = 12
    ImPlotStyleVar_MajorTickSize = 13
    ImPlotStyleVar_MinorTickSize = 14
    ImPlotStyleVar_MajorGridSize = 15
    ImPlotStyleVar_MinorGridSize = 16
    ImPlotStyleVar_PlotPadding = 17
    ImPlotStyleVar_LabelPadding = 18
    ImPlotStyleVar_LegendPadding = 19
    ImPlotStyleVar_LegendInnerPadding = 20
    ImPlotStyleVar_LegendSpacing = 21
    ImPlotStyleVar_MousePosPadding = 22
    ImPlotStyleVar_AnnotationPadding = 23
    ImPlotStyleVar_FitPadding = 24
    ImPlotStyleVar_PlotDefaultSize = 25
    ImPlotStyleVar_PlotMinSize = 26
    ImPlotStyleVar_COUNT = 27
end

@cenum ImPlotMarker_::Int32 begin
    ImPlotMarker_None = -1
    ImPlotMarker_Circle = 0
    ImPlotMarker_Square = 1
    ImPlotMarker_Diamond = 2
    ImPlotMarker_Up = 3
    ImPlotMarker_Down = 4
    ImPlotMarker_Left = 5
    ImPlotMarker_Right = 6
    ImPlotMarker_Cross = 7
    ImPlotMarker_Plus = 8
    ImPlotMarker_Asterisk = 9
    ImPlotMarker_COUNT = 10
end

@cenum ImPlotColormap_::UInt32 begin
    ImPlotColormap_Default = 0
    ImPlotColormap_Deep = 1
    ImPlotColormap_Dark = 2
    ImPlotColormap_Pastel = 3
    ImPlotColormap_Paired = 4
    ImPlotColormap_Viridis = 5
    ImPlotColormap_Plasma = 6
    ImPlotColormap_Hot = 7
    ImPlotColormap_Cool = 8
    ImPlotColormap_Pink = 9
    ImPlotColormap_Jet = 10
    ImPlotColormap_COUNT = 11
end

@cenum ImPlotLocation_::UInt32 begin
    ImPlotLocation_Center = 0
    ImPlotLocation_North = 1
    ImPlotLocation_South = 2
    ImPlotLocation_West = 4
    ImPlotLocation_East = 8
    ImPlotLocation_NorthWest = 5
    ImPlotLocation_NorthEast = 9
    ImPlotLocation_SouthWest = 6
    ImPlotLocation_SouthEast = 10
end

@cenum ImPlotOrientation_::UInt32 begin
    ImPlotOrientation_Horizontal = 0
    ImPlotOrientation_Vertical = 1
end

@cenum ImPlotYAxis_::UInt32 begin
    ImPlotYAxis_1 = 0
    ImPlotYAxis_2 = 1
    ImPlotYAxis_3 = 2
end

function Contains(self::Union{ImPlotRange, Ptr{ImPlotRange}}, value::Real)
    ccall((:ImPlotRange_Contains, libcimplot), Bool, (Ptr{ImPlotRange}, Cdouble), self, value)
end

function Size(self::Union{ImPlotRange, Ptr{ImPlotRange}})
    ccall((:ImPlotRange_Size, libcimplot), Cdouble, (Ptr{ImPlotRange},), self)
end

function Contains(self::Union{ImPlotLimits, Ptr{ImPlotLimits}}, p::ImPlotPoint)
    ccall((:ImPlotLimits_ContainsPlotPoInt, libcimplot), Bool, (Ptr{ImPlotLimits}, ImPlotPoint), self, p)
end

function Contains(self::Union{ImPlotLimits, Ptr{ImPlotLimits}}, x::Real, y::Real)
    ccall((:ImPlotLimits_Containsdouble, libcimplot), Bool, (Ptr{ImPlotLimits}, Cdouble, Cdouble), self, x, y)
end

function ImPlotStyle()
    ccall((:ImPlotStyle_ImPlotStyle, libcimplot), Ptr{ImPlotStyle}, ())
end

function Base.finalizer(self::Union{Ptr{ImPlotStyle}, ImPlotStyle})
    ptr = pointer_from_objref(self)
    GC.@preserve self ccall((:ImPlotStyle_destroy, libcimplot), Cvoid, (Ptr{ImPlotStyle},), self)
end

function ImPlotInputMap()
    ccall((:ImPlotInputMap_ImPlotInputMap, libcimplot), Ptr{ImPlotInputMap}, ())
end

function Base.finalizer(self::Union{Ptr{ImPlotInputMap}, ImPlotInputMap})
    ptr = pointer_from_objref(self)
    GC.@preserve self ccall((:ImPlotInputMap_destroy, libcimplot), Cvoid, (Ptr{ImPlotInputMap},), self)
end

function CreateContext()
    ccall((:ImPlot_CreateContext, libcimplot), Ptr{ImPlotContext}, ())
end

function DestroyContext(ctx)
    ccall((:ImPlot_DestroyContext, libcimplot), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function GetCurrentContext()
    ccall((:ImPlot_GetCurrentContext, libcimplot), Ptr{ImPlotContext}, ())
end

function SetCurrentContext(ctx)
    ccall((:ImPlot_SetCurrentContext, libcimplot), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function BeginPlot(title_id, x_label = C_NULL, y_label = C_NULL, size::ImVec2 = ImVec2(-1, 0), flags = ImPlotFlags_None, x_flags = ImPlotAxisFlags_None, y_flags = ImPlotAxisFlags_None, y2_flags = ImPlotAxisFlags_NoGridLines, y3_flags = ImPlotAxisFlags_NoGridLines)
    ccall((:ImPlot_BeginPlot, libcimplot), Bool, (Cstring, Cstring, Cstring, ImVec2, ImPlotFlags, ImPlotAxisFlags, ImPlotAxisFlags, ImPlotAxisFlags, ImPlotAxisFlags), title_id, x_label, y_label, size, flags, x_flags, y_flags, y2_flags, y3_flags)
end

function EndPlot()
    ccall((:ImPlot_EndPlot, libcimplot), Cvoid, ())
end

function PlotLine(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotLineFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotLinedoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotLineS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotLineU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotLineS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotLineU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotLineS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotLineU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotLineS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotLineU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotLineFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotLinedoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotLineS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotLineU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotLineS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotLineU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotLineS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotLineU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotLineS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotLine(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotLineU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotScatterFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotScatterdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotScatterS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotScatterU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotScatterS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotScatterU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotScatterS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotScatterU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotScatterS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotScatterU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotScatterFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotScatterdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotScatterS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotScatterU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotScatterS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotScatterU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotScatterS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotScatterU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotScatterS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotScatter(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotScatterU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotStairsFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotStairsdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotStairsS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotStairsU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotStairsS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotStairsU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotStairsS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotStairsU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotStairsS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotStairsU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, xscale, x0, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotStairsFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotStairsdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotStairsS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotStairsU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotStairsS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotStairsU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotStairsS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotStairsU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotStairsS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairs(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotStairsU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotStairsG(label_id, getter, data, count::Integer, offset::Integer = 0)
    ccall((:ImPlot_PlotStairsG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label_id, getter, data, count, offset)
end

function PlotShaded(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotShadedFloatPtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotShadeddoublePtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotShadedS8PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotShadedU8PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotShadedS16PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotShadedU16PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotShadedS32PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotShadedU32PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotShadedS64PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotShadedU64PtrIntdoubledoubleInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotShadedFloatPtrFloatPtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotShadeddoublePtrdoublePtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotShadedS8PtrS8PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotShadedU8PtrU8PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotShadedS16PtrS16PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotShadedU16PtrU16PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotShadedS32PtrS32PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotShadedU32PtrU32PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotShadedS64PtrS64PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotShadedU64PtrU64PtrIntInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys1::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys2::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotShadedFloatPtrFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotShadeddoublePtrdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys1::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys2::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotShadedS8PtrS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys1::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys2::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotShadedU8PtrU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys1::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys2::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotShadedS16PtrS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys1::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys2::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotShadedU16PtrU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys1::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys2::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotShadedS32PtrS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys1::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys2::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotShadedU32PtrU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys1::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys2::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotShadedS64PtrS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys1::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys2::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotShadedU64PtrU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys1, ys2, count, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotBarsFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotBarsdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotBarsS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotBarsU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotBarsS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotBarsU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotBarsS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotBarsU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotBarsS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, width::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotBarsU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, width, shift, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotBarsFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotBarsdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotBarsS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotBarsU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotBarsS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotBarsU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotBarsS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotBarsU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotBarsS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, width::Real, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotBarsU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, width, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotBarsHFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotBarsHdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotBarsHS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotBarsHU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotBarsHS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotBarsHU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotBarsHS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotBarsHU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotBarsHS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, height::Real = 0.67, shift::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotBarsHU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cint, Cint), label_id, values, count, height, shift, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotBarsHFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotBarsHdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotBarsHS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotBarsHU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotBarsHS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotBarsHU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotBarsHS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotBarsHU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotBarsHS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotBarsH(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, height::Real, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotBarsHU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, height, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, err::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotErrorBarsFloatPtrFloatPtrFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, err::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotErrorBarsdoublePtrdoublePtrdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, err::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotErrorBarsS8PtrS8PtrS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, err::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotErrorBarsU8PtrU8PtrU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, err::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotErrorBarsS16PtrS16PtrS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, err::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotErrorBarsU16PtrU16PtrU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, err::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotErrorBarsS32PtrS32PtrS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, err::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotErrorBarsU32PtrU32PtrU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, err::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotErrorBarsS64PtrS64PtrS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, err::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotErrorBarsU64PtrU64PtrU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, neg::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, pos::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotErrorBarsFloatPtrFloatPtrFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, neg::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, pos::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotErrorBarsdoublePtrdoublePtrdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, neg::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, pos::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotErrorBarsS8PtrS8PtrS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, neg::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, pos::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotErrorBarsU8PtrU8PtrU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, neg::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, pos::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotErrorBarsS16PtrS16PtrS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, neg::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, pos::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotErrorBarsU16PtrU16PtrU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, neg::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, pos::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotErrorBarsS32PtrS32PtrS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, neg::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, pos::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotErrorBarsU32PtrU32PtrU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, neg::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, pos::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotErrorBarsS64PtrS64PtrS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, neg::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, pos::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotErrorBarsU64PtrU64PtrU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, err::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotErrorBarsHFloatPtrFloatPtrFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, err::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotErrorBarsHdoublePtrdoublePtrdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, err::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotErrorBarsHS8PtrS8PtrS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, err::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotErrorBarsHU8PtrU8PtrU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, err::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotErrorBarsHS16PtrS16PtrS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, err::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotErrorBarsHU16PtrU16PtrU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, err::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotErrorBarsHS32PtrS32PtrS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, err::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotErrorBarsHU32PtrU32PtrU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, err::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotErrorBarsHS64PtrS64PtrS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, err::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotErrorBarsHU64PtrU64PtrU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, err, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, neg::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, pos::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotErrorBarsHFloatPtrFloatPtrFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, neg::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, pos::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotErrorBarsHdoublePtrdoublePtrdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, neg::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, pos::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotErrorBarsHS8PtrS8PtrS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, neg::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, pos::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotErrorBarsHU8PtrU8PtrU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, neg::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, pos::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotErrorBarsHS16PtrS16PtrS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, neg::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, pos::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotErrorBarsHU16PtrU16PtrU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, neg::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, pos::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotErrorBarsHS32PtrS32PtrS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, neg::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, pos::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotErrorBarsHU32PtrU32PtrU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, neg::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, pos::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotErrorBarsHS64PtrS64PtrS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotErrorBarsH(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, neg::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, pos::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotErrorBarsHU64PtrU64PtrU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, neg, pos, count, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotStemsFloatPtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotStemsdoublePtrInt, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotStemsS8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotStemsU8PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotStemsS16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotStemsU16PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotStemsS32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotStemsU32PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotStemsS64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, y_ref::Real = 0, xscale::Real = 1, x0::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotStemsU64PtrInt, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, Cint, Cint), label_id, values, count, y_ref, xscale, x0, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotStemsFloatPtrFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotStemsdoublePtrdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotStemsS8PtrS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotStemsU8PtrU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotStemsS16PtrS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotStemsU16PtrU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotStemsS32PtrS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotStemsU32PtrU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotStemsS64PtrS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotStems(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, y_ref::Real = 0, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotStemsU64PtrU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, Cint, Cint), label_id, xs, ys, count, y_ref, offset, stride)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartFloatPtr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartdoublePtr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartS8Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartU8Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartS16Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartU16Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartS32Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartU32Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartS64Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x::Real, y::Real, radius::Real, normalize = false, label_fmt = "%.1f", angle0::Real = 90)
    ccall((:ImPlot_PlotPieChartU64Ptr, libcimplot), Cvoid, (Ptr{Cstring}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, Bool, Cstring, Cdouble), label_ids, values, count, x, y, radius, normalize, label_fmt, angle0)
end

function PlotHeatmap(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapdoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotHeatmap(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, rows::Integer, cols::Integer, scale_min::Real, scale_max::Real, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1))
    ccall((:ImPlot_PlotHeatmapU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max)
end

function PlotDigital(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cfloat))
    ccall((:ImPlot_PlotDigitalFloatPtr, libcimplot), Cvoid, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(Cdouble))
    ccall((:ImPlot_PlotDigitaldoublePtr, libcimplot), Cvoid, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS8))
    ccall((:ImPlot_PlotDigitalS8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU8))
    ccall((:ImPlot_PlotDigitalU8Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS16))
    ccall((:ImPlot_PlotDigitalS16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU16))
    ccall((:ImPlot_PlotDigitalU16Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS32))
    ccall((:ImPlot_PlotDigitalS32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU32))
    ccall((:ImPlot_PlotDigitalU32Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImS64))
    ccall((:ImPlot_PlotDigitalS64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotDigital(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, offset::Integer = 0, stride::Integer = sizeof(ImU64))
    ccall((:ImPlot_PlotDigitalU64Ptr, libcimplot), Cvoid, (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint), label_id, xs, ys, count, offset, stride)
end

function PlotImage(label_id, user_texture_id::ImTextureID, bounds_min::ImPlotPoint, bounds_max::ImPlotPoint, uv0::ImVec2 = ImVec2(0, 0), uv1::ImVec2 = ImVec2(1, 1), tint_col::ImVec4 = ImVec4(1, 1, 1, 1))
    ccall((:ImPlot_PlotImage, libcimplot), Cvoid, (Cstring, ImTextureID, ImPlotPoint, ImPlotPoint, ImVec2, ImVec2, ImVec4), label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1, tint_col)
end

function PlotText(text, x::Real, y::Real, vertical = false, pix_offset::ImVec2 = ImVec2(0, 0))
    ccall((:ImPlot_PlotText, libcimplot), Cvoid, (Cstring, Cdouble, Cdouble, Bool, ImVec2), text, x, y, vertical, pix_offset)
end

function PlotDummy(label_id)
    ccall((:ImPlot_PlotDummy, libcimplot), Cvoid, (Cstring,), label_id)
end

function SetNextPlotLimits(xmin::Real, xmax::Real, ymin::Real, ymax::Real, cond = ImGuiCond_Once)
    ccall((:ImPlot_SetNextPlotLimits, libcimplot), Cvoid, (Cdouble, Cdouble, Cdouble, Cdouble, ImGuiCond), xmin, xmax, ymin, ymax, cond)
end

function SetNextPlotLimitsX(xmin::Real, xmax::Real, cond = ImGuiCond_Once)
    ccall((:ImPlot_SetNextPlotLimitsX, libcimplot), Cvoid, (Cdouble, Cdouble, ImGuiCond), xmin, xmax, cond)
end

function SetNextPlotLimitsY(ymin::Real, ymax::Real, cond = ImGuiCond_Once, y_axis = 0)
    ccall((:ImPlot_SetNextPlotLimitsY, libcimplot), Cvoid, (Cdouble, Cdouble, ImGuiCond, ImPlotYAxis), ymin, ymax, cond, y_axis)
end

function LinkNextPlotLimits(xmin, xmax, ymin, ymax, ymin2, ymax2, ymin3, ymax3)
    ccall((:ImPlot_LinkNextPlotLimits, libcimplot), Cvoid, (Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}), xmin, xmax, ymin, ymax, ymin2, ymax2, ymin3, ymax3)
end

function FitNextPlotAxes(x = true, y = true, y2 = true, y3 = true)
    ccall((:ImPlot_FitNextPlotAxes, libcimplot), Cvoid, (Bool, Bool, Bool, Bool), x, y, y2, y3)
end

function SetNextPlotTicksX(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, n_ticks::Integer, labels, show_default = false)
    ccall((:ImPlot_SetNextPlotTicksXdoublePtr, libcimplot), Cvoid, (Ptr{Cdouble}, Cint, Ptr{Cstring}, Bool), values, n_ticks, labels, show_default)
end

function SetNextPlotTicksX(x_min::Real, x_max::Real, n_ticks::Integer, labels, show_default = false)
    ccall((:ImPlot_SetNextPlotTicksXdouble, libcimplot), Cvoid, (Cdouble, Cdouble, Cint, Ptr{Cstring}, Bool), x_min, x_max, n_ticks, labels, show_default)
end

function SetNextPlotTicksY(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, n_ticks::Integer, labels, show_default = false, y_axis = 0)
    ccall((:ImPlot_SetNextPlotTicksYdoublePtr, libcimplot), Cvoid, (Ptr{Cdouble}, Cint, Ptr{Cstring}, Bool, ImPlotYAxis), values, n_ticks, labels, show_default, y_axis)
end

function SetNextPlotTicksY(y_min::Real, y_max::Real, n_ticks::Integer, labels, show_default = false, y_axis = 0)
    ccall((:ImPlot_SetNextPlotTicksYdouble, libcimplot), Cvoid, (Cdouble, Cdouble, Cint, Ptr{Cstring}, Bool, ImPlotYAxis), y_min, y_max, n_ticks, labels, show_default, y_axis)
end

function SetPlotYAxis(y_axis)
    ccall((:ImPlot_SetPlotYAxis, libcimplot), Cvoid, (ImPlotYAxis,), y_axis)
end

function HideNextItem(hidden = true, cond = ImGuiCond_Once)
    ccall((:ImPlot_HideNextItem, libcimplot), Cvoid, (Bool, ImGuiCond), hidden, cond)
end

function PixelsToPlot(pix::ImVec2, y_axis = -1)
    pOut = Ref{ImPlotPoint}()
    ccall((:ImPlot_PixelsToPlotVec2, libcimplot), Cvoid, (Ref{ImPlotPoint}, ImVec2, ImPlotYAxis), pOut, pix, y_axis)
    pOut[]
end

function PixelsToPlot(x::Real, y::Real, y_axis = -1)
    pOut = Ref{ImPlotPoint}()
    ccall((:ImPlot_PixelsToPlotFloat, libcimplot), Cvoid, (Ref{ImPlotPoint}, Cfloat, Cfloat, ImPlotYAxis), pOut, x, y, y_axis)
    pOut[]
end

function PlotToPixels(plt::ImPlotPoint, y_axis = -1)
    pOut = Ref{ImVec2}()
    ccall((:ImPlot_PlotToPixelsPlotPoInt, libcimplot), Cvoid, (Ref{ImVec2}, ImPlotPoint, ImPlotYAxis), pOut, plt, y_axis)
    pOut[]
end

function PlotToPixels(x::Real, y::Real, y_axis = -1)
    pOut = Ref{ImVec2}()
    ccall((:ImPlot_PlotToPixelsdouble, libcimplot), Cvoid, (Ref{ImVec2}, Cdouble, Cdouble, ImPlotYAxis), pOut, x, y, y_axis)
    pOut[]
end

function GetPlotPos()
    pOut = Ref{ImVec2}()
    ccall((:ImPlot_GetPlotPos, libcimplot), Cvoid, (Ref{ImVec2},), pOut)
    pOut[]
end

function GetPlotSize()
    pOut = Ref{ImVec2}()
    ccall((:ImPlot_GetPlotSize, libcimplot), Cvoid, (Ref{ImVec2},), pOut)
    pOut[]
end

function IsPlotHovered()
    ccall((:ImPlot_IsPlotHovered, libcimplot), Bool, ())
end

function IsPlotXAxisHovered()
    ccall((:ImPlot_IsPlotXAxisHovered, libcimplot), Bool, ())
end

function IsPlotYAxisHovered(y_axis = 0)
    ccall((:ImPlot_IsPlotYAxisHovered, libcimplot), Bool, (ImPlotYAxis,), y_axis)
end

function GetPlotMousePos(y_axis = -1)
    pOut = Ref{ImPlotPoint}()
    ccall((:ImPlot_GetPlotMousePos, libcimplot), Cvoid, (Ref{ImPlotPoint}, ImPlotYAxis), pOut, y_axis)
    pOut[]
end

function GetPlotLimits(y_axis = -1)
    pOut = Ref{ImPlotLimits}()
    ccall((:ImPlot_GetPlotLimits, libcimplot), Cvoid, (Ref{ImPlotLimits}, ImPlotYAxis), pOut, y_axis)
    pOut[]
end

function IsPlotQueried()
    ccall((:ImPlot_IsPlotQueried, libcimplot), Bool, ())
end

function GetPlotQuery(y_axis = -1)
    pOut = Ref{ImPlotLimits}()
    ccall((:ImPlot_GetPlotQuery, libcimplot), Cvoid, (Ref{ImPlotLimits}, ImPlotYAxis), pOut, y_axis)
    pOut[]
end

function DragLineX(id, x_value::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, show_label = true, col::ImVec4 = ImVec4(0, 0, 0, -1), thickness::Real = 1)
    ccall((:ImPlot_DragLineX, libcimplot), Bool, (Cstring, Ptr{Cdouble}, Bool, ImVec4, Cfloat), id, x_value, show_label, col, thickness)
end

function DragLineY(id, y_value::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, show_label = true, col::ImVec4 = ImVec4(0, 0, 0, -1), thickness::Real = 1)
    ccall((:ImPlot_DragLineY, libcimplot), Bool, (Cstring, Ptr{Cdouble}, Bool, ImVec4, Cfloat), id, y_value, show_label, col, thickness)
end

function DragPoint(id, x::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, show_label = true, col::ImVec4 = ImVec4(0, 0, 0, -1), radius::Real = 4)
    ccall((:ImPlot_DragPoint, libcimplot), Bool, (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Bool, ImVec4, Cfloat), id, x, y, show_label, col, radius)
end

function SetLegendLocation(location, orientation = ImPlotOrientation_Vertical, outside = false)
    ccall((:ImPlot_SetLegendLocation, libcimplot), Cvoid, (ImPlotLocation, ImPlotOrientation, Bool), location, orientation, outside)
end

function SetMousePosLocation(location)
    ccall((:ImPlot_SetMousePosLocation, libcimplot), Cvoid, (ImPlotLocation,), location)
end

function IsLegendEntryHovered(label_id)
    ccall((:ImPlot_IsLegendEntryHovered, libcimplot), Bool, (Cstring,), label_id)
end

function BeginLegendDragDropSource(label_id, flags = 0)
    ccall((:ImPlot_BeginLegendDragDropSource, libcimplot), Bool, (Cstring, ImGuiDragDropFlags), label_id, flags)
end

function EndLegendDragDropSource()
    ccall((:ImPlot_EndLegendDragDropSource, libcimplot), Cvoid, ())
end

function BeginLegendPopup(label_id, mouse_button = 1)
    ccall((:ImPlot_BeginLegendPopup, libcimplot), Bool, (Cstring, ImGuiMouseButton), label_id, mouse_button)
end

function EndLegendPopup()
    ccall((:ImPlot_EndLegendPopup, libcimplot), Cvoid, ())
end

function GetStyle()
    ccall((:ImPlot_GetStyle, libcimplot), Ptr{ImPlotStyle}, ())
end

function StyleColorsAuto(dst)
    ccall((:ImPlot_StyleColorsAuto, libcimplot), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function StyleColorsClassic(dst)
    ccall((:ImPlot_StyleColorsClassic, libcimplot), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function StyleColorsDark(dst)
    ccall((:ImPlot_StyleColorsDark, libcimplot), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function StyleColorsLight(dst)
    ccall((:ImPlot_StyleColorsLight, libcimplot), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function PushStyleColor(idx, col::ImU32)
    ccall((:ImPlot_PushStyleColorU32, libcimplot), Cvoid, (ImPlotCol, ImU32), idx, col)
end

function PushStyleColor(idx, col::ImVec4)
    ccall((:ImPlot_PushStyleColorVec4, libcimplot), Cvoid, (ImPlotCol, ImVec4), idx, col)
end

function PopStyleColor(count::Integer = 1)
    ccall((:ImPlot_PopStyleColor, libcimplot), Cvoid, (Cint,), count)
end

function PushStyleVar(idx, val::Real)
    ccall((:ImPlot_PushStyleVarFloat, libcimplot), Cvoid, (ImPlotStyleVar, Cfloat), idx, val)
end

function PushStyleVar(idx, val::Integer)
    ccall((:ImPlot_PushStyleVarInt, libcimplot), Cvoid, (ImPlotStyleVar, Cint), idx, val)
end

function PushStyleVar(idx, val::ImVec2)
    ccall((:ImPlot_PushStyleVarVec2, libcimplot), Cvoid, (ImPlotStyleVar, ImVec2), idx, val)
end

function PopStyleVar(count::Integer = 1)
    ccall((:ImPlot_PopStyleVar, libcimplot), Cvoid, (Cint,), count)
end

function SetNextLineStyle(col::ImVec4 = ImVec4(0, 0, 0, -1), weight::Real = -1)
    ccall((:ImPlot_SetNextLineStyle, libcimplot), Cvoid, (ImVec4, Cfloat), col, weight)
end

function SetNextFillStyle(col::ImVec4 = ImVec4(0, 0, 0, -1), alpha_mod::Real = -1)
    ccall((:ImPlot_SetNextFillStyle, libcimplot), Cvoid, (ImVec4, Cfloat), col, alpha_mod)
end

function SetNextMarkerStyle(marker = -1, size::Real = -1, fill::ImVec4 = ImVec4(0, 0, 0, -1), weight::Real = -1, outline::ImVec4 = ImVec4(0, 0, 0, -1))
    ccall((:ImPlot_SetNextMarkerStyle, libcimplot), Cvoid, (ImPlotMarker, Cfloat, ImVec4, Cfloat, ImVec4), marker, size, fill, weight, outline)
end

function SetNextErrorBarStyle(col::ImVec4 = ImVec4(0, 0, 0, -1), size::Real = -1, weight::Real = -1)
    ccall((:ImPlot_SetNextErrorBarStyle, libcimplot), Cvoid, (ImVec4, Cfloat, Cfloat), col, size, weight)
end

function GetLastItemColor()
    pOut = Ref{ImVec4}()
    ccall((:ImPlot_GetLastItemColor, libcimplot), Cvoid, (Ref{ImVec4},), pOut)
    pOut[]
end

function GetStyleColorName(idx)
    ccall((:ImPlot_GetStyleColorName, libcimplot), Cstring, (ImPlotCol,), idx)
end

function GetMarkerName(idx)
    ccall((:ImPlot_GetMarkerName, libcimplot), Cstring, (ImPlotMarker,), idx)
end

function PushColormap(colormap)
    ccall((:ImPlot_PushColormapPlotColormap, libcimplot), Cvoid, (ImPlotColormap,), colormap)
end

function PushColormap(colormap::Union{ImVec4, AbstractArray{ImVec4}}, size::Integer)
    ccall((:ImPlot_PushColormapVec4Ptr, libcimplot), Cvoid, (Ptr{ImVec4}, Cint), colormap, size)
end

function PopColormap(count::Integer = 1)
    ccall((:ImPlot_PopColormap, libcimplot), Cvoid, (Cint,), count)
end

function SetColormap(colormap::Union{ImVec4, AbstractArray{ImVec4}}, size::Integer)
    ccall((:ImPlot_SetColormapVec4Ptr, libcimplot), Cvoid, (Ptr{ImVec4}, Cint), colormap, size)
end

function SetColormap(colormap, samples::Integer = 0)
    ccall((:ImPlot_SetColormapPlotColormap, libcimplot), Cvoid, (ImPlotColormap, Cint), colormap, samples)
end

function GetColormapSize()
    ccall((:ImPlot_GetColormapSize, libcimplot), Cint, ())
end

function GetColormapColor(index::Integer)
    pOut = Ref{ImVec4}()
    ccall((:ImPlot_GetColormapColor, libcimplot), Cvoid, (Ref{ImVec4}, Cint), pOut, index)
    pOut[]
end

function LerpColormap(t::Real)
    pOut = Ref{ImVec4}()
    ccall((:ImPlot_LerpColormap, libcimplot), Cvoid, (Ref{ImVec4}, Cfloat), pOut, t)
    pOut[]
end

function NextColormapColor()
    pOut = Ref{ImVec4}()
    ccall((:ImPlot_NextColormapColor, libcimplot), Cvoid, (Ref{ImVec4},), pOut)
    pOut[]
end

function ShowColormapScale(scale_min::Real, scale_max::Real, height::Real)
    ccall((:ImPlot_ShowColormapScale, libcimplot), Cvoid, (Cdouble, Cdouble, Cfloat), scale_min, scale_max, height)
end

function GetColormapName(colormap)
    ccall((:ImPlot_GetColormapName, libcimplot), Cstring, (ImPlotColormap,), colormap)
end

function GetInputMap()
    ccall((:ImPlot_GetInputMap, libcimplot), Ptr{ImPlotInputMap}, ())
end

function GetPlotDrawList()
    ccall((:ImPlot_GetPlotDrawList, libcimplot), Ptr{ImDrawList}, ())
end

function PushPlotClipRect()
    ccall((:ImPlot_PushPlotClipRect, libcimplot), Cvoid, ())
end

function PopPlotClipRect()
    ccall((:ImPlot_PopPlotClipRect, libcimplot), Cvoid, ())
end

function ShowStyleSelector(label)
    ccall((:ImPlot_ShowStyleSelector, libcimplot), Bool, (Cstring,), label)
end

function ShowColormapSelector(label)
    ccall((:ImPlot_ShowColormapSelector, libcimplot), Bool, (Cstring,), label)
end

function ShowStyleEditor(ref)
    ccall((:ImPlot_ShowStyleEditor, libcimplot), Cvoid, (Ptr{ImPlotStyle},), ref)
end

function ShowUserGuide()
    ccall((:ImPlot_ShowUserGuide, libcimplot), Cvoid, ())
end

function ShowMetricsWindow(p_popen)
    ccall((:ImPlot_ShowMetricsWindow, libcimplot), Cvoid, (Ptr{Bool},), p_popen)
end

function SetImGuiContext(ctx)
    ccall((:ImPlot_SetImGuiContext, libcimplot), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function ShowDemoWindow(p_open)
    ccall((:ImPlot_ShowDemoWindow, libcimplot), Cvoid, (Ptr{Bool},), p_open)
end

function PlotLineG(label_id, getter, data, count::Integer, offset::Integer = 0)
    ccall((:ImPlot_PlotLineG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label_id, getter, data, count, offset)
end

function PlotScatterG(label_id, getter, data, count::Integer, offset::Integer = 0)
    ccall((:ImPlot_PlotScatterG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label_id, getter, data, count, offset)
end

function PlotShadedG(label_id, getter1, data1, getter2, data2, count::Integer, offset::Integer = 0)
    ccall((:ImPlot_PlotShadedG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label_id, getter1, data1, getter2, data2, count, offset)
end

function PlotBarsG(label_id, getter, data, count::Integer, width::Real, offset::Integer = 0)
    ccall((:ImPlot_PlotBarsG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cdouble, Cint), label_id, getter, data, count, width, offset)
end

function PlotBarsHG(label_id, getter, data, count::Integer, height::Real, offset::Integer = 0)
    ccall((:ImPlot_PlotBarsHG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cdouble, Cint), label_id, getter, data, count, height, offset)
end

function PlotDigitalG(label_id, getter, data, count::Integer, offset::Integer = 0)
    ccall((:ImPlot_PlotDigitalG, libcimplot), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label_id, getter, data, count, offset)
end

function Annotate(x::Real, y::Real, pix_offset::ImVec2, fmt::String...)
    ccall((:ImPlot_AnnotateStr, libcimplot), Cvoid, (Cdouble,Cdouble,ImVec2,Cstring...),
          x, y, pix_offset, fmt...)
end

function AnnotateClamped(x::Real, y::Real, pix_offset::ImVec2, fmt::String...)
    ccall((:ImPlot_AnnotateClampedStr, libcimplot), Cvoid, (Cdouble,Cdouble,ImVec2,Cstring...),
          x, y, pix_offset, fmt...)
end

function Annotate(x::Real, y::Real, pix_offset::ImVec2, color::ImVec4, fmt::String...)
    ccall((:ImPlot_AnnotateVec4, libcimplot), Cvoid, (Cdouble,Cdouble,ImVec2,ImVec4,Cstring...),
          x, y, pix_offset, color, fmt...)
end

function AnnotateClamped(x::Real, y::Real, pix_offset::ImVec2, color::ImVec4, fmt::String...)
    ccall((:ImPlot_AnnotateClampedVec4, libcimplot), Cvoid, (Cdouble,Cdouble,ImVec2,ImVec4,Cstring...),
          x, y, pix_offset, color, fmt...)
end


# exports
const PREFIXES = ["ImPlot", "IMPLOT"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

