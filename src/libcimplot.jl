using CEnum: CEnum, @cenum

using CImGuiPack_jll

import CImGui:
    ImVec2,
    ImVec4,
    ImGuiMouseButton,
    ImGuiKey,
    ImGuiCond,
    ImGuiDragDropFlags,
    ImS8,
    ImU8,
    ImS16,
    ImU16,
    ImS32,
    ImU32,
    ImS64,
    ImU64,
    ImTextureID,
    ImTextureRef,
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
const IMPLOT_AUTO_COL = ImVec4(0, 0, 0, -1)
export IMPLOT_AUTO, IMPLOT_AUTO_COL


const __time_t = Clong

struct ImVector_ImU8
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU8}
end

struct ImVector_ImU16
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU16}
end

struct ImVector_int
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cint}
end

const time_t = __time_t

struct tm
    tm_sec::Cint
    tm_min::Cint
    tm_hour::Cint
    tm_mday::Cint
    tm_mon::Cint
    tm_year::Cint
    tm_wday::Cint
    tm_yday::Cint
    tm_isdst::Cint
    tm_gmtoff::Clong
    tm_zone::Cstring
end

const ImPlotAxisFlags = Cint

struct ImPlotRange
    Min::Cdouble
    Max::Cdouble
end

const ImPlotCond = Cint

const ImPlotScale = Cint

struct ImPlotTick
    PlotPos::Cdouble
    PixelPos::Cfloat
    LabelSize::ImVec2
    TextOffset::Cint
    Major::Bool
    ShowLabel::Bool
    Level::Cint
    Idx::Cint
end

struct ImVector_ImPlotTick
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotTick}
end

struct ImPlotTicker
    Ticks::ImVector_ImPlotTick
    TextBuffer::ImGuiTextBuffer
    MaxSize::ImVec2
    LateSize::ImVec2
    Levels::Cint
end

# typedef int ( * ImPlotFormatter ) ( double value , char * buff , int size , void * user_data )
const ImPlotFormatter = Ptr{Cvoid}

# typedef void ( * ImPlotLocator ) ( ImPlotTicker * ticker , const ImPlotRange_c range , float pixels , bool vertical , ImPlotFormatter formatter , void * formatter_data )
const ImPlotLocator = Ptr{Cvoid}

struct ImPlotTime
    S::time_t
    Us::Cint
end

# typedef double ( * ImPlotTransform ) ( double value , void * user_data )
const ImPlotTransform = Ptr{Cvoid}

struct ImPlotAxis
    ID::ImGuiID
    Flags::ImPlotAxisFlags
    PreviousFlags::ImPlotAxisFlags
    Range::ImPlotRange
    RangeCond::ImPlotCond
    Scale::ImPlotScale
    FitExtents::ImPlotRange
    OrthoAxis::Ptr{ImPlotAxis}
    ConstraintRange::ImPlotRange
    ConstraintZoom::ImPlotRange
    Ticker::ImPlotTicker
    Formatter::ImPlotFormatter
    FormatterData::Ptr{Cvoid}
    FormatSpec::NTuple{16,Cchar}
    Locator::ImPlotLocator
    LinkedMin::Ptr{Cdouble}
    LinkedMax::Ptr{Cdouble}
    PickerLevel::Cint
    PickerTimeMin::ImPlotTime
    PickerTimeMax::ImPlotTime
    TransformForward::ImPlotTransform
    TransformInverse::ImPlotTransform
    TransformData::Ptr{Cvoid}
    PixelMin::Cfloat
    PixelMax::Cfloat
    ScaleMin::Cdouble
    ScaleMax::Cdouble
    ScaleToPixel::Cdouble
    Datum1::Cfloat
    Datum2::Cfloat
    HoverRect::ImRect
    LabelOffset::Cint
    ColorMaj::ImU32
    ColorMin::ImU32
    ColorTick::ImU32
    ColorTxt::ImU32
    ColorBg::ImU32
    ColorHov::ImU32
    ColorAct::ImU32
    ColorHiLi::ImU32
    Enabled::Bool
    Vertical::Bool
    FitThisFrame::Bool
    HasRange::Bool
    HasFormatSpec::Bool
    ShowDefaultTicks::Bool
    Hovered::Bool
    Held::Bool
end

const ImPlotAxis = ImPlotAxis

const ImPlotDateFmt = Cint

const ImPlotTimeFmt = Cint

struct ImPlotDateTimeSpec
    Date::ImPlotDateFmt
    Time::ImPlotTimeFmt
    UseISO8601::Bool
    Use24HourClock::Bool
end

const ImPlotDateTimeSpec = ImPlotDateTimeSpec

struct ImPlotPoint
    x::Cdouble
    y::Cdouble
end

const ImPlotPoint = ImPlotPoint

const ImPlotRange = ImPlotRange

struct ImPlotRect
    X::ImPlotRange
    Y::ImPlotRange
end

const ImPlotRect = ImPlotRect

const ImPlotMarker = Cint

const ImPlotItemFlags = Cint

struct ImPlotSpec
    LineColor::ImVec4
    LineColors::Ptr{ImU32}
    LineWeight::Cfloat
    FillColor::ImVec4
    FillColors::Ptr{ImU32}
    FillAlpha::Cfloat
    Marker::ImPlotMarker
    MarkerSize::Cfloat
    MarkerSizes::Ptr{Cfloat}
    MarkerLineColor::ImVec4
    MarkerLineColors::Ptr{ImU32}
    MarkerFillColor::ImVec4
    MarkerFillColors::Ptr{ImU32}
    Size::Cfloat
    Offset::Cint
    Stride::Cint
    Flags::ImPlotItemFlags
end

const ImPlotSpec = ImPlotSpec

const ImPlotTick = ImPlotTick

const ImPlotTime = ImPlotTime

const ImPlotFlags = Cint

const ImPlotLocation = Cint

const ImPlotMouseTextFlags = Cint

const ImPlotLegendFlags = Cint

struct ImPlotLegend
    Flags::ImPlotLegendFlags
    PreviousFlags::ImPlotLegendFlags
    Location::ImPlotLocation
    PreviousLocation::ImPlotLocation
    Scroll::ImVec2
    Indices::ImVector_int
    Labels::ImGuiTextBuffer
    Rect::ImRect
    RectClamped::ImRect
    Hovered::Bool
    Held::Bool
    CanGoInside::Bool
end

struct ImPlotItem
    ID::ImGuiID
    Color::ImU32
    Marker::ImPlotMarker
    LegendHoverRect::ImRect
    NameOffset::Cint
    Show::Bool
    LegendHovered::Bool
    SeenThisFrame::Bool
end

struct ImVector_ImPlotItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotItem}
end

struct ImPool_ImPlotItem
    Buf::ImVector_ImPlotItem
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotItemGroup
    ID::ImGuiID
    Legend::ImPlotLegend
    ItemPool::ImPool_ImPlotItem
    ColormapIdx::Cint
    MarkerIdx::ImPlotMarker
end

const ImAxis = Cint

struct ImPlotPlot
    ID::ImGuiID
    Flags::ImPlotFlags
    PreviousFlags::ImPlotFlags
    MouseTextLocation::ImPlotLocation
    MouseTextFlags::ImPlotMouseTextFlags
    Axes::NTuple{6,ImPlotAxis}
    TextBuffer::ImGuiTextBuffer
    Items::ImPlotItemGroup
    CurrentX::ImAxis
    CurrentY::ImAxis
    FrameRect::ImRect
    CanvasRect::ImRect
    PlotRect::ImRect
    AxesRect::ImRect
    SelectRect::ImRect
    SelectStart::ImVec2
    TitleOffset::Cint
    JustCreated::Bool
    Initialized::Bool
    SetupLocked::Bool
    FitThisFrame::Bool
    Hovered::Bool
    Held::Bool
    Selecting::Bool
    Selected::Bool
    ContextLocked::Bool
end
function Base.getproperty(x::Ptr{ImPlotPlot}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :Flags && return Ptr{ImPlotFlags}(x + 4)
    f === :PreviousFlags && return Ptr{ImPlotFlags}(x + 8)
    f === :MouseTextLocation && return Ptr{ImPlotLocation}(x + 12)
    f === :MouseTextFlags && return Ptr{ImPlotMouseTextFlags}(x + 16)
    f === :Axes && return Ptr{NTuple{6,ImPlotAxis}}(x + 24)
    f === :TextBuffer && return Ptr{ImGuiTextBuffer}(x + 2280)
    f === :Items && return Ptr{ImPlotItemGroup}(x + 2296)
    f === :CurrentX && return Ptr{ImAxis}(x + 2448)
    f === :CurrentY && return Ptr{ImAxis}(x + 2452)
    f === :FrameRect && return Ptr{ImRect}(x + 2456)
    f === :CanvasRect && return Ptr{ImRect}(x + 2472)
    f === :PlotRect && return Ptr{ImRect}(x + 2488)
    f === :AxesRect && return Ptr{ImRect}(x + 2504)
    f === :SelectRect && return Ptr{ImRect}(x + 2520)
    f === :SelectStart && return Ptr{ImVec2}(x + 2536)
    f === :TitleOffset && return Ptr{Cint}(x + 2544)
    f === :JustCreated && return Ptr{Bool}(x + 2548)
    f === :Initialized && return Ptr{Bool}(x + 2549)
    f === :SetupLocked && return Ptr{Bool}(x + 2550)
    f === :FitThisFrame && return Ptr{Bool}(x + 2551)
    f === :Hovered && return Ptr{Bool}(x + 2552)
    f === :Held && return Ptr{Bool}(x + 2553)
    f === :Selecting && return Ptr{Bool}(x + 2554)
    f === :Selected && return Ptr{Bool}(x + 2555)
    f === :ContextLocked && return Ptr{Bool}(x + 2556)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImPlotPlot}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_ImPlotPlot
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotPlot}
end

struct ImPool_ImPlotPlot
    Buf::ImVector_ImPlotPlot
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

const ImPlotSubplotFlags = Cint

struct ImPlotAlignmentData
    Vertical::Bool
    PadA::Cfloat
    PadB::Cfloat
    PadAMax::Cfloat
    PadBMax::Cfloat
end

struct ImVector_ImPlotAlignmentData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotAlignmentData}
end

struct ImVector_ImPlotRange
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotRange}
end

struct ImPlotSubplot
    ID::ImGuiID
    Flags::ImPlotSubplotFlags
    PreviousFlags::ImPlotSubplotFlags
    Items::ImPlotItemGroup
    Rows::Cint
    Cols::Cint
    CurrentIdx::Cint
    FrameRect::ImRect
    GridRect::ImRect
    CellSize::ImVec2
    RowAlignmentData::ImVector_ImPlotAlignmentData
    ColAlignmentData::ImVector_ImPlotAlignmentData
    RowRatios::ImVector_float
    ColRatios::ImVector_float
    RowLinkData::ImVector_ImPlotRange
    ColLinkData::ImVector_ImPlotRange
    TempSizes::NTuple{2,Cfloat}
    FrameHovered::Bool
    HasTitle::Bool
end

struct ImVector_ImPlotSubplot
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotSubplot}
end

struct ImPool_ImPlotSubplot
    Buf::ImVector_ImPlotSubplot
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotAnnotation
    Pos::ImVec2
    Offset::ImVec2
    ColorBg::ImU32
    ColorFg::ImU32
    TextOffset::Cint
    Clamp::Bool
end

struct ImVector_ImPlotAnnotation
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotAnnotation}
end

struct ImPlotAnnotationCollection
    Annotations::ImVector_ImPlotAnnotation
    TextBuffer::ImGuiTextBuffer
    Size::Cint
end

struct ImPlotTag
    Axis::ImAxis
    Value::Cdouble
    ColorBg::ImU32
    ColorFg::ImU32
    TextOffset::Cint
end

struct ImVector_ImPlotTag
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotTag}
end

struct ImPlotTagCollection
    Tags::ImVector_ImPlotTag
    TextBuffer::ImGuiTextBuffer
    Size::Cint
end

const ImPlotColormap = Cint

struct ImPlotStyle
    PlotDefaultSize::ImVec2
    PlotMinSize::ImVec2
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
    DigitalPadding::Cfloat
    DigitalSpacing::Cfloat
    Colors::NTuple{16,ImVec4}
    Colormap::ImPlotColormap
    UseLocalTime::Bool
    UseISO8601::Bool
    Use24HourClock::Bool
end
function Base.getproperty(x::Ptr{ImPlotStyle}, f::Symbol)
    f === :PlotDefaultSize && return Ptr{ImVec2}(x + 0)
    f === :PlotMinSize && return Ptr{ImVec2}(x + 8)
    f === :PlotBorderSize && return Ptr{Cfloat}(x + 16)
    f === :MinorAlpha && return Ptr{Cfloat}(x + 20)
    f === :MajorTickLen && return Ptr{ImVec2}(x + 24)
    f === :MinorTickLen && return Ptr{ImVec2}(x + 32)
    f === :MajorTickSize && return Ptr{ImVec2}(x + 40)
    f === :MinorTickSize && return Ptr{ImVec2}(x + 48)
    f === :MajorGridSize && return Ptr{ImVec2}(x + 56)
    f === :MinorGridSize && return Ptr{ImVec2}(x + 64)
    f === :PlotPadding && return Ptr{ImVec2}(x + 72)
    f === :LabelPadding && return Ptr{ImVec2}(x + 80)
    f === :LegendPadding && return Ptr{ImVec2}(x + 88)
    f === :LegendInnerPadding && return Ptr{ImVec2}(x + 96)
    f === :LegendSpacing && return Ptr{ImVec2}(x + 104)
    f === :MousePosPadding && return Ptr{ImVec2}(x + 112)
    f === :AnnotationPadding && return Ptr{ImVec2}(x + 120)
    f === :FitPadding && return Ptr{ImVec2}(x + 128)
    f === :DigitalPadding && return Ptr{Cfloat}(x + 136)
    f === :DigitalSpacing && return Ptr{Cfloat}(x + 140)
    f === :Colors && return Ptr{NTuple{16,ImVec4}}(x + 144)
    f === :Colormap && return Ptr{ImPlotColormap}(x + 400)
    f === :UseLocalTime && return Ptr{Bool}(x + 404)
    f === :UseISO8601 && return Ptr{Bool}(x + 405)
    f === :Use24HourClock && return Ptr{Bool}(x + 406)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImPlotStyle}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_bool
    Size::Cint
    Capacity::Cint
    Data::Ptr{Bool}
end

struct ImPlotColormapData
    Keys::ImVector_ImU32
    KeyCounts::ImVector_int
    KeyOffsets::ImVector_int
    Tables::ImVector_ImU32
    TableSizes::ImVector_int
    TableOffsets::ImVector_int
    Text::ImGuiTextBuffer
    TextOffsets::ImVector_int
    Quals::ImVector_bool
    Map::ImGuiStorage
    Count::Cint
end

struct ImVector_ImPlotColormap
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotColormap}
end

struct ImVector_double
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cdouble}
end

struct ImPlotNextPlotData
    RangeCond::NTuple{6,ImPlotCond}
    Range::NTuple{6,ImPlotRange}
    HasRange::NTuple{6,Bool}
    Fit::NTuple{6,Bool}
    LinkedMin::NTuple{6,Ptr{Cdouble}}
    LinkedMax::NTuple{6,Ptr{Cdouble}}
end

struct ImPlotNextItemData
    Spec::ImPlotSpec
    RenderLine::Bool
    RenderFill::Bool
    RenderMarkerLine::Bool
    RenderMarkerFill::Bool
    RenderMarkers::Bool
    HasHidden::Bool
    Hidden::Bool
    HiddenCond::ImPlotCond
end

struct ImPlotInputMap
    Pan::ImGuiMouseButton
    PanMod::Cint
    Fit::ImGuiMouseButton
    Select::ImGuiMouseButton
    SelectCancel::ImGuiMouseButton
    SelectMod::Cint
    SelectHorzMod::Cint
    SelectVertMod::Cint
    Menu::ImGuiMouseButton
    OverrideMod::Cint
    ZoomMod::Cint
    ZoomRate::Cfloat
end
function Base.getproperty(x::Ptr{ImPlotInputMap}, f::Symbol)
    f === :Pan && return Ptr{ImGuiMouseButton}(x + 0)
    f === :PanMod && return Ptr{Cint}(x + 4)
    f === :Fit && return Ptr{ImGuiMouseButton}(x + 8)
    f === :Select && return Ptr{ImGuiMouseButton}(x + 12)
    f === :SelectCancel && return Ptr{ImGuiMouseButton}(x + 16)
    f === :SelectMod && return Ptr{Cint}(x + 20)
    f === :SelectHorzMod && return Ptr{Cint}(x + 24)
    f === :SelectVertMod && return Ptr{Cint}(x + 28)
    f === :Menu && return Ptr{ImGuiMouseButton}(x + 32)
    f === :OverrideMod && return Ptr{Cint}(x + 36)
    f === :ZoomMod && return Ptr{Cint}(x + 40)
    f === :ZoomRate && return Ptr{Cfloat}(x + 44)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImPlotInputMap}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImPool_ImPlotAlignmentData
    Buf::ImVector_ImPlotAlignmentData
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotContext
    Plots::ImPool_ImPlotPlot
    Subplots::ImPool_ImPlotSubplot
    CurrentPlot::Ptr{ImPlotPlot}
    CurrentSubplot::Ptr{ImPlotSubplot}
    CurrentItems::Ptr{ImPlotItemGroup}
    CurrentItem::Ptr{ImPlotItem}
    PreviousItem::Ptr{ImPlotItem}
    CTicker::ImPlotTicker
    Annotations::ImPlotAnnotationCollection
    Tags::ImPlotTagCollection
    Style::ImPlotStyle
    ColorModifiers::ImVector_ImGuiColorMod
    StyleModifiers::ImVector_ImGuiStyleMod
    ColormapData::ImPlotColormapData
    ColormapModifiers::ImVector_ImPlotColormap
    Tm::tm
    TempDouble1::ImVector_double
    TempDouble2::ImVector_double
    TempInt1::ImVector_int
    DigitalPlotItemCnt::Cint
    DigitalPlotOffset::Cint
    NextPlotData::ImPlotNextPlotData
    NextItemData::ImPlotNextItemData
    InputMap::ImPlotInputMap
    OpenContextThisFrame::Bool
    MousePosStringBuilder::ImGuiTextBuffer
    SortItems::Ptr{ImPlotItemGroup}
    AlignmentData::ImPool_ImPlotAlignmentData
    CurrentAlignmentH::Ptr{ImPlotAlignmentData}
    CurrentAlignmentV::Ptr{ImPlotAlignmentData}
end

mutable struct ImPlotAxisColor end

struct ImVector_ImS16
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS16}
end

struct ImVector_ImS32
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS32}
end

struct ImVector_ImS64
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS64}
end

struct ImVector_ImS8
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS8}
end

struct ImVector_ImU64
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU64}
end

const ImPlotProp = Cint

const ImPlotDragToolFlags = Cint

const ImPlotColormapScaleFlags = Cint

const ImPlotLineFlags = Cint

const ImPlotScatterFlags = Cint

const ImPlotBubblesFlags = Cint

const ImPlotPolygonFlags = Cint

const ImPlotStairsFlags = Cint

const ImPlotShadedFlags = Cint

const ImPlotBarsFlags = Cint

const ImPlotBarGroupsFlags = Cint

const ImPlotErrorBarsFlags = Cint

const ImPlotStemsFlags = Cint

const ImPlotInfLinesFlags = Cint

const ImPlotPieChartFlags = Cint

const ImPlotHeatmapFlags = Cint

const ImPlotHistogramFlags = Cint

const ImPlotDigitalFlags = Cint

const ImPlotImageFlags = Cint

const ImPlotTextFlags = Cint

const ImPlotDummyFlags = Cint

const ImPlotCol = Cint

const ImPlotStyleVar = Cint

const ImPlotBin = Cint

@cenum ImAxis_::UInt32 begin
    ImAxis_X1 = 0
    ImAxis_X2 = 1
    ImAxis_X3 = 2
    ImAxis_Y1 = 3
    ImAxis_Y2 = 4
    ImAxis_Y3 = 5
    ImAxis_COUNT = 6
end

@cenum ImPlotProp_::UInt32 begin
    ImPlotProp_LineColor = 0
    ImPlotProp_LineColors = 1
    ImPlotProp_LineWeight = 2
    ImPlotProp_FillColor = 3
    ImPlotProp_FillColors = 4
    ImPlotProp_FillAlpha = 5
    ImPlotProp_Marker = 6
    ImPlotProp_MarkerSize = 7
    ImPlotProp_MarkerSizes = 8
    ImPlotProp_MarkerLineColor = 9
    ImPlotProp_MarkerLineColors = 10
    ImPlotProp_MarkerFillColor = 11
    ImPlotProp_MarkerFillColors = 12
    ImPlotProp_Size = 13
    ImPlotProp_Offset = 14
    ImPlotProp_Stride = 15
    ImPlotProp_Flags = 16
end

@cenum ImPlotFlags_::UInt32 begin
    ImPlotFlags_None = 0
    ImPlotFlags_NoTitle = 1
    ImPlotFlags_NoLegend = 2
    ImPlotFlags_NoMouseText = 4
    ImPlotFlags_NoInputs = 8
    ImPlotFlags_NoMenus = 16
    ImPlotFlags_NoBoxSelect = 32
    ImPlotFlags_NoFrame = 64
    ImPlotFlags_Equal = 128
    ImPlotFlags_Crosshairs = 256
    ImPlotFlags_CanvasOnly = 55
end

@cenum ImPlotAxisFlags_::UInt32 begin
    ImPlotAxisFlags_None = 0
    ImPlotAxisFlags_NoLabel = 1
    ImPlotAxisFlags_NoGridLines = 2
    ImPlotAxisFlags_NoTickMarks = 4
    ImPlotAxisFlags_NoTickLabels = 8
    ImPlotAxisFlags_NoInitialFit = 16
    ImPlotAxisFlags_NoMenus = 32
    ImPlotAxisFlags_NoSideSwitch = 64
    ImPlotAxisFlags_NoHighlight = 128
    ImPlotAxisFlags_Opposite = 256
    ImPlotAxisFlags_Foreground = 512
    ImPlotAxisFlags_Invert = 1024
    ImPlotAxisFlags_AutoFit = 2048
    ImPlotAxisFlags_RangeFit = 4096
    ImPlotAxisFlags_PanStretch = 8192
    ImPlotAxisFlags_LockMin = 16384
    ImPlotAxisFlags_LockMax = 32768
    ImPlotAxisFlags_Lock = 49152
    ImPlotAxisFlags_NoDecorations = 15
    ImPlotAxisFlags_AuxDefault = 258
end

@cenum ImPlotSubplotFlags_::UInt32 begin
    ImPlotSubplotFlags_None = 0
    ImPlotSubplotFlags_NoTitle = 1
    ImPlotSubplotFlags_NoLegend = 2
    ImPlotSubplotFlags_NoMenus = 4
    ImPlotSubplotFlags_NoResize = 8
    ImPlotSubplotFlags_NoAlign = 16
    ImPlotSubplotFlags_ShareItems = 32
    ImPlotSubplotFlags_LinkRows = 64
    ImPlotSubplotFlags_LinkCols = 128
    ImPlotSubplotFlags_LinkAllX = 256
    ImPlotSubplotFlags_LinkAllY = 512
    ImPlotSubplotFlags_ColMajor = 1024
end

@cenum ImPlotLegendFlags_::UInt32 begin
    ImPlotLegendFlags_None = 0
    ImPlotLegendFlags_NoButtons = 1
    ImPlotLegendFlags_NoHighlightItem = 2
    ImPlotLegendFlags_NoHighlightAxis = 4
    ImPlotLegendFlags_NoMenus = 8
    ImPlotLegendFlags_Outside = 16
    ImPlotLegendFlags_Horizontal = 32
    ImPlotLegendFlags_Sort = 64
    ImPlotLegendFlags_Reverse = 128
end

@cenum ImPlotMouseTextFlags_::UInt32 begin
    ImPlotMouseTextFlags_None = 0
    ImPlotMouseTextFlags_NoAuxAxes = 1
    ImPlotMouseTextFlags_NoFormat = 2
    ImPlotMouseTextFlags_ShowAlways = 4
end

@cenum ImPlotDragToolFlags_::UInt32 begin
    ImPlotDragToolFlags_None = 0
    ImPlotDragToolFlags_NoCursors = 1
    ImPlotDragToolFlags_NoFit = 2
    ImPlotDragToolFlags_NoInputs = 4
    ImPlotDragToolFlags_Delayed = 8
end

@cenum ImPlotColormapScaleFlags_::UInt32 begin
    ImPlotColormapScaleFlags_None = 0
    ImPlotColormapScaleFlags_NoLabel = 1
    ImPlotColormapScaleFlags_Opposite = 2
    ImPlotColormapScaleFlags_Invert = 4
end

@cenum ImPlotItemFlags_::UInt32 begin
    ImPlotItemFlags_None = 0
    ImPlotItemFlags_NoLegend = 1
    ImPlotItemFlags_NoFit = 2
end

@cenum ImPlotLineFlags_::UInt32 begin
    ImPlotLineFlags_None = 0
    ImPlotLineFlags_Segments = 1024
    ImPlotLineFlags_Loop = 2048
    ImPlotLineFlags_SkipNaN = 4096
    ImPlotLineFlags_NoClip = 8192
    ImPlotLineFlags_Shaded = 16384
end

@cenum ImPlotScatterFlags_::UInt32 begin
    ImPlotScatterFlags_None = 0
    ImPlotScatterFlags_NoClip = 1024
end

@cenum ImPlotBubblesFlags_::UInt32 begin
    ImPlotBubblesFlags_None = 0
end

@cenum ImPlotPolygonFlags_::UInt32 begin
    ImPlotPolygonFlags_None = 0
    ImPlotPolygonFlags_Concave = 1024
end

@cenum ImPlotStairsFlags_::UInt32 begin
    ImPlotStairsFlags_None = 0
    ImPlotStairsFlags_PreStep = 1024
    ImPlotStairsFlags_Shaded = 2048
end

@cenum ImPlotShadedFlags_::UInt32 begin
    ImPlotShadedFlags_None = 0
end

@cenum ImPlotBarsFlags_::UInt32 begin
    ImPlotBarsFlags_None = 0
    ImPlotBarsFlags_Horizontal = 1024
end

@cenum ImPlotBarGroupsFlags_::UInt32 begin
    ImPlotBarGroupsFlags_None = 0
    ImPlotBarGroupsFlags_Horizontal = 1024
    ImPlotBarGroupsFlags_Stacked = 2048
end

@cenum ImPlotErrorBarsFlags_::UInt32 begin
    ImPlotErrorBarsFlags_None = 0
    ImPlotErrorBarsFlags_Horizontal = 1024
end

@cenum ImPlotStemsFlags_::UInt32 begin
    ImPlotStemsFlags_None = 0
    ImPlotStemsFlags_Horizontal = 1024
end

@cenum ImPlotInfLinesFlags_::UInt32 begin
    ImPlotInfLinesFlags_None = 0
    ImPlotInfLinesFlags_Horizontal = 1024
end

@cenum ImPlotPieChartFlags_::UInt32 begin
    ImPlotPieChartFlags_None = 0
    ImPlotPieChartFlags_Normalize = 1024
    ImPlotPieChartFlags_IgnoreHidden = 2048
    ImPlotPieChartFlags_Exploding = 4096
    ImPlotPieChartFlags_NoSliceBorder = 8192
end

@cenum ImPlotHeatmapFlags_::UInt32 begin
    ImPlotHeatmapFlags_None = 0
    ImPlotHeatmapFlags_ColMajor = 1024
end

@cenum ImPlotHistogramFlags_::UInt32 begin
    ImPlotHistogramFlags_None = 0
    ImPlotHistogramFlags_Horizontal = 1024
    ImPlotHistogramFlags_Cumulative = 2048
    ImPlotHistogramFlags_Density = 4096
    ImPlotHistogramFlags_NoOutliers = 8192
    ImPlotHistogramFlags_ColMajor = 16384
end

@cenum ImPlotDigitalFlags_::UInt32 begin
    ImPlotDigitalFlags_None = 0
end

@cenum ImPlotImageFlags_::UInt32 begin
    ImPlotImageFlags_None = 0
end

@cenum ImPlotTextFlags_::UInt32 begin
    ImPlotTextFlags_None = 0
    ImPlotTextFlags_Vertical = 1024
end

@cenum ImPlotDummyFlags_::UInt32 begin
    ImPlotDummyFlags_None = 0
end

@cenum ImPlotCond_::UInt32 begin
    ImPlotCond_None = 0
    ImPlotCond_Always = 1
    ImPlotCond_Once = 2
end

@cenum ImPlotCol_::UInt32 begin
    ImPlotCol_FrameBg = 0
    ImPlotCol_PlotBg = 1
    ImPlotCol_PlotBorder = 2
    ImPlotCol_LegendBg = 3
    ImPlotCol_LegendBorder = 4
    ImPlotCol_LegendText = 5
    ImPlotCol_TitleText = 6
    ImPlotCol_InlayText = 7
    ImPlotCol_AxisText = 8
    ImPlotCol_AxisGrid = 9
    ImPlotCol_AxisTick = 10
    ImPlotCol_AxisBg = 11
    ImPlotCol_AxisBgHovered = 12
    ImPlotCol_AxisBgActive = 13
    ImPlotCol_Selection = 14
    ImPlotCol_Crosshairs = 15
    ImPlotCol_COUNT = 16
end

@cenum ImPlotStyleVar_::UInt32 begin
    ImPlotStyleVar_PlotDefaultSize = 0
    ImPlotStyleVar_PlotMinSize = 1
    ImPlotStyleVar_PlotBorderSize = 2
    ImPlotStyleVar_MinorAlpha = 3
    ImPlotStyleVar_MajorTickLen = 4
    ImPlotStyleVar_MinorTickLen = 5
    ImPlotStyleVar_MajorTickSize = 6
    ImPlotStyleVar_MinorTickSize = 7
    ImPlotStyleVar_MajorGridSize = 8
    ImPlotStyleVar_MinorGridSize = 9
    ImPlotStyleVar_PlotPadding = 10
    ImPlotStyleVar_LabelPadding = 11
    ImPlotStyleVar_LegendPadding = 12
    ImPlotStyleVar_LegendInnerPadding = 13
    ImPlotStyleVar_LegendSpacing = 14
    ImPlotStyleVar_MousePosPadding = 15
    ImPlotStyleVar_AnnotationPadding = 16
    ImPlotStyleVar_FitPadding = 17
    ImPlotStyleVar_DigitalPadding = 18
    ImPlotStyleVar_DigitalSpacing = 19
    ImPlotStyleVar_COUNT = 20
end

@cenum ImPlotScale_::UInt32 begin
    ImPlotScale_Linear = 0
    ImPlotScale_Time = 1
    ImPlotScale_Log10 = 2
    ImPlotScale_SymLog = 3
end

@cenum ImPlotMarker_::Int32 begin
    ImPlotMarker_None = -2
    ImPlotMarker_Auto = -1
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
    ImPlotMarker_Vertical = 10
    ImPlotMarker_Horizontal = 11
    ImPlotMarker_COUNT = 12
end

@cenum ImPlotColormap_::UInt32 begin
    ImPlotColormap_Deep = 0
    ImPlotColormap_Dark = 1
    ImPlotColormap_Pastel = 2
    ImPlotColormap_Paired = 3
    ImPlotColormap_Viridis = 4
    ImPlotColormap_Plasma = 5
    ImPlotColormap_Hot = 6
    ImPlotColormap_Cool = 7
    ImPlotColormap_Pink = 8
    ImPlotColormap_Jet = 9
    ImPlotColormap_Twilight = 10
    ImPlotColormap_RdBu = 11
    ImPlotColormap_BrBG = 12
    ImPlotColormap_PiYG = 13
    ImPlotColormap_Spectral = 14
    ImPlotColormap_Greys = 15
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

@cenum ImPlotBin_::Int32 begin
    ImPlotBin_Sqrt = -1
    ImPlotBin_Sturges = -2
    ImPlotBin_Rice = -3
    ImPlotBin_Scott = -4
end

# typedef ImPlotPoint_c ( * ImPlotGetter ) ( int idx , void * user_data )
const ImPlotGetter = Ptr{Cvoid}

const ImPlotTimeUnit = Cint

const ImPlotMarkerInternal = Cint

@cenum ImPlotTimeUnit_::UInt32 begin
    ImPlotTimeUnit_Us = 0
    ImPlotTimeUnit_Ms = 1
    ImPlotTimeUnit_S = 2
    ImPlotTimeUnit_Min = 3
    ImPlotTimeUnit_Hr = 4
    ImPlotTimeUnit_Day = 5
    ImPlotTimeUnit_Mo = 6
    ImPlotTimeUnit_Yr = 7
    ImPlotTimeUnit_COUNT = 8
end

@cenum ImPlotDateFmt_::UInt32 begin
    ImPlotDateFmt_None = 0
    ImPlotDateFmt_DayMo = 1
    ImPlotDateFmt_DayMoYr = 2
    ImPlotDateFmt_MoYr = 3
    ImPlotDateFmt_Mo = 4
    ImPlotDateFmt_Yr = 5
end

@cenum ImPlotTimeFmt_::UInt32 begin
    ImPlotTimeFmt_None = 0
    ImPlotTimeFmt_Us = 1
    ImPlotTimeFmt_SUs = 2
    ImPlotTimeFmt_SMs = 3
    ImPlotTimeFmt_S = 4
    ImPlotTimeFmt_MinSMs = 5
    ImPlotTimeFmt_HrMinSMs = 6
    ImPlotTimeFmt_HrMinS = 7
    ImPlotTimeFmt_HrMin = 8
    ImPlotTimeFmt_Hr = 9
end

@cenum ImPlotMarkerInternal_::Int32 begin
    ImPlotMarker_Invalid = -3
end

struct ImPlotPointError
    X::Cdouble
    Y::Cdouble
    Neg::Cdouble
    Pos::Cdouble
end

struct Formatter_Time_Data
    Time::ImPlotTime
    Spec::ImPlotDateTimeSpec
    UserFormatter::ImPlotFormatter
    UserFormatterData::Ptr{Cvoid}
end

# typedef void * ( * ImPlotPoint_getter ) ( void * data , int idx , ImPlotPoint_c * point )
const ImPlotPoint_getter = Ptr{Cvoid}

"""
    ImPlotSpec_ImPlotSpec()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L536).
"""
function ImPlotSpec_ImPlotSpec()
    @ccall libcimgui.ImPlotSpec_ImPlotSpec()::Ptr{ImPlotSpec}
end

function ImPlotSpec_destroy(self)
    @ccall libcimgui.ImPlotSpec_destroy(self::Ptr{ImPlotSpec})::Cvoid
end

"""
    ImPlotPoint_ImPlotPoint_Nil()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L612).
"""
function ImPlotPoint_ImPlotPoint_Nil()
    @ccall libcimgui.ImPlotPoint_ImPlotPoint_Nil()::Ptr{ImPlotPoint}
end

"""
    ImPlotPoint_ImPlotPoint_double(_x::Cdouble, _y::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L613).
"""
function ImPlotPoint_ImPlotPoint_double(_x::Cdouble, _y::Cdouble)
    @ccall libcimgui.ImPlotPoint_ImPlotPoint_double(_x::Cdouble, _y::Cdouble)::Ptr{ImPlotPoint}
end

"""
    ImPlotPoint_ImPlotPoint_Vec2(p::ImVec2)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L614).
"""
function ImPlotPoint_ImPlotPoint_Vec2(p::ImVec2)
    @ccall libcimgui.ImPlotPoint_ImPlotPoint_Vec2(p::ImVec2)::Ptr{ImPlotPoint}
end

"""
    ImPlotRange_ImPlotRange_Nil()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L627).
"""
function ImPlotRange_ImPlotRange_Nil()
    @ccall libcimgui.ImPlotRange_ImPlotRange_Nil()::Ptr{ImPlotRange}
end

"""
    ImPlotRange_ImPlotRange_double(_min::Cdouble, _max::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L628).
"""
function ImPlotRange_ImPlotRange_double(_min::Cdouble, _max::Cdouble)
    @ccall libcimgui.ImPlotRange_ImPlotRange_double(_min::Cdouble, _max::Cdouble)::Ptr{ImPlotRange}
end

"""
    Contains(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}}, value::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L629).
"""
function Contains(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}}, value::Real)
    @ccall libcimgui.ImPlotRange_Contains(self::Ptr{ImPlotRange}, value::Cdouble)::Bool
end

"""
    Size(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L630).
"""
function Size(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}})
    @ccall libcimgui.ImPlotRange_Size(self::Ptr{ImPlotRange})::Cdouble
end

"""
    Clamp(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}}, value::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L631).
"""
function Clamp(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}}, value::Real)
    @ccall libcimgui.ImPlotRange_Clamp(self::Ptr{ImPlotRange}, value::Cdouble)::Cdouble
end

"""
    ImPlotRect_ImPlotRect_Nil()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L637).
"""
function ImPlotRect_ImPlotRect_Nil()
    @ccall libcimgui.ImPlotRect_ImPlotRect_Nil()::Ptr{ImPlotRect}
end

function ImPlotRect_destroy(self)
    @ccall libcimgui.ImPlotRect_destroy(self::Ptr{ImPlotRect})::Cvoid
end

"""
    ImPlotRect_ImPlotRect_double(x_min::Cdouble, x_max::Cdouble, y_min::Cdouble, y_max::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L638).
"""
function ImPlotRect_ImPlotRect_double(x_min::Cdouble, x_max::Cdouble, y_min::Cdouble, y_max::Cdouble)
    @ccall libcimgui.ImPlotRect_ImPlotRect_double(
        x_min::Cdouble,
        x_max::Cdouble,
        y_min::Cdouble,
        y_max::Cdouble,
    )::Ptr{ImPlotRect}
end

"""
    Contains(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, p::ImPlotPoint)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L639).
"""
function Contains(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, p::ImPlotPoint)
    @ccall libcimgui.ImPlotRect_Contains_PlotPoint(self::Ptr{ImPlotRect}, p::ImPlotPoint)::Bool
end

"""
    Contains(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, x::Real, y::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L640).
"""
function Contains(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, x::Real, y::Real)
    @ccall libcimgui.ImPlotRect_Contains_double(self::Ptr{ImPlotRect}, x::Cdouble, y::Cdouble)::Bool
end

"""
    Size(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L641).
"""
function Size(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    @ccall libcimgui.ImPlotRect_Size(self::Ptr{ImPlotRect})::ImPlotPoint
end

"""
    Clamp(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, p::ImPlotPoint)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L642).
"""
function Clamp(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, p::ImPlotPoint)
    @ccall libcimgui.ImPlotRect_Clamp_PlotPoint(self::Ptr{ImPlotRect}, p::ImPlotPoint)::ImPlotPoint
end

"""
    Clamp(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, x::Real, y::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L643).
"""
function Clamp(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, x::Real, y::Real)
    @ccall libcimgui.ImPlotRect_Clamp_double(self::Ptr{ImPlotRect}, x::Cdouble, y::Cdouble)::ImPlotPoint
end

"""
    Min(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L644).
"""
function Min(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    @ccall libcimgui.ImPlotRect_Min(self::Ptr{ImPlotRect})::ImPlotPoint
end

"""
    Max(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L645).
"""
function Max(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    @ccall libcimgui.ImPlotRect_Max(self::Ptr{ImPlotRect})::ImPlotPoint
end

"""
    ImPlotStyle()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L680).
"""
function ImPlotStyle()
    @ccall libcimgui.ImPlotStyle_ImPlotStyle()::Ptr{ImPlotStyle}
end

function Base.finalizer(self::Union{Ptr{ImPlotStyle},ImPlotStyle})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotStyle_destroy(self::Ptr{ImPlotStyle})::Cvoid)
end

"""
    ImPlotInputMap()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L712).
"""
function ImPlotInputMap()
    @ccall libcimgui.ImPlotInputMap_ImPlotInputMap()::Ptr{ImPlotInputMap}
end

function Base.finalizer(self::Union{Ptr{ImPlotInputMap},ImPlotInputMap})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotInputMap_destroy(self::Ptr{ImPlotInputMap})::Cvoid)
end

"""
    CreateContext()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L735).
"""
function CreateContext()
    @ccall libcimgui.ImPlot_CreateContext()::Ptr{ImPlotContext}
end

"""
    DestroyContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L737).
"""
function DestroyContext(ctx)
    @ccall libcimgui.ImPlot_DestroyContext(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    GetCurrentContext()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L739).
"""
function GetCurrentContext()
    @ccall libcimgui.ImPlot_GetCurrentContext()::Ptr{ImPlotContext}
end

"""
    SetCurrentContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L741).
"""
function SetCurrentContext(ctx)
    @ccall libcimgui.ImPlot_SetCurrentContext(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    SetImGuiContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L747).
"""
function SetImGuiContext(ctx)
    @ccall libcimgui.ImPlot_SetImGuiContext(ctx::Ptr{ImGuiContext})::Cvoid
end

"""
    BeginPlot(title_id, size::ImVec2 = ImVec2(-1, 0), flags::Union{ImPlotFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L769).
"""
function BeginPlot(title_id, size::ImVec2 = ImVec2(-1, 0), flags::Union{ImPlotFlags_,Integer} = 0)
    @ccall libcimgui.ImPlot_BeginPlot(title_id::Cstring, size::ImVec2, flags::ImPlotFlags)::Bool
end

"""
    EndPlot()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L773).
"""
function EndPlot()
    @ccall libcimgui.ImPlot_EndPlot()::Cvoid
end

"""
    BeginSubplots(title_id, rows::Integer, cols::Integer, size::ImVec2, flags::Union{ImPlotSubplotFlags_, Integer} = 0, row_ratios::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}} = Ptr{Cfloat}(), col_ratios::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}} = Ptr{Cfloat}())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L825).
"""
function BeginSubplots(
    title_id,
    rows::Integer,
    cols::Integer,
    size::ImVec2,
    flags::Union{ImPlotSubplotFlags_,Integer} = 0,
    row_ratios::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}} = Ptr{Cfloat}(),
    col_ratios::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}} = Ptr{Cfloat}(),
)
    @ccall libcimgui.ImPlot_BeginSubplots(
        title_id::Cstring,
        rows::Cint,
        cols::Cint,
        size::ImVec2,
        flags::ImPlotSubplotFlags,
        row_ratios::Ptr{Cfloat},
        col_ratios::Ptr{Cfloat},
    )::Bool
end

"""
    EndSubplots()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L835).
"""
function EndSubplots()
    @ccall libcimgui.ImPlot_EndSubplots()::Cvoid
end

"""
    SetupAxis(axis::Union{ImAxis_, Integer}, label = C_NULL, flags::Union{ImPlotAxisFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L867).
"""
function SetupAxis(axis::Union{ImAxis_,Integer}, label = C_NULL, flags::Union{ImPlotAxisFlags_,Integer} = 0)
    @ccall libcimgui.ImPlot_SetupAxis(axis::ImAxis, label::Cstring, flags::ImPlotAxisFlags)::Cvoid
end

"""
    SetupAxisLimits(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L869).
"""
function SetupAxisLimits(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)
    @ccall libcimgui.ImPlot_SetupAxisLimits(axis::ImAxis, v_min::Cdouble, v_max::Cdouble, cond::ImPlotCond)::Cvoid
end

"""
    SetupAxisLinks(axis::Union{ImAxis_, Integer}, link_min::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, link_max::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L871).
"""
function SetupAxisLinks(
    axis::Union{ImAxis_,Integer},
    link_min::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    link_max::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
)
    @ccall libcimgui.ImPlot_SetupAxisLinks(axis::ImAxis, link_min::Ptr{Cdouble}, link_max::Ptr{Cdouble})::Cvoid
end

"""
    SetupAxisFormat(axis::Union{ImAxis_, Integer}, fmt)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L873).
"""
function SetupAxisFormat(axis::Union{ImAxis_,Integer}, fmt)
    @ccall libcimgui.ImPlot_SetupAxisFormat_Str(axis::ImAxis, fmt::Cstring)::Cvoid
end

"""
    SetupAxisFormat(axis::Union{ImAxis_, Integer}, formatter::ImPlotFormatter, data::Union{Ptr, Ref, AbstractArray})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L875).
"""
function SetupAxisFormat(axis::Union{ImAxis_,Integer}, formatter::ImPlotFormatter, data::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_SetupAxisFormat_PlotFormatter(
        axis::ImAxis,
        formatter::ImPlotFormatter,
        data::Ptr{Cvoid},
    )::Cvoid
end

"""
    SetupAxisTicks(axis::Union{ImAxis_, Integer}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, n_ticks::Integer, labels::Union{Ptr{Nothing}, String, AbstractArray{String}} = C_NULL, keep_default = false)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L877).
"""
function SetupAxisTicks(
    axis::Union{ImAxis_,Integer},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    n_ticks::Integer,
    labels::Union{Ptr{Nothing},String,AbstractArray{String}} = C_NULL,
    keep_default = false,
)
    @ccall libcimgui.ImPlot_SetupAxisTicks_doublePtr(
        axis::ImAxis,
        values::Ptr{Cdouble},
        n_ticks::Cint,
        labels::Ptr{Cstring},
        keep_default::Bool,
    )::Cvoid
end

"""
    SetupAxisTicks(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, n_ticks::Integer, labels::Union{Ptr{Nothing}, String, AbstractArray{String}} = C_NULL, keep_default = false)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L879).
"""
function SetupAxisTicks(
    axis::Union{ImAxis_,Integer},
    v_min::Real,
    v_max::Real,
    n_ticks::Integer,
    labels::Union{Ptr{Nothing},String,AbstractArray{String}} = C_NULL,
    keep_default = false,
)
    @ccall libcimgui.ImPlot_SetupAxisTicks_double(
        axis::ImAxis,
        v_min::Cdouble,
        v_max::Cdouble,
        n_ticks::Cint,
        labels::Ptr{Cstring},
        keep_default::Bool,
    )::Cvoid
end

"""
    SetupAxisScale(axis::Union{ImAxis_, Integer}, scale::Union{ImPlotScale_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L881).
"""
function SetupAxisScale(axis::Union{ImAxis_,Integer}, scale::Union{ImPlotScale_,Integer})
    @ccall libcimgui.ImPlot_SetupAxisScale_PlotScale(axis::ImAxis, scale::ImPlotScale)::Cvoid
end

"""
    SetupAxisScale(axis::Union{ImAxis_, Integer}, forward::ImPlotTransform, inverse::ImPlotTransform, data::Union{Ptr, Ref, AbstractArray})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L883).
"""
function SetupAxisScale(
    axis::Union{ImAxis_,Integer},
    forward::ImPlotTransform,
    inverse::ImPlotTransform,
    data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlot_SetupAxisScale_PlotTransform(
        axis::ImAxis,
        forward::ImPlotTransform,
        inverse::ImPlotTransform,
        data::Ptr{Cvoid},
    )::Cvoid
end

"""
    SetupAxisLimitsConstraints(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L885).
"""
function SetupAxisLimitsConstraints(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real)
    @ccall libcimgui.ImPlot_SetupAxisLimitsConstraints(axis::ImAxis, v_min::Cdouble, v_max::Cdouble)::Cvoid
end

"""
    SetupAxisZoomConstraints(axis::Union{ImAxis_, Integer}, z_min::Real, z_max::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L887).
"""
function SetupAxisZoomConstraints(axis::Union{ImAxis_,Integer}, z_min::Real, z_max::Real)
    @ccall libcimgui.ImPlot_SetupAxisZoomConstraints(axis::ImAxis, z_min::Cdouble, z_max::Cdouble)::Cvoid
end

"""
    SetupAxes(x_label, y_label, x_flags::Union{ImPlotAxisFlags_, Integer} = 0, y_flags::Union{ImPlotAxisFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L890).
"""
function SetupAxes(
    x_label,
    y_label,
    x_flags::Union{ImPlotAxisFlags_,Integer} = 0,
    y_flags::Union{ImPlotAxisFlags_,Integer} = 0,
)
    @ccall libcimgui.ImPlot_SetupAxes(
        x_label::Cstring,
        y_label::Cstring,
        x_flags::ImPlotAxisFlags,
        y_flags::ImPlotAxisFlags,
    )::Cvoid
end

"""
    SetupAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L892).
"""
function SetupAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)
    @ccall libcimgui.ImPlot_SetupAxesLimits(
        x_min::Cdouble,
        x_max::Cdouble,
        y_min::Cdouble,
        y_max::Cdouble,
        cond::ImPlotCond,
    )::Cvoid
end

"""
    SetupLegend(location::Union{ImPlotLocation_, Integer}, flags::Union{ImPlotLegendFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L895).
"""
function SetupLegend(location::Union{ImPlotLocation_,Integer}, flags::Union{ImPlotLegendFlags_,Integer} = 0)
    @ccall libcimgui.ImPlot_SetupLegend(location::ImPlotLocation, flags::ImPlotLegendFlags)::Cvoid
end

"""
    SetupMouseText(location::Union{ImPlotLocation_, Integer}, flags::Union{ImPlotMouseTextFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L897).
"""
function SetupMouseText(location::Union{ImPlotLocation_,Integer}, flags::Union{ImPlotMouseTextFlags_,Integer} = 0)
    @ccall libcimgui.ImPlot_SetupMouseText(location::ImPlotLocation, flags::ImPlotMouseTextFlags)::Cvoid
end

"""
    SetupFinish()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L901).
"""
function SetupFinish()
    @ccall libcimgui.ImPlot_SetupFinish()::Cvoid
end

"""
    SetNextAxisLimits(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L927).
"""
function SetNextAxisLimits(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)
    @ccall libcimgui.ImPlot_SetNextAxisLimits(axis::ImAxis, v_min::Cdouble, v_max::Cdouble, cond::ImPlotCond)::Cvoid
end

"""
    SetNextAxisLinks(axis::Union{ImAxis_, Integer}, link_min::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, link_max::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L929).
"""
function SetNextAxisLinks(
    axis::Union{ImAxis_,Integer},
    link_min::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    link_max::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
)
    @ccall libcimgui.ImPlot_SetNextAxisLinks(axis::ImAxis, link_min::Ptr{Cdouble}, link_max::Ptr{Cdouble})::Cvoid
end

"""
    SetNextAxisToFit(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L931).
"""
function SetNextAxisToFit(axis::Union{ImAxis_,Integer})
    @ccall libcimgui.ImPlot_SetNextAxisToFit(axis::ImAxis)::Cvoid
end

"""
    SetNextAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L934).
"""
function SetNextAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)
    @ccall libcimgui.ImPlot_SetNextAxesLimits(
        x_min::Cdouble,
        x_max::Cdouble,
        y_min::Cdouble,
        y_max::Cdouble,
        cond::ImPlotCond,
    )::Cvoid
end

"""
    SetNextAxesToFit()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L936).
"""
function SetNextAxesToFit()
    @ccall libcimgui.ImPlot_SetNextAxesToFit()::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L991).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_FloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_doublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_S64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L992).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLine_U64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotLineG(label_id, getter::ImPlotPoint_getter, data::Union{Ptr, Ref, AbstractArray}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L993).
"""
function PlotLineG(
    label_id,
    getter::ImPlotPoint_getter,
    data::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotLineG_LJ(
        label_id::Cstring,
        getter::ImPlotPoint_getter,
        data::Ptr{Cvoid},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L996).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_FloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_doublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_S64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L997).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatter_U64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotScatterG(label_id, getter::ImPlotPoint_getter, data::Union{Ptr, Ref, AbstractArray}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L998).
"""
function PlotScatterG(
    label_id,
    getter::ImPlotPoint_getter,
    data::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotScatterG_LJ(
        label_id::Cstring,
        getter::ImPlotPoint_getter,
        data::Ptr{Cvoid},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, szs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    szs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_FloatPtrFloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        szs::Ptr{Cfloat},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, szs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    szs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_doublePtrdoublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        szs::Ptr{Cdouble},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, szs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    szs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S8PtrS8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        szs::Ptr{ImS8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, szs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    szs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U8PtrU8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        szs::Ptr{ImU8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, szs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    szs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S16PtrS16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        szs::Ptr{ImS16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, szs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    szs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U16PtrU16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        szs::Ptr{ImU16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, szs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    szs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S32PtrS32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        szs::Ptr{ImS32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, szs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    szs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U32PtrU32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        szs::Ptr{ImU32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, szs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    szs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S64PtrS64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        szs::Ptr{ImS64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, szs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1001).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    szs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U64PtrU64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        szs::Ptr{ImU64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, szs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    szs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_FloatPtrFloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        szs::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, szs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    szs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_doublePtrdoublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        szs::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, szs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    szs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S8PtrS8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        szs::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, szs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    szs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U8PtrU8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        szs::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, szs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    szs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S16PtrS16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        szs::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, szs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    szs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U16PtrU16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        szs::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, szs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    szs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S32PtrS32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        szs::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, szs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    szs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U32PtrU32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        szs::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, szs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    szs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_S64PtrS64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        szs::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, szs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1002).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    szs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBubbles_U64PtrU64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        szs::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_FloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_doublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_S8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_U8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_S16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_U16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_S32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_U32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_S64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1005).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPolygon_U64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1008).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_FloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_doublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_S64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1009).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairs_U64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStairsG(label_id, getter::ImPlotPoint_getter, data::Union{Ptr, Ref, AbstractArray}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1010).
"""
function PlotStairsG(
    label_id,
    getter::ImPlotPoint_getter,
    data::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStairsG_LJ(
        label_id::Cstring,
        getter::ImPlotPoint_getter,
        data::Ptr{Cvoid},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        yref::Cdouble,
        xscale::Cdouble,
        xstart::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_FloatPtrFloatPtrInt(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_doublePtrdoublePtrInt(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S8PtrS8PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U8PtrU8PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S16PtrS16PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U16PtrU16PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S32PtrS32PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U32PtrU32PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S64PtrS64PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, yref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1014).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    yref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U64PtrU64PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        yref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys1::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys2::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys1::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys2::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_FloatPtrFloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys1::Ptr{Cfloat},
        ys2::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys1::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys2::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys1::Ptr{Cdouble},
        ys2::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys1::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys2::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys1::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys2::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S8PtrS8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys1::Ptr{ImS8},
        ys2::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys1::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys2::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys1::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys2::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U8PtrU8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys1::Ptr{ImU8},
        ys2::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys1::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys2::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys1::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys2::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S16PtrS16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys1::Ptr{ImS16},
        ys2::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys1::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys2::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys1::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys2::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U16PtrU16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys1::Ptr{ImU16},
        ys2::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys1::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys2::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys1::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys2::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S32PtrS32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys1::Ptr{ImS32},
        ys2::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys1::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys2::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys1::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys2::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U32PtrU32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys1::Ptr{ImU32},
        ys2::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys1::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys2::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys1::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys2::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_S64PtrS64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys1::Ptr{ImS64},
        ys2::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys1::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys2::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1015).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys1::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys2::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShaded_U64PtrU64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys1::Ptr{ImU64},
        ys2::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotShadedG(label_id, getter1::ImPlotPoint_getter, data1::Union{Ptr, Ref, AbstractArray}, getter2::ImPlotPoint_getter, data2::Union{Ptr, Ref, AbstractArray}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1016).
"""
function PlotShadedG(
    label_id,
    getter1::ImPlotPoint_getter,
    data1::Union{Ptr,Ref,AbstractArray},
    getter2::ImPlotPoint_getter,
    data2::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotShadedG_LJ(
        label_id::Cstring,
        getter1::ImPlotPoint_getter,
        data1::Ptr{Cvoid},
        getter2::ImPlotPoint_getter,
        data2::Ptr{Cvoid},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1019).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        bar_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_FloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_doublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_S64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1020).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBars_U64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarsG(label_id, getter::ImPlotPoint_getter, data::Union{Ptr, Ref, AbstractArray}, count::Integer, bar_size::Real, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1021).
"""
function PlotBarsG(
    label_id,
    getter::ImPlotPoint_getter,
    data::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    bar_size::Real,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarsG_LJ(
        label_id::Cstring,
        getter::ImPlotPoint_getter,
        data::Ptr{Cvoid},
        count::Cint,
        bar_size::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_FloatPtr(
        label_ids::Ptr{Cstring},
        values::Ptr{Cfloat},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_doublePtr(
        label_ids::Ptr{Cstring},
        values::Ptr{Cdouble},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_S8Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS8},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_U8Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU8},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_S16Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS16},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_U16Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU16},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_S32Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS32},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_U32Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU32},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_S64Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS64},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1024).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotBarGroups_U64Ptr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU64},
        item_count::Cint,
        group_count::Cint,
        group_size::Cdouble,
        shift::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, err::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    err::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrInt(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        err::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, err::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    err::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrInt(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        err::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, err::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    err::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        err::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, err::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    err::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        err::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, err::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    err::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        err::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, err::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    err::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        err::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, err::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    err::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        err::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, err::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    err::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        err::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, err::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    err::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrInt(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        err::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, err::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1027).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    err::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrInt(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        err::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, neg::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, pos::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    neg::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    pos::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        neg::Ptr{Cfloat},
        pos::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, neg::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, pos::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    neg::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    pos::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        neg::Ptr{Cdouble},
        pos::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, neg::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, pos::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    neg::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    pos::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        neg::Ptr{ImS8},
        pos::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, neg::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, pos::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    neg::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    pos::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        neg::Ptr{ImU8},
        pos::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, neg::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, pos::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    neg::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    pos::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        neg::Ptr{ImS16},
        pos::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, neg::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, pos::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    neg::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    pos::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        neg::Ptr{ImU16},
        pos::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, neg::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, pos::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    neg::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    pos::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        neg::Ptr{ImS32},
        pos::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, neg::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, pos::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    neg::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    pos::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        neg::Ptr{ImU32},
        pos::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, neg::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, pos::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    neg::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    pos::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        neg::Ptr{ImS64},
        pos::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, neg::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, pos::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1028).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    neg::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    pos::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        neg::Ptr{ImU64},
        pos::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_FloatPtrInt(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_doublePtrInt(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S8PtrInt(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U8PtrInt(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S16PtrInt(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U16PtrInt(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S32PtrInt(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U32PtrInt(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S64PtrInt(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1031).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U64PtrInt(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        ref::Cdouble,
        scale::Cdouble,
        start::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_FloatPtrFloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_doublePtrdoublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S8PtrS8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U8PtrU8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S16PtrS16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U16PtrU16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S32PtrS32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U32PtrU32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_S64PtrS64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, ref::Real = 0, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1032).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    ref::Real = 0,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotStems_U64PtrU64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        ref::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_FloatPtr(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_doublePtr(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_S8Ptr(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_U8Ptr(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_S16Ptr(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_U16Ptr(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_S32Ptr(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_U32Ptr(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_S64Ptr(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1035).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotInfLines_U64Ptr(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_FloatPtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{Cfloat},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_doublePtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{Cdouble},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S8PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS8},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U8PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU8},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S16PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS16},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U16PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU16},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S32PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS32},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U32PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU32},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S64PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS64},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data::Union{Ptr, Ref, AbstractArray}, angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1038).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data::Union{Ptr,Ref,AbstractArray},
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U64PtrPlotFormatter(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU64},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        fmt::ImPlotFormatter,
        fmt_data::Ptr{Cvoid},
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_FloatPtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{Cfloat},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_doublePtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{Cdouble},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S8PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS8},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U8PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU8},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S16PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS16},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U16PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU16},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S32PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS32},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U32PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU32},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_S64PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImS64},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1039).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    label_fmt = "%.1f",
    angle0::Real = 90,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotPieChart_U64PtrStr(
        label_ids::Ptr{Cstring},
        values::Ptr{ImU64},
        count::Cint,
        x::Cdouble,
        y::Cdouble,
        radius::Cdouble,
        label_fmt::Cstring,
        angle0::Cdouble,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_FloatPtr(
        label_id::Cstring,
        values::Ptr{Cfloat},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_doublePtr(
        label_id::Cstring,
        values::Ptr{Cdouble},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_S8Ptr(
        label_id::Cstring,
        values::Ptr{ImS8},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_U8Ptr(
        label_id::Cstring,
        values::Ptr{ImU8},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_S16Ptr(
        label_id::Cstring,
        values::Ptr{ImS16},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_U16Ptr(
        label_id::Cstring,
        values::Ptr{ImU16},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_S32Ptr(
        label_id::Cstring,
        values::Ptr{ImS32},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_U32Ptr(
        label_id::Cstring,
        values::Ptr{ImU32},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_S64Ptr(
        label_id::Cstring,
        values::Ptr{ImS64},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1042).
"""
function PlotHeatmap(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    rows::Integer,
    cols::Integer,
    scale_min::Real = 0,
    scale_max::Real = 0,
    label_fmt = "%.1f",
    bounds_min::ImPlotPoint = ImPlotPoint(0, 0),
    bounds_max::ImPlotPoint = ImPlotPoint(1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHeatmap_U64Ptr(
        label_id::Cstring,
        values::Ptr{ImU64},
        rows::Cint,
        cols::Cint,
        scale_min::Cdouble,
        scale_max::Cdouble,
        label_fmt::Cstring,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotHistogram(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_FloatPtr(
        label_id::Cstring,
        values::Ptr{Cfloat},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_doublePtr(
        label_id::Cstring,
        values::Ptr{Cdouble},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_S8Ptr(
        label_id::Cstring,
        values::Ptr{ImS8},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_U8Ptr(
        label_id::Cstring,
        values::Ptr{ImU8},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_S16Ptr(
        label_id::Cstring,
        values::Ptr{ImS16},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_U16Ptr(
        label_id::Cstring,
        values::Ptr{ImU16},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_S32Ptr(
        label_id::Cstring,
        values::Ptr{ImS32},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_U32Ptr(
        label_id::Cstring,
        values::Ptr{ImU32},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_S64Ptr(
        label_id::Cstring,
        values::Ptr{ImS64},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1046).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram_U64Ptr(
        label_id::Cstring,
        values::Ptr{ImU64},
        count::Cint,
        bins::Cint,
        bar_scale::Cdouble,
        range::ImPlotRange,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_FloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_doublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_S8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_U8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_S16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_U16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_S32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_U32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_S64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, y_bins::Union{ImPlotBin_, Integer} = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1050).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    x_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    y_bins::Union{ImPlotBin_,Integer} = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotHistogram2D_U64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        x_bins::Cint,
        y_bins::Cint,
        range::ImPlotRect,
        spec::ImPlotSpec,
    )::Cdouble
end

"""
    PlotDigital(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_FloatPtr(
        label_id::Cstring,
        xs::Ptr{Cfloat},
        ys::Ptr{Cfloat},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_doublePtr(
        label_id::Cstring,
        xs::Ptr{Cdouble},
        ys::Ptr{Cdouble},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_S8Ptr(
        label_id::Cstring,
        xs::Ptr{ImS8},
        ys::Ptr{ImS8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_U8Ptr(
        label_id::Cstring,
        xs::Ptr{ImU8},
        ys::Ptr{ImU8},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_S16Ptr(
        label_id::Cstring,
        xs::Ptr{ImS16},
        ys::Ptr{ImS16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_U16Ptr(
        label_id::Cstring,
        xs::Ptr{ImU16},
        ys::Ptr{ImU16},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_S32Ptr(
        label_id::Cstring,
        xs::Ptr{ImS32},
        ys::Ptr{ImS32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_U32Ptr(
        label_id::Cstring,
        xs::Ptr{ImU32},
        ys::Ptr{ImU32},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_S64Ptr(
        label_id::Cstring,
        xs::Ptr{ImS64},
        ys::Ptr{ImS64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1053).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigital_U64Ptr(
        label_id::Cstring,
        xs::Ptr{ImU64},
        ys::Ptr{ImU64},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotDigitalG(label_id, getter::ImPlotPoint_getter, data::Union{Ptr, Ref, AbstractArray}, count::Integer, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1054).
"""
function PlotDigitalG(
    label_id,
    getter::ImPlotPoint_getter,
    data::Union{Ptr,Ref,AbstractArray},
    count::Integer,
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotDigitalG_LJ(
        label_id::Cstring,
        getter::ImPlotPoint_getter,
        data::Ptr{Cvoid},
        count::Cint,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotImage(label_id, tex_ref::ImTextureRef, bounds_min::ImPlotPoint, bounds_max::ImPlotPoint, uv0::ImVec2 = ImVec2(0, 0), uv1::ImVec2 = ImVec2(1, 1), tint_col::ImVec4 = ImVec4(1, 1, 1, 1), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1058).
"""
function PlotImage(
    label_id,
    tex_ref::ImTextureRef,
    bounds_min::ImPlotPoint,
    bounds_max::ImPlotPoint,
    uv0::ImVec2 = ImVec2(0, 0),
    uv1::ImVec2 = ImVec2(1, 1),
    tint_col::ImVec4 = ImVec4(1, 1, 1, 1),
    spec::ImPlotSpec = ImPlotSpec(),
)
    @ccall libcimgui.ImPlot_PlotImage(
        label_id::Cstring,
        tex_ref::ImTextureRef,
        bounds_min::ImPlotPoint,
        bounds_max::ImPlotPoint,
        uv0::ImVec2,
        uv1::ImVec2,
        tint_col::ImVec4,
        spec::ImPlotSpec,
    )::Cvoid
end

"""
    PlotText(text, x::Real, y::Real, pix_offset::ImVec2 = ImVec2(0, 0), spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1064).
"""
function PlotText(text, x::Real, y::Real, pix_offset::ImVec2 = ImVec2(0, 0), spec::ImPlotSpec = ImPlotSpec())
    @ccall libcimgui.ImPlot_PlotText(text::Cstring, x::Cdouble, y::Cdouble, pix_offset::ImVec2, spec::ImPlotSpec)::Cvoid
end

"""
    PlotDummy(label_id, spec::ImPlotSpec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1067).
"""
function PlotDummy(label_id, spec::ImPlotSpec = ImPlotSpec())
    @ccall libcimgui.ImPlot_PlotDummy(label_id::Cstring, spec::ImPlotSpec)::Cvoid
end

"""
    DragPoint(id::Integer, x::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, size::Real = 4, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1080).
"""
function DragPoint(
    id::Integer,
    x::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    y::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    col::ImVec4,
    size::Real = 4,
    flags::Union{ImPlotDragToolFlags_,Integer} = 0,
    out_clicked = C_NULL,
    out_hovered = C_NULL,
    out_held = C_NULL,
)
    @ccall libcimgui.ImPlot_DragPoint(
        id::Cint,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        col::ImVec4,
        size::Cfloat,
        flags::ImPlotDragToolFlags,
        out_clicked::Ptr{Bool},
        out_hovered::Ptr{Bool},
        out_held::Ptr{Bool},
    )::Bool
end

"""
    DragLineX(id::Integer, x::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, thickness::Real = 1, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1082).
"""
function DragLineX(
    id::Integer,
    x::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    col::ImVec4,
    thickness::Real = 1,
    flags::Union{ImPlotDragToolFlags_,Integer} = 0,
    out_clicked = C_NULL,
    out_hovered = C_NULL,
    out_held = C_NULL,
)
    @ccall libcimgui.ImPlot_DragLineX(
        id::Cint,
        x::Ptr{Cdouble},
        col::ImVec4,
        thickness::Cfloat,
        flags::ImPlotDragToolFlags,
        out_clicked::Ptr{Bool},
        out_hovered::Ptr{Bool},
        out_held::Ptr{Bool},
    )::Bool
end

"""
    DragLineY(id::Integer, y::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, thickness::Real = 1, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1084).
"""
function DragLineY(
    id::Integer,
    y::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    col::ImVec4,
    thickness::Real = 1,
    flags::Union{ImPlotDragToolFlags_,Integer} = 0,
    out_clicked = C_NULL,
    out_hovered = C_NULL,
    out_held = C_NULL,
)
    @ccall libcimgui.ImPlot_DragLineY(
        id::Cint,
        y::Ptr{Cdouble},
        col::ImVec4,
        thickness::Cfloat,
        flags::ImPlotDragToolFlags,
        out_clicked::Ptr{Bool},
        out_hovered::Ptr{Bool},
        out_held::Ptr{Bool},
    )::Bool
end

"""
    DragRect(id::Integer, x1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, x2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1086).
"""
function DragRect(
    id::Integer,
    x1::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    y1::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    x2::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    y2::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    col::ImVec4,
    flags::Union{ImPlotDragToolFlags_,Integer} = 0,
    out_clicked = C_NULL,
    out_hovered = C_NULL,
    out_held = C_NULL,
)
    @ccall libcimgui.ImPlot_DragRect(
        id::Cint,
        x1::Ptr{Cdouble},
        y1::Ptr{Cdouble},
        x2::Ptr{Cdouble},
        y2::Ptr{Cdouble},
        col::ImVec4,
        flags::ImPlotDragToolFlags,
        out_clicked::Ptr{Bool},
        out_hovered::Ptr{Bool},
        out_held::Ptr{Bool},
    )::Bool
end

"""
    Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, clamp::Bool, round = false)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1089).
"""
function Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, clamp::Bool, round = false)
    @ccall libcimgui.ImPlot_Annotation_Bool(
        x::Cdouble,
        y::Cdouble,
        col::ImVec4,
        pix_offset::ImVec2,
        clamp::Bool,
        round::Bool,
    )::Cvoid
end

"""
    TagX(x::Real, col::ImVec4, round = false)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1094).
"""
function TagX(x::Real, col::ImVec4, round = false)
    @ccall libcimgui.ImPlot_TagX_Bool(x::Cdouble, col::ImVec4, round::Bool)::Cvoid
end

"""
    TagY(y::Real, col::ImVec4, round = false)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1099).
"""
function TagY(y::Real, col::ImVec4, round = false)
    @ccall libcimgui.ImPlot_TagY_Bool(y::Cdouble, col::ImVec4, round::Bool)::Cvoid
end

"""
    SetAxis(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1108).
"""
function SetAxis(axis::Union{ImAxis_,Integer})
    @ccall libcimgui.ImPlot_SetAxis(axis::ImAxis)::Cvoid
end

"""
    SetAxes(x_axis::Union{ImAxis_, Integer}, y_axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1109).
"""
function SetAxes(x_axis::Union{ImAxis_,Integer}, y_axis::Union{ImAxis_,Integer})
    @ccall libcimgui.ImPlot_SetAxes(x_axis::ImAxis, y_axis::ImAxis)::Cvoid
end

"""
    PixelsToPlot(pix::ImVec2, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1112).
"""
function PixelsToPlot(
    pix::ImVec2,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_PixelsToPlot_Vec2(pix::ImVec2, x_axis::ImAxis, y_axis::ImAxis)::ImPlotPoint
end

"""
    PixelsToPlot(x::Real, y::Real, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1113).
"""
function PixelsToPlot(
    x::Real,
    y::Real,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_PixelsToPlot_Float(x::Cfloat, y::Cfloat, x_axis::ImAxis, y_axis::ImAxis)::ImPlotPoint
end

"""
    PlotToPixels(plt::ImPlotPoint, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1116).
"""
function PlotToPixels(
    plt::ImPlotPoint,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_PlotToPixels_PlotPoint(plt::ImPlotPoint, x_axis::ImAxis, y_axis::ImAxis)::ImVec2
end

"""
    PlotToPixels(x::Real, y::Real, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1117).
"""
function PlotToPixels(
    x::Real,
    y::Real,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_PlotToPixels_double(x::Cdouble, y::Cdouble, x_axis::ImAxis, y_axis::ImAxis)::ImVec2
end

"""
    GetPlotPos()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1120).
"""
function GetPlotPos()
    @ccall libcimgui.ImPlot_GetPlotPos()::ImVec2
end

"""
    GetPlotSize()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1122).
"""
function GetPlotSize()
    @ccall libcimgui.ImPlot_GetPlotSize()::ImVec2
end

"""
    GetPlotMousePos(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1125).
"""
function GetPlotMousePos(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_GetPlotMousePos(x_axis::ImAxis, y_axis::ImAxis)::ImPlotPoint
end

"""
    GetPlotLimits(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1127).
"""
function GetPlotLimits(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_GetPlotLimits(x_axis::ImAxis, y_axis::ImAxis)::ImPlotRect
end

"""
    IsPlotHovered()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1130).
"""
function IsPlotHovered()
    @ccall libcimgui.ImPlot_IsPlotHovered()::Bool
end

"""
    IsAxisHovered(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1132).
"""
function IsAxisHovered(axis::Union{ImAxis_,Integer})
    @ccall libcimgui.ImPlot_IsAxisHovered(axis::ImAxis)::Bool
end

"""
    IsSubplotsHovered()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1134).
"""
function IsSubplotsHovered()
    @ccall libcimgui.ImPlot_IsSubplotsHovered()::Bool
end

"""
    IsPlotSelected()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1137).
"""
function IsPlotSelected()
    @ccall libcimgui.ImPlot_IsPlotSelected()::Bool
end

"""
    GetPlotSelection(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1139).
"""
function GetPlotSelection(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_GetPlotSelection(x_axis::ImAxis, y_axis::ImAxis)::ImPlotRect
end

"""
    CancelPlotSelection()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1141).
"""
function CancelPlotSelection()
    @ccall libcimgui.ImPlot_CancelPlotSelection()::Cvoid
end

"""
    HideNextItem(hidden = true, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1145).
"""
function HideNextItem(hidden = true, cond = ImPlotCond_Once)
    @ccall libcimgui.ImPlot_HideNextItem(hidden::Bool, cond::ImPlotCond)::Cvoid
end

"""
    BeginAlignedPlots(group_id, vertical = true)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1154).
"""
function BeginAlignedPlots(group_id, vertical = true)
    @ccall libcimgui.ImPlot_BeginAlignedPlots(group_id::Cstring, vertical::Bool)::Bool
end

"""
    EndAlignedPlots()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1156).
"""
function EndAlignedPlots()
    @ccall libcimgui.ImPlot_EndAlignedPlots()::Cvoid
end

"""
    BeginLegendPopup(label_id, mouse_button = 1)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1163).
"""
function BeginLegendPopup(label_id, mouse_button = 1)
    @ccall libcimgui.ImPlot_BeginLegendPopup(label_id::Cstring, mouse_button::ImGuiMouseButton)::Bool
end

"""
    EndLegendPopup()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1165).
"""
function EndLegendPopup()
    @ccall libcimgui.ImPlot_EndLegendPopup()::Cvoid
end

"""
    IsLegendEntryHovered(label_id)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1167).
"""
function IsLegendEntryHovered(label_id)
    @ccall libcimgui.ImPlot_IsLegendEntryHovered(label_id::Cstring)::Bool
end

"""
    BeginDragDropTargetPlot()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1174).
"""
function BeginDragDropTargetPlot()
    @ccall libcimgui.ImPlot_BeginDragDropTargetPlot()::Bool
end

"""
    BeginDragDropTargetAxis(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1176).
"""
function BeginDragDropTargetAxis(axis::Union{ImAxis_,Integer})
    @ccall libcimgui.ImPlot_BeginDragDropTargetAxis(axis::ImAxis)::Bool
end

"""
    BeginDragDropTargetLegend()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1178).
"""
function BeginDragDropTargetLegend()
    @ccall libcimgui.ImPlot_BeginDragDropTargetLegend()::Bool
end

"""
    EndDragDropTarget()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1180).
"""
function EndDragDropTarget()
    @ccall libcimgui.ImPlot_EndDragDropTarget()::Cvoid
end

"""
    BeginDragDropSourcePlot(flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1186).
"""
function BeginDragDropSourcePlot(flags = 0)
    @ccall libcimgui.ImPlot_BeginDragDropSourcePlot(flags::ImGuiDragDropFlags)::Bool
end

"""
    BeginDragDropSourceAxis(axis::Union{ImAxis_, Integer}, flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1188).
"""
function BeginDragDropSourceAxis(axis::Union{ImAxis_,Integer}, flags = 0)
    @ccall libcimgui.ImPlot_BeginDragDropSourceAxis(axis::ImAxis, flags::ImGuiDragDropFlags)::Bool
end

"""
    BeginDragDropSourceItem(label_id, flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1190).
"""
function BeginDragDropSourceItem(label_id, flags = 0)
    @ccall libcimgui.ImPlot_BeginDragDropSourceItem(label_id::Cstring, flags::ImGuiDragDropFlags)::Bool
end

"""
    EndDragDropSource()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1192).
"""
function EndDragDropSource()
    @ccall libcimgui.ImPlot_EndDragDropSource()::Cvoid
end

"""
    GetStyle()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1211).
"""
function GetStyle()
    @ccall libcimgui.ImPlot_GetStyle()::Ptr{ImPlotStyle}
end

"""
    StyleColorsAuto(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1214).
"""
function StyleColorsAuto(dst)
    @ccall libcimgui.ImPlot_StyleColorsAuto(dst::Ptr{ImPlotStyle})::Cvoid
end

"""
    StyleColorsClassic(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1216).
"""
function StyleColorsClassic(dst)
    @ccall libcimgui.ImPlot_StyleColorsClassic(dst::Ptr{ImPlotStyle})::Cvoid
end

"""
    StyleColorsDark(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1218).
"""
function StyleColorsDark(dst)
    @ccall libcimgui.ImPlot_StyleColorsDark(dst::Ptr{ImPlotStyle})::Cvoid
end

"""
    StyleColorsLight(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1220).
"""
function StyleColorsLight(dst)
    @ccall libcimgui.ImPlot_StyleColorsLight(dst::Ptr{ImPlotStyle})::Cvoid
end

"""
    PushStyleColor(idx::Union{ImPlotCol_, Integer}, col::Integer)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1227).
"""
function PushStyleColor(idx::Union{ImPlotCol_,Integer}, col::Integer)
    @ccall libcimgui.ImPlot_PushStyleColor_U32(idx::ImPlotCol, col::ImU32)::Cvoid
end

"""
    PushStyleColor(idx::Union{ImPlotCol_, Integer}, col::ImVec4)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1228).
"""
function PushStyleColor(idx::Union{ImPlotCol_,Integer}, col::ImVec4)
    @ccall libcimgui.ImPlot_PushStyleColor_Vec4(idx::ImPlotCol, col::ImVec4)::Cvoid
end

"""
    PopStyleColor(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1230).
"""
function PopStyleColor(count::Integer = 1)
    @ccall libcimgui.ImPlot_PopStyleColor(count::Cint)::Cvoid
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::Real)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1233).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::Real)
    @ccall libcimgui.ImPlot_PushStyleVar_Float(idx::ImPlotStyleVar, val::Cfloat)::Cvoid
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::Integer)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1235).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::Integer)
    @ccall libcimgui.ImPlot_PushStyleVar_Int(idx::ImPlotStyleVar, val::Cint)::Cvoid
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::ImVec2)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1237).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::ImVec2)
    @ccall libcimgui.ImPlot_PushStyleVar_Vec2(idx::ImPlotStyleVar, val::ImVec2)::Cvoid
end

"""
    PopStyleVar(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1239).
"""
function PopStyleVar(count::Integer = 1)
    @ccall libcimgui.ImPlot_PopStyleVar(count::Cint)::Cvoid
end

"""
    GetLastItemColor()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1242).
"""
function GetLastItemColor()
    @ccall libcimgui.ImPlot_GetLastItemColor()::ImVec4
end

"""
    GetStyleColorName(idx::Union{ImPlotCol_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1245).
"""
function GetStyleColorName(idx::Union{ImPlotCol_,Integer})
    @ccall libcimgui.ImPlot_GetStyleColorName(idx::ImPlotCol)::Cstring
end

"""
    GetMarkerName(idx::Union{ImPlotMarker_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1247).
"""
function GetMarkerName(idx::Union{ImPlotMarker_,Integer})
    @ccall libcimgui.ImPlot_GetMarkerName(idx::ImPlotMarker)::Cstring
end

"""
    NextMarker()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1250).
"""
function NextMarker()
    @ccall libcimgui.ImPlot_NextMarker()::ImPlotMarker
end

"""
    AddColormap(name, cols::Union{ImVec4, AbstractArray{ImVec4}}, size::Integer, qual = true)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1271).
"""
function AddColormap(name, cols::Union{ImVec4,AbstractArray{ImVec4}}, size::Integer, qual = true)
    @ccall libcimgui.ImPlot_AddColormap_Vec4Ptr(
        name::Cstring,
        cols::Ptr{ImVec4},
        size::Cint,
        qual::Bool,
    )::ImPlotColormap
end

"""
    AddColormap(name, cols::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, size::Integer, qual = true)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1272).
"""
function AddColormap(name, cols::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, size::Integer, qual = true)
    @ccall libcimgui.ImPlot_AddColormap_U32Ptr(name::Cstring, cols::Ptr{ImU32}, size::Cint, qual::Bool)::ImPlotColormap
end

"""
    GetColormapCount()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1275).
"""
function GetColormapCount()
    @ccall libcimgui.ImPlot_GetColormapCount()::Cint
end

"""
    GetColormapName(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1277).
"""
function GetColormapName(cmap::Union{ImPlotColormap_,Integer})
    @ccall libcimgui.ImPlot_GetColormapName(cmap::ImPlotColormap)::Cstring
end

"""
    GetColormapIndex(name)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1279).
"""
function GetColormapIndex(name)
    @ccall libcimgui.ImPlot_GetColormapIndex(name::Cstring)::ImPlotColormap
end

"""
    PushColormap(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1282).
"""
function PushColormap(cmap::Union{ImPlotColormap_,Integer})
    @ccall libcimgui.ImPlot_PushColormap_PlotColormap(cmap::ImPlotColormap)::Cvoid
end

"""
    PushColormap(name)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1284).
"""
function PushColormap(name)
    @ccall libcimgui.ImPlot_PushColormap_Str(name::Cstring)::Cvoid
end

"""
    PopColormap(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1286).
"""
function PopColormap(count::Integer = 1)
    @ccall libcimgui.ImPlot_PopColormap(count::Cint)::Cvoid
end

"""
    NextColormapColor()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1290).
"""
function NextColormapColor()
    @ccall libcimgui.ImPlot_NextColormapColor()::ImVec4
end

"""
    GetColormapSize(cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1296).
"""
function GetColormapSize(cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_GetColormapSize(cmap::ImPlotColormap)::Cint
end

"""
    GetColormapColor(idx::Integer, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1298).
"""
function GetColormapColor(idx::Integer, cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_GetColormapColor(idx::Cint, cmap::ImPlotColormap)::ImVec4
end

"""
    SampleColormap(t::Real, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1300).
"""
function SampleColormap(t::Real, cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_SampleColormap(t::Cfloat, cmap::ImPlotColormap)::ImVec4
end

"""
    ColormapScale(label, scale_min::Real, scale_max::Real, size::ImVec2 = ImVec2(0, 0), format = "%g", flags::Union{ImPlotColormapScaleFlags_, Integer} = 0, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1303).
"""
function ColormapScale(
    label,
    scale_min::Real,
    scale_max::Real,
    size::ImVec2 = ImVec2(0, 0),
    format = "%g",
    flags::Union{ImPlotColormapScaleFlags_,Integer} = 0,
    cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_ColormapScale(
        label::Cstring,
        scale_min::Cdouble,
        scale_max::Cdouble,
        size::ImVec2,
        format::Cstring,
        flags::ImPlotColormapScaleFlags,
        cmap::ImPlotColormap,
    )::Cvoid
end

"""
    ColormapSlider(label, t::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, out, format = "", cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1305).
"""
function ColormapSlider(
    label,
    t::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    out,
    format = "",
    cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO,
)
    @ccall libcimgui.ImPlot_ColormapSlider(
        label::Cstring,
        t::Ptr{Cfloat},
        out::Ptr{ImVec4},
        format::Cstring,
        cmap::ImPlotColormap,
    )::Bool
end

"""
    ColormapButton(label, size::ImVec2 = ImVec2(0, 0), cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1307).
"""
function ColormapButton(label, size::ImVec2 = ImVec2(0, 0), cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    @ccall libcimgui.ImPlot_ColormapButton(label::Cstring, size::ImVec2, cmap::ImPlotColormap)::Bool
end

"""
    BustColorCache(plot_title_id = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1316).
"""
function BustColorCache(plot_title_id = C_NULL)
    @ccall libcimgui.ImPlot_BustColorCache(plot_title_id::Cstring)::Cvoid
end

"""
    GetInputMap()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1323).
"""
function GetInputMap()
    @ccall libcimgui.ImPlot_GetInputMap()::Ptr{ImPlotInputMap}
end

"""
    MapInputDefault(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1326).
"""
function MapInputDefault(dst)
    @ccall libcimgui.ImPlot_MapInputDefault(dst::Ptr{ImPlotInputMap})::Cvoid
end

"""
    MapInputReverse(dst)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1328).
"""
function MapInputReverse(dst)
    @ccall libcimgui.ImPlot_MapInputReverse(dst::Ptr{ImPlotInputMap})::Cvoid
end

"""
    ItemIcon(col::ImVec4)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1335).
"""
function ItemIcon(col::ImVec4)
    @ccall libcimgui.ImPlot_ItemIcon_Vec4(col::ImVec4)::Cvoid
end

"""
    ItemIcon(col::Integer)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1336).
"""
function ItemIcon(col::Integer)
    @ccall libcimgui.ImPlot_ItemIcon_U32(col::ImU32)::Cvoid
end

"""
    ColormapIcon(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1337).
"""
function ColormapIcon(cmap::Union{ImPlotColormap_,Integer})
    @ccall libcimgui.ImPlot_ColormapIcon(cmap::ImPlotColormap)::Cvoid
end

"""
    GetPlotDrawList()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1340).
"""
function GetPlotDrawList()
    @ccall libcimgui.ImPlot_GetPlotDrawList()::Ptr{ImDrawList}
end

"""
    PushPlotClipRect(expand::Real = 0)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1342).
"""
function PushPlotClipRect(expand::Real = 0)
    @ccall libcimgui.ImPlot_PushPlotClipRect(expand::Cfloat)::Cvoid
end

"""
    PopPlotClipRect()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1344).
"""
function PopPlotClipRect()
    @ccall libcimgui.ImPlot_PopPlotClipRect()::Cvoid
end

"""
    ShowStyleSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1347).
"""
function ShowStyleSelector(label)
    @ccall libcimgui.ImPlot_ShowStyleSelector(label::Cstring)::Bool
end

"""
    ShowColormapSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1349).
"""
function ShowColormapSelector(label)
    @ccall libcimgui.ImPlot_ShowColormapSelector(label::Cstring)::Bool
end

"""
    ShowInputMapSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1351).
"""
function ShowInputMapSelector(label)
    @ccall libcimgui.ImPlot_ShowInputMapSelector(label::Cstring)::Bool
end

"""
    ShowStyleEditor(ref)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1353).
"""
function ShowStyleEditor(ref)
    @ccall libcimgui.ImPlot_ShowStyleEditor(ref::Ptr{ImPlotStyle})::Cvoid
end

"""
    ShowUserGuide()

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1355).
"""
function ShowUserGuide()
    @ccall libcimgui.ImPlot_ShowUserGuide()::Cvoid
end

"""
    ShowMetricsWindow(p_popen = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1357).
"""
function ShowMetricsWindow(p_popen = C_NULL)
    @ccall libcimgui.ImPlot_ShowMetricsWindow(p_popen::Ptr{Bool})::Cvoid
end

"""
    ShowDemoWindow(p_open = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot.h#L1364).
"""
function ShowDemoWindow(p_open = C_NULL)
    @ccall libcimgui.ImPlot_ShowDemoWindow(p_open::Ptr{Bool})::Cvoid
end

"""
    ImLog10(x::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L107).
"""
function ImLog10(x::Real)
    @ccall libcimgui.ImPlot_ImLog10_double(x::Cdouble)::Cdouble
end

"""
    ImSinh(x::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L109).
"""
function ImSinh(x::Real)
    @ccall libcimgui.ImPlot_ImSinh_double(x::Cdouble)::Cdouble
end

"""
    ImAsinh(x::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L111).
"""
function ImAsinh(x::Real)
    @ccall libcimgui.ImPlot_ImAsinh_double(x::Cdouble)::Cdouble
end

"""
    ImRemap(x::Real, x0::Real, x1::Real, y0::Real, y1::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L119).
"""
function ImRemap(x::Real, x0::Real, x1::Real, y0::Real, y1::Real)
    @ccall libcimgui.ImPlot_ImRemap_double(x::Cdouble, x0::Cdouble, x1::Cdouble, y0::Cdouble, y1::Cdouble)::Cdouble
end

"""
    ImRemap01(x::Real, x0::Real, x1::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L122).
"""
function ImRemap01(x::Real, x0::Real, x1::Real)
    @ccall libcimgui.ImPlot_ImRemap01_double(x::Cdouble, x0::Cdouble, x1::Cdouble)::Cdouble
end

"""
    ImPosMod(l::Integer, r::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L125).
"""
function ImPosMod(l::Integer, r::Integer)
    @ccall libcimgui.ImPlot_ImPosMod(l::Cint, r::Cint)::Cint
end

"""
    ImNan(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L127).
"""
function ImNan(val::Real)
    @ccall libcimgui.ImPlot_ImNan(val::Cdouble)::Bool
end

"""
    ImNanOrInf(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L129).
"""
function ImNanOrInf(val::Real)
    @ccall libcimgui.ImPlot_ImNanOrInf(val::Cdouble)::Bool
end

"""
    ImConstrainNan(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L131).
"""
function ImConstrainNan(val::Real)
    @ccall libcimgui.ImPlot_ImConstrainNan(val::Cdouble)::Cdouble
end

"""
    ImConstrainInf(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L133).
"""
function ImConstrainInf(val::Real)
    @ccall libcimgui.ImPlot_ImConstrainInf(val::Cdouble)::Cdouble
end

"""
    ImConstrainLog(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L135).
"""
function ImConstrainLog(val::Real)
    @ccall libcimgui.ImPlot_ImConstrainLog(val::Cdouble)::Cdouble
end

"""
    ImConstrainTime(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L137).
"""
function ImConstrainTime(val::Real)
    @ccall libcimgui.ImPlot_ImConstrainTime(val::Cdouble)::Cdouble
end

"""
    ImAlmostEqual(v1::Real, v2::Real, ulp::Integer = 2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L139).
"""
function ImAlmostEqual(v1::Real, v2::Real, ulp::Integer = 2)
    @ccall libcimgui.ImPlot_ImAlmostEqual(v1::Cdouble, v2::Cdouble, ulp::Cint)::Bool
end

"""
    ImMinArray(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_FloatPtr(values::Ptr{Cfloat}, count::Cint)::Cfloat
end

"""
    ImMinArray(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_doublePtr(values::Ptr{Cdouble}, count::Cint)::Cdouble
end

"""
    ImMinArray(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_S8Ptr(values::Ptr{ImS8}, count::Cint)::ImS8
end

"""
    ImMinArray(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_U8Ptr(values::Ptr{ImU8}, count::Cint)::ImU8
end

"""
    ImMinArray(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_S16Ptr(values::Ptr{ImS16}, count::Cint)::ImS16
end

"""
    ImMinArray(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_U16Ptr(values::Ptr{ImU16}, count::Cint)::ImU16
end

"""
    ImMinArray(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_S32Ptr(values::Ptr{ImS32}, count::Cint)::ImS32
end

"""
    ImMinArray(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_U32Ptr(values::Ptr{ImU32}, count::Cint)::ImU32
end

"""
    ImMinArray(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_S64Ptr(values::Ptr{ImS64}, count::Cint)::ImS64
end

"""
    ImMinArray(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L142).
"""
function ImMinArray(values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMinArray_U64Ptr(values::Ptr{ImU64}, count::Cint)::ImU64
end

"""
    ImMaxArray(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_FloatPtr(values::Ptr{Cfloat}, count::Cint)::Cfloat
end

"""
    ImMaxArray(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_doublePtr(values::Ptr{Cdouble}, count::Cint)::Cdouble
end

"""
    ImMaxArray(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_S8Ptr(values::Ptr{ImS8}, count::Cint)::ImS8
end

"""
    ImMaxArray(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_U8Ptr(values::Ptr{ImU8}, count::Cint)::ImU8
end

"""
    ImMaxArray(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_S16Ptr(values::Ptr{ImS16}, count::Cint)::ImS16
end

"""
    ImMaxArray(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_U16Ptr(values::Ptr{ImU16}, count::Cint)::ImU16
end

"""
    ImMaxArray(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_S32Ptr(values::Ptr{ImS32}, count::Cint)::ImS32
end

"""
    ImMaxArray(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_U32Ptr(values::Ptr{ImU32}, count::Cint)::ImU32
end

"""
    ImMaxArray(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_S64Ptr(values::Ptr{ImS64}, count::Cint)::ImS64
end

"""
    ImMaxArray(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L145).
"""
function ImMaxArray(values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMaxArray_U64Ptr(values::Ptr{ImU64}, count::Cint)::ImU64
end

"""
    ImMinMaxArray(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, min_out::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, max_out::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    min_out::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    max_out::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_FloatPtr(
        values::Ptr{Cfloat},
        count::Cint,
        min_out::Ptr{Cfloat},
        max_out::Ptr{Cfloat},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, min_out::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, max_out::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    min_out::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    max_out::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_doublePtr(
        values::Ptr{Cdouble},
        count::Cint,
        min_out::Ptr{Cdouble},
        max_out::Ptr{Cdouble},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, min_out::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, max_out::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    min_out::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    max_out::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_S8Ptr(
        values::Ptr{ImS8},
        count::Cint,
        min_out::Ptr{ImS8},
        max_out::Ptr{ImS8},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, min_out::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, max_out::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    min_out::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    max_out::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_U8Ptr(
        values::Ptr{ImU8},
        count::Cint,
        min_out::Ptr{ImU8},
        max_out::Ptr{ImU8},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, min_out::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, max_out::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    min_out::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    max_out::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_S16Ptr(
        values::Ptr{ImS16},
        count::Cint,
        min_out::Ptr{ImS16},
        max_out::Ptr{ImS16},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, min_out::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, max_out::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    min_out::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    max_out::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_U16Ptr(
        values::Ptr{ImU16},
        count::Cint,
        min_out::Ptr{ImU16},
        max_out::Ptr{ImU16},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, min_out::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, max_out::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    min_out::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    max_out::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_S32Ptr(
        values::Ptr{ImS32},
        count::Cint,
        min_out::Ptr{ImS32},
        max_out::Ptr{ImS32},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, min_out::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, max_out::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    min_out::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    max_out::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_U32Ptr(
        values::Ptr{ImU32},
        count::Cint,
        min_out::Ptr{ImU32},
        max_out::Ptr{ImU32},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, min_out::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, max_out::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    min_out::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    max_out::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_S64Ptr(
        values::Ptr{ImS64},
        count::Cint,
        min_out::Ptr{ImS64},
        max_out::Ptr{ImS64},
    )::Cvoid
end

"""
    ImMinMaxArray(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, min_out::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, max_out::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L148).
"""
function ImMinMaxArray(
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    min_out::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    max_out::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
)
    @ccall libcimgui.ImPlot_ImMinMaxArray_U64Ptr(
        values::Ptr{ImU64},
        count::Cint,
        min_out::Ptr{ImU64},
        max_out::Ptr{ImU64},
    )::Cvoid
end

"""
    ImSum(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_FloatPtr(values::Ptr{Cfloat}, count::Cint)::Cfloat
end

"""
    ImSum(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_doublePtr(values::Ptr{Cdouble}, count::Cint)::Cdouble
end

"""
    ImSum(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_S8Ptr(values::Ptr{ImS8}, count::Cint)::ImS8
end

"""
    ImSum(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_U8Ptr(values::Ptr{ImU8}, count::Cint)::ImU8
end

"""
    ImSum(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_S16Ptr(values::Ptr{ImS16}, count::Cint)::ImS16
end

"""
    ImSum(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_U16Ptr(values::Ptr{ImU16}, count::Cint)::ImU16
end

"""
    ImSum(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_S32Ptr(values::Ptr{ImS32}, count::Cint)::ImS32
end

"""
    ImSum(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_U32Ptr(values::Ptr{ImU32}, count::Cint)::ImU32
end

"""
    ImSum(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_S64Ptr(values::Ptr{ImS64}, count::Cint)::ImS64
end

"""
    ImSum(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L158).
"""
function ImSum(values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImSum_U64Ptr(values::Ptr{ImU64}, count::Cint)::ImU64
end

"""
    ImMean(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_FloatPtr(values::Ptr{Cfloat}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_doublePtr(values::Ptr{Cdouble}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_S8Ptr(values::Ptr{ImS8}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_U8Ptr(values::Ptr{ImU8}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_S16Ptr(values::Ptr{ImS16}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_U16Ptr(values::Ptr{ImU16}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_S32Ptr(values::Ptr{ImS32}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_U32Ptr(values::Ptr{ImU32}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_S64Ptr(values::Ptr{ImS64}, count::Cint)::Cdouble
end

"""
    ImMean(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L166).
"""
function ImMean(values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImMean_U64Ptr(values::Ptr{ImU64}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_FloatPtr(values::Ptr{Cfloat}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_doublePtr(values::Ptr{Cdouble}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_S8Ptr(values::Ptr{ImS8}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_U8Ptr(values::Ptr{ImU8}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_S16Ptr(values::Ptr{ImS16}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_U16Ptr(values::Ptr{ImU16}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_S32Ptr(values::Ptr{ImS32}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_U32Ptr(values::Ptr{ImU32}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_S64Ptr(values::Ptr{ImS64}, count::Cint)::Cdouble
end

"""
    ImStdDev(values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L175).
"""
function ImStdDev(values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}}, count::Integer)
    @ccall libcimgui.ImPlot_ImStdDev_U64Ptr(values::Ptr{ImU64}, count::Cint)::Cdouble
end

"""
    ImMixU32(a::Integer, b::Integer, s::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L186).
"""
function ImMixU32(a::Integer, b::Integer, s::Integer)
    @ccall libcimgui.ImPlot_ImMixU32(a::ImU32, b::ImU32, s::ImU32)::ImU32
end

"""
    ImLerpU32(colors::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, size::Integer, t::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L208).
"""
function ImLerpU32(colors::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, size::Integer, t::Real)
    @ccall libcimgui.ImPlot_ImLerpU32(colors::Ptr{ImU32}, size::Cint, t::Cfloat)::ImU32
end

"""
    ImAlphaU32(col::Integer, alpha::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L221).
"""
function ImAlphaU32(col::Integer, alpha::Real)
    @ccall libcimgui.ImPlot_ImAlphaU32(col::ImU32, alpha::Cfloat)::ImU32
end

"""
    ImOverlaps(min_a::Real, max_a::Real, min_b::Real, max_b::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L226).
"""
function ImOverlaps(min_a::Real, max_a::Real, min_b::Real, max_b::Real)
    @ccall libcimgui.ImPlot_ImOverlaps_double(min_a::Cdouble, max_a::Cdouble, min_b::Cdouble, max_b::Cdouble)::Bool
end

"""
    RollOver(self::Union{ImPlotTime, Ptr{ImPlotTime}, Ref{ImPlotTime}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L309).
"""
function RollOver(self::Union{ImPlotTime,Ptr{ImPlotTime},Ref{ImPlotTime}})
    @ccall libcimgui.ImPlotTime_RollOver(self::Ptr{ImPlotTime})::Cvoid
end

"""
    ToDouble(self::Union{ImPlotTime, Ptr{ImPlotTime}, Ref{ImPlotTime}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L310).
"""
function ToDouble(self::Union{ImPlotTime,Ptr{ImPlotTime},Ref{ImPlotTime}})
    @ccall libcimgui.ImPlotTime_ToDouble(self::Ptr{ImPlotTime})::Cdouble
end

"""
    FromDouble(t::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L311).
"""
function FromDouble(t::Real)
    @ccall libcimgui.ImPlotTime_FromDouble(t::Cdouble)::ImPlotTime
end

"""
    ImPlotColormapData()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L343).
"""
function ImPlotColormapData()
    @ccall libcimgui.ImPlotColormapData_ImPlotColormapData()::Ptr{ImPlotColormapData}
end

function Base.finalizer(self::Union{Ptr{ImPlotColormapData},ImPlotColormapData})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotColormapData_destroy(self::Ptr{ImPlotColormapData})::Cvoid)
end

"""
    Append(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, name, keys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, qual::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L345).
"""
function Append(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    name,
    keys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    qual::Bool,
)
    @ccall libcimgui.ImPlotColormapData_Append(
        self::Ptr{ImPlotColormapData},
        name::Cstring,
        keys::Ptr{ImU32},
        count::Cint,
        qual::Bool,
    )::Cint
end

"""
    _AppendTable(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L363).
"""
function _AppendTable(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData__AppendTable(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Cvoid
end

"""
    RebuildTables(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L402).
"""
function RebuildTables(self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}})
    @ccall libcimgui.ImPlotColormapData_RebuildTables(self::Ptr{ImPlotColormapData})::Cvoid
end

"""
    IsQual(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L410).
"""
function IsQual(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_IsQual(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Bool
end

"""
    GetName(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L411).
"""
function GetName(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_GetName(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Cstring
end

"""
    GetIndex(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, name)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L412).
"""
function GetIndex(self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}}, name)
    @ccall libcimgui.ImPlotColormapData_GetIndex(self::Ptr{ImPlotColormapData}, name::Cstring)::ImPlotColormap
end

"""
    GetKeys(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L414).
"""
function GetKeys(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_GetKeys(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Ptr{ImU32}
end

"""
    GetKeyCount(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L415).
"""
function GetKeyCount(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_GetKeyCount(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Cint
end

"""
    GetKeyColor(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer}, idx::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L416).
"""
function GetKeyColor(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
    idx::Integer,
)
    @ccall libcimgui.ImPlotColormapData_GetKeyColor(
        self::Ptr{ImPlotColormapData},
        cmap::ImPlotColormap,
        idx::Cint,
    )::ImU32
end

"""
    SetKeyColor(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer}, idx::Integer, value::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L417).
"""
function SetKeyColor(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
    idx::Integer,
    value::Integer,
)
    @ccall libcimgui.ImPlotColormapData_SetKeyColor(
        self::Ptr{ImPlotColormapData},
        cmap::ImPlotColormap,
        idx::Cint,
        value::ImU32,
    )::Cvoid
end

"""
    GetTable(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L419).
"""
function GetTable(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_GetTable(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Ptr{ImU32}
end

"""
    GetTableSize(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L420).
"""
function GetTableSize(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
)
    @ccall libcimgui.ImPlotColormapData_GetTableSize(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap)::Cint
end

"""
    GetTableColor(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer}, idx::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L421).
"""
function GetTableColor(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
    idx::Integer,
)
    @ccall libcimgui.ImPlotColormapData_GetTableColor(
        self::Ptr{ImPlotColormapData},
        cmap::ImPlotColormap,
        idx::Cint,
    )::ImU32
end

"""
    LerpTable(self::Union{ImPlotColormapData, Ptr{ImPlotColormapData}, Ref{ImPlotColormapData}}, cmap::Union{ImPlotColormap_, Integer}, t::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L423).
"""
function LerpTable(
    self::Union{ImPlotColormapData,Ptr{ImPlotColormapData},Ref{ImPlotColormapData}},
    cmap::Union{ImPlotColormap_,Integer},
    t::Real,
)
    @ccall libcimgui.ImPlotColormapData_LerpTable(self::Ptr{ImPlotColormapData}, cmap::ImPlotColormap, t::Cfloat)::ImU32
end

"""
    ImPlotAnnotation()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L448).
"""
function ImPlotAnnotation()
    @ccall libcimgui.ImPlotAnnotation_ImPlotAnnotation()::Ptr{ImPlotAnnotation}
end

function Base.finalizer(self::Union{Ptr{ImPlotAnnotation},ImPlotAnnotation})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotAnnotation_destroy(self::Ptr{ImPlotAnnotation})::Cvoid)
end

"""
    ImPlotAnnotationCollection()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L462).
"""
function ImPlotAnnotationCollection()
    @ccall libcimgui.ImPlotAnnotationCollection_ImPlotAnnotationCollection()::Ptr{ImPlotAnnotationCollection}
end

function Base.finalizer(self::Union{Ptr{ImPlotAnnotationCollection},ImPlotAnnotationCollection})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotAnnotationCollection_destroy(self::Ptr{ImPlotAnnotationCollection})::Cvoid)
end

"""
    GetText(self::Union{ImPlotAnnotationCollection, Ptr{ImPlotAnnotationCollection}, Ref{ImPlotAnnotationCollection}}, idx::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L484).
"""
function GetText(
    self::Union{ImPlotAnnotationCollection,Ptr{ImPlotAnnotationCollection},Ref{ImPlotAnnotationCollection}},
    idx::Integer,
)
    @ccall libcimgui.ImPlotAnnotationCollection_GetText(self::Ptr{ImPlotAnnotationCollection}, idx::Cint)::Cstring
end

"""
    Reset(self::Union{ImPlotAnnotationCollection, Ptr{ImPlotAnnotationCollection}, Ref{ImPlotAnnotationCollection}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L488).
"""
function Reset(self::Union{ImPlotAnnotationCollection,Ptr{ImPlotAnnotationCollection},Ref{ImPlotAnnotationCollection}})
    @ccall libcimgui.ImPlotAnnotationCollection_Reset(self::Ptr{ImPlotAnnotationCollection})::Cvoid
end

"""
    ImPlotTag()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L502).
"""
function ImPlotTag()
    @ccall libcimgui.ImPlotTag_ImPlotTag()::Ptr{ImPlotTag}
end

function Base.finalizer(self::Union{Ptr{ImPlotTag},ImPlotTag})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotTag_destroy(self::Ptr{ImPlotTag})::Cvoid)
end

"""
    ImPlotTagCollection()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L517).
"""
function ImPlotTagCollection()
    @ccall libcimgui.ImPlotTagCollection_ImPlotTagCollection()::Ptr{ImPlotTagCollection}
end

function Base.finalizer(self::Union{Ptr{ImPlotTagCollection},ImPlotTagCollection})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotTagCollection_destroy(self::Ptr{ImPlotTagCollection})::Cvoid)
end

"""
    GetText(self::Union{ImPlotTagCollection, Ptr{ImPlotTagCollection}, Ref{ImPlotTagCollection}}, idx::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L540).
"""
function GetText(self::Union{ImPlotTagCollection,Ptr{ImPlotTagCollection},Ref{ImPlotTagCollection}}, idx::Integer)
    @ccall libcimgui.ImPlotTagCollection_GetText(self::Ptr{ImPlotTagCollection}, idx::Cint)::Cstring
end

"""
    Reset(self::Union{ImPlotTagCollection, Ptr{ImPlotTagCollection}, Ref{ImPlotTagCollection}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L544).
"""
function Reset(self::Union{ImPlotTagCollection,Ptr{ImPlotTagCollection},Ref{ImPlotTagCollection}})
    @ccall libcimgui.ImPlotTagCollection_Reset(self::Ptr{ImPlotTagCollection})::Cvoid
end

"""
    ImPlotTick()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L563).
"""
function ImPlotTick()
    @ccall libcimgui.ImPlotTick_ImPlotTick_Nil()::Ptr{ImPlotTick}
end

function Base.finalizer(self::Union{Ptr{ImPlotTick},ImPlotTick})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotTick_destroy(self::Ptr{ImPlotTick})::Cvoid)
end

"""
    ImPlotTick(value::Cdouble, major::Bool, level::Cint, show_label::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L574).
"""
function ImPlotTick(value::Cdouble, major::Bool, level::Cint, show_label::Bool)
    @ccall libcimgui.ImPlotTick_ImPlotTick_double(
        value::Cdouble,
        major::Bool,
        level::Cint,
        show_label::Bool,
    )::Ptr{ImPlotTick}
end

"""
    ImPlotTicker()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L592).
"""
function ImPlotTicker()
    @ccall libcimgui.ImPlotTicker_ImPlotTicker()::Ptr{ImPlotTicker}
end

function Base.finalizer(self::Union{Ptr{ImPlotTicker},ImPlotTicker})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotTicker_destroy(self::Ptr{ImPlotTicker})::Cvoid)
end

"""
    AddTick(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, value::Real, major::Bool, level::Integer, show_label::Bool, label)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L596).
"""
function AddTick(
    self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}},
    value::Real,
    major::Bool,
    level::Integer,
    show_label::Bool,
    label,
)
    @ccall libcimgui.ImPlotTicker_AddTick_doubleStr(
        self::Ptr{ImPlotTicker},
        value::Cdouble,
        major::Bool,
        level::Cint,
        show_label::Bool,
        label::Cstring,
    )::Ptr{ImPlotTick}
end

"""
    AddTick(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, value::Real, major::Bool, level::Integer, show_label::Bool, formatter::ImPlotFormatter, data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L606).
"""
function AddTick(
    self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}},
    value::Real,
    major::Bool,
    level::Integer,
    show_label::Bool,
    formatter::ImPlotFormatter,
    data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlotTicker_AddTick_doublePlotFormatter(
        self::Ptr{ImPlotTicker},
        value::Cdouble,
        major::Bool,
        level::Cint,
        show_label::Bool,
        formatter::ImPlotFormatter,
        data::Ptr{Cvoid},
    )::Ptr{ImPlotTick}
end

"""
    AddTick(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, tick::ImPlotTick)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L618).
"""
function AddTick(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}}, tick::ImPlotTick)
    @ccall libcimgui.ImPlotTicker_AddTick_PlotTick(self::Ptr{ImPlotTicker}, tick::ImPlotTick)::Ptr{ImPlotTick}
end

"""
    GetText(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, idx::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L628).
"""
function GetText(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}}, idx::Integer)
    @ccall libcimgui.ImPlotTicker_GetText_Int(self::Ptr{ImPlotTicker}, idx::Cint)::Cstring
end

"""
    GetText(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, tick::ImPlotTick)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L632).
"""
function GetText(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}}, tick::ImPlotTick)
    @ccall libcimgui.ImPlotTicker_GetText_PlotTick(self::Ptr{ImPlotTicker}, tick::ImPlotTick)::Cstring
end

"""
    OverrideSizeLate(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}}, size::ImVec2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L636).
"""
function OverrideSizeLate(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}}, size::ImVec2)
    @ccall libcimgui.ImPlotTicker_OverrideSizeLate(self::Ptr{ImPlotTicker}, size::ImVec2)::Cvoid
end

"""
    Reset(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L641).
"""
function Reset(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}})
    @ccall libcimgui.ImPlotTicker_Reset(self::Ptr{ImPlotTicker})::Cvoid
end

"""
    TickCount(self::Union{ImPlotTicker, Ptr{ImPlotTicker}, Ref{ImPlotTicker}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L649).
"""
function TickCount(self::Union{ImPlotTicker,Ptr{ImPlotTicker},Ref{ImPlotTicker}})
    @ccall libcimgui.ImPlotTicker_TickCount(self::Ptr{ImPlotTicker})::Cint
end

"""
    ImPlotAxis()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L701).
"""
function ImPlotAxis()
    @ccall libcimgui.ImPlotAxis_ImPlotAxis()::Ptr{ImPlotAxis}
end

function Base.finalizer(self::Union{Ptr{ImPlotAxis},ImPlotAxis})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotAxis_destroy(self::Ptr{ImPlotAxis})::Cvoid)
end

"""
    Reset(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L728).
"""
function Reset(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_Reset(self::Ptr{ImPlotAxis})::Cvoid
end

"""
    SetMin(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, _min::Real, force = false)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L748).
"""
function SetMin(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, _min::Real, force = false)
    @ccall libcimgui.ImPlotAxis_SetMin(self::Ptr{ImPlotAxis}, _min::Cdouble, force::Bool)::Bool
end

"""
    SetMax(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, _max::Real, force = false)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L767).
"""
function SetMax(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, _max::Real, force = false)
    @ccall libcimgui.ImPlotAxis_SetMax(self::Ptr{ImPlotAxis}, _max::Cdouble, force::Bool)::Bool
end

"""
    SetRange(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, v1::Real, v2::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L786).
"""
function SetRange(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, v1::Real, v2::Real)
    @ccall libcimgui.ImPlotAxis_SetRange_double(self::Ptr{ImPlotAxis}, v1::Cdouble, v2::Cdouble)::Cvoid
end

"""
    SetRange(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, range::ImPlotRange)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L795).
"""
function SetRange(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, range::ImPlotRange)
    @ccall libcimgui.ImPlotAxis_SetRange_PlotRange(self::Ptr{ImPlotAxis}, range::ImPlotRange)::Cvoid
end

"""
    SetAspect(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, unit_per_pix::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L799).
"""
function SetAspect(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, unit_per_pix::Real)
    @ccall libcimgui.ImPlotAxis_SetAspect(self::Ptr{ImPlotAxis}, unit_per_pix::Cdouble)::Cvoid
end

"""
    PixelSize(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L812).
"""
function PixelSize(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_PixelSize(self::Ptr{ImPlotAxis})::Cfloat
end

"""
    GetAspect(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L814).
"""
function GetAspect(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_GetAspect(self::Ptr{ImPlotAxis})::Cdouble
end

"""
    Constrain(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L816).
"""
function Constrain(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_Constrain(self::Ptr{ImPlotAxis})::Cvoid
end

"""
    UpdateTransformCache(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L838).
"""
function UpdateTransformCache(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_UpdateTransformCache(self::Ptr{ImPlotAxis})::Cvoid
end

"""
    PlotToPixels(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, plt::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L850).
"""
function PlotToPixels(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, plt::Real)
    @ccall libcimgui.ImPlotAxis_PlotToPixels(self::Ptr{ImPlotAxis}, plt::Cdouble)::Cfloat
end

"""
    PixelsToPlot(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, pix::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L860).
"""
function PixelsToPlot(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, pix::Real)
    @ccall libcimgui.ImPlotAxis_PixelsToPlot(self::Ptr{ImPlotAxis}, pix::Cfloat)::Cdouble
end

"""
    ExtendFit(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, v::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L870).
"""
function ExtendFit(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, v::Real)
    @ccall libcimgui.ImPlotAxis_ExtendFit(self::Ptr{ImPlotAxis}, v::Cdouble)::Cvoid
end

"""
    ExtendFitWith(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, alt, v::Real, v_alt::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L877).
"""
function ExtendFitWith(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, alt, v::Real, v_alt::Real)
    @ccall libcimgui.ImPlotAxis_ExtendFitWith(
        self::Ptr{ImPlotAxis},
        alt::Ptr{ImPlotAxis},
        v::Cdouble,
        v_alt::Cdouble,
    )::Cvoid
end

"""
    ApplyFit(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, padding::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L886).
"""
function ApplyFit(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, padding::Real)
    @ccall libcimgui.ImPlotAxis_ApplyFit(self::Ptr{ImPlotAxis}, padding::Cfloat)::Cvoid
end

"""
    HasLabel(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L902).
"""
function HasLabel(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_HasLabel(self::Ptr{ImPlotAxis})::Bool
end

"""
    HasGridLines(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L903).
"""
function HasGridLines(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_HasGridLines(self::Ptr{ImPlotAxis})::Bool
end

"""
    HasTickLabels(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L904).
"""
function HasTickLabels(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_HasTickLabels(self::Ptr{ImPlotAxis})::Bool
end

"""
    HasTickMarks(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L905).
"""
function HasTickMarks(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_HasTickMarks(self::Ptr{ImPlotAxis})::Bool
end

"""
    WillRender(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L906).
"""
function WillRender(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_WillRender(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsOpposite(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L907).
"""
function IsOpposite(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsOpposite(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsInverted(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L908).
"""
function IsInverted(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsInverted(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsForeground(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L909).
"""
function IsForeground(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsForeground(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsAutoFitting(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L910).
"""
function IsAutoFitting(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsAutoFitting(self::Ptr{ImPlotAxis})::Bool
end

"""
    CanInitFit(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L911).
"""
function CanInitFit(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_CanInitFit(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsRangeLocked(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L912).
"""
function IsRangeLocked(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsRangeLocked(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsLockedMin(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L913).
"""
function IsLockedMin(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsLockedMin(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsLockedMax(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L914).
"""
function IsLockedMax(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsLockedMax(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsLocked(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L915).
"""
function IsLocked(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsLocked(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsInputLockedMin(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L916).
"""
function IsInputLockedMin(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsInputLockedMin(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsInputLockedMax(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L917).
"""
function IsInputLockedMax(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsInputLockedMax(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsInputLocked(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L918).
"""
function IsInputLocked(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_IsInputLocked(self::Ptr{ImPlotAxis})::Bool
end

"""
    HasMenus(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L919).
"""
function HasMenus(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_HasMenus(self::Ptr{ImPlotAxis})::Bool
end

"""
    IsPanLocked(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}}, increasing::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L921).
"""
function IsPanLocked(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}}, increasing::Bool)
    @ccall libcimgui.ImPlotAxis_IsPanLocked(self::Ptr{ImPlotAxis}, increasing::Bool)::Bool
end

"""
    PushLinks(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L935).
"""
function PushLinks(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_PushLinks(self::Ptr{ImPlotAxis})::Cvoid
end

"""
    PullLinks(self::Union{ImPlotAxis, Ptr{ImPlotAxis}, Ref{ImPlotAxis}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L940).
"""
function PullLinks(self::Union{ImPlotAxis,Ptr{ImPlotAxis},Ref{ImPlotAxis}})
    @ccall libcimgui.ImPlotAxis_PullLinks(self::Ptr{ImPlotAxis})::Cvoid
end

"""
    ImPlotAlignmentData()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L954).
"""
function ImPlotAlignmentData()
    @ccall libcimgui.ImPlotAlignmentData_ImPlotAlignmentData()::Ptr{ImPlotAlignmentData}
end

function Base.finalizer(self::Union{Ptr{ImPlotAlignmentData},ImPlotAlignmentData})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotAlignmentData_destroy(self::Ptr{ImPlotAlignmentData})::Cvoid)
end

"""
    Begin(self::Union{ImPlotAlignmentData, Ptr{ImPlotAlignmentData}, Ref{ImPlotAlignmentData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L958).
"""
function Begin(self::Union{ImPlotAlignmentData,Ptr{ImPlotAlignmentData},Ref{ImPlotAlignmentData}})
    @ccall libcimgui.ImPlotAlignmentData_Begin(self::Ptr{ImPlotAlignmentData})::Cvoid
end

"""
    Update(self::Union{ImPlotAlignmentData, Ptr{ImPlotAlignmentData}, Ref{ImPlotAlignmentData}}, pad_a::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, pad_b::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, delta_a::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, delta_b::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L959).
"""
function Update(
    self::Union{ImPlotAlignmentData,Ptr{ImPlotAlignmentData},Ref{ImPlotAlignmentData}},
    pad_a::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    pad_b::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    delta_a::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    delta_b::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
)
    @ccall libcimgui.ImPlotAlignmentData_Update(
        self::Ptr{ImPlotAlignmentData},
        pad_a::Ptr{Cfloat},
        pad_b::Ptr{Cfloat},
        delta_a::Ptr{Cfloat},
        delta_b::Ptr{Cfloat},
    )::Cvoid
end

"""
    End(self::Union{ImPlotAlignmentData, Ptr{ImPlotAlignmentData}, Ref{ImPlotAlignmentData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L966).
"""
function End(self::Union{ImPlotAlignmentData,Ptr{ImPlotAlignmentData},Ref{ImPlotAlignmentData}})
    @ccall libcimgui.ImPlotAlignmentData_End(self::Ptr{ImPlotAlignmentData})::Cvoid
end

"""
    Reset(self::Union{ImPlotAlignmentData, Ptr{ImPlotAlignmentData}, Ref{ImPlotAlignmentData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L967).
"""
function Reset(self::Union{ImPlotAlignmentData,Ptr{ImPlotAlignmentData},Ref{ImPlotAlignmentData}})
    @ccall libcimgui.ImPlotAlignmentData_Reset(self::Ptr{ImPlotAlignmentData})::Cvoid
end

"""
    ImPlotItem()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L982).
"""
function ImPlotItem()
    @ccall libcimgui.ImPlotItem_ImPlotItem()::Ptr{ImPlotItem}
end

function Base.finalizer(self::Union{Ptr{ImPlotItem},ImPlotItem})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotItem_destroy(self::Ptr{ImPlotItem})::Cvoid)
end

"""
    ImPlotLegend()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1011).
"""
function ImPlotLegend()
    @ccall libcimgui.ImPlotLegend_ImPlotLegend()::Ptr{ImPlotLegend}
end

function Base.finalizer(self::Union{Ptr{ImPlotLegend},ImPlotLegend})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotLegend_destroy(self::Ptr{ImPlotLegend})::Cvoid)
end

"""
    Reset(self::Union{ImPlotLegend, Ptr{ImPlotLegend}, Ref{ImPlotLegend}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1019).
"""
function Reset(self::Union{ImPlotLegend,Ptr{ImPlotLegend},Ref{ImPlotLegend}})
    @ccall libcimgui.ImPlotLegend_Reset(self::Ptr{ImPlotLegend})::Cvoid
end

"""
    ImPlotItemGroup()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1031).
"""
function ImPlotItemGroup()
    @ccall libcimgui.ImPlotItemGroup_ImPlotItemGroup()::Ptr{ImPlotItemGroup}
end

function Base.finalizer(self::Union{Ptr{ImPlotItemGroup},ImPlotItemGroup})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotItemGroup_destroy(self::Ptr{ImPlotItemGroup})::Cvoid)
end

"""
    GetItemCount(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1033).
"""
function GetItemCount(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}})
    @ccall libcimgui.ImPlotItemGroup_GetItemCount(self::Ptr{ImPlotItemGroup})::Cint
end

"""
    GetItemID(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, label_id)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1034).
"""
function GetItemID(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, label_id)
    @ccall libcimgui.ImPlotItemGroup_GetItemID(self::Ptr{ImPlotItemGroup}, label_id::Cstring)::ImGuiID
end

"""
    GetItem(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, id::ImGuiID)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1035).
"""
function GetItem(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, id::ImGuiID)
    @ccall libcimgui.ImPlotItemGroup_GetItem_ID(self::Ptr{ImPlotItemGroup}, id::ImGuiID)::Ptr{ImPlotItem}
end

"""
    GetItem(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, label_id)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1036).
"""
function GetItem(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, label_id)
    @ccall libcimgui.ImPlotItemGroup_GetItem_Str(self::Ptr{ImPlotItemGroup}, label_id::Cstring)::Ptr{ImPlotItem}
end

"""
    GetOrAddItem(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, id::ImGuiID)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1037).
"""
function GetOrAddItem(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, id::ImGuiID)
    @ccall libcimgui.ImPlotItemGroup_GetOrAddItem(self::Ptr{ImPlotItemGroup}, id::ImGuiID)::Ptr{ImPlotItem}
end

"""
    GetItemByIndex(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, i::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1038).
"""
function GetItemByIndex(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, i::Integer)
    @ccall libcimgui.ImPlotItemGroup_GetItemByIndex(self::Ptr{ImPlotItemGroup}, i::Cint)::Ptr{ImPlotItem}
end

"""
    GetItemIndex(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, item)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1039).
"""
function GetItemIndex(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, item)
    @ccall libcimgui.ImPlotItemGroup_GetItemIndex(self::Ptr{ImPlotItemGroup}, item::Ptr{ImPlotItem})::Cint
end

"""
    GetLegendCount(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1040).
"""
function GetLegendCount(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}})
    @ccall libcimgui.ImPlotItemGroup_GetLegendCount(self::Ptr{ImPlotItemGroup})::Cint
end

"""
    GetLegendItem(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, i::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1041).
"""
function GetLegendItem(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, i::Integer)
    @ccall libcimgui.ImPlotItemGroup_GetLegendItem(self::Ptr{ImPlotItemGroup}, i::Cint)::Ptr{ImPlotItem}
end

"""
    GetLegendLabel(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}}, i::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1042).
"""
function GetLegendLabel(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}}, i::Integer)
    @ccall libcimgui.ImPlotItemGroup_GetLegendLabel(self::Ptr{ImPlotItemGroup}, i::Cint)::Cstring
end

"""
    Reset(self::Union{ImPlotItemGroup, Ptr{ImPlotItemGroup}, Ref{ImPlotItemGroup}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1043).
"""
function Reset(self::Union{ImPlotItemGroup,Ptr{ImPlotItemGroup},Ref{ImPlotItemGroup}})
    @ccall libcimgui.ImPlotItemGroup_Reset(self::Ptr{ImPlotItemGroup})::Cvoid
end

"""
    ImPlotPlot()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1076).
"""
function ImPlotPlot()
    @ccall libcimgui.ImPlotPlot_ImPlotPlot()::Ptr{ImPlotPlot}
end

function Base.finalizer(self::Union{Ptr{ImPlotPlot},ImPlotPlot})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotPlot_destroy(self::Ptr{ImPlotPlot})::Cvoid)
end

"""
    IsInputLocked(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1093).
"""
function IsInputLocked(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_IsInputLocked(self::Ptr{ImPlotPlot})::Bool
end

"""
    ClearTextBuffer(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1105).
"""
function ClearTextBuffer(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_ClearTextBuffer(self::Ptr{ImPlotPlot})::Cvoid
end

"""
    SetTitle(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}}, title)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1107).
"""
function SetTitle(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}}, title)
    @ccall libcimgui.ImPlotPlot_SetTitle(self::Ptr{ImPlotPlot}, title::Cstring)::Cvoid
end

"""
    HasTitle(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1116).
"""
function HasTitle(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_HasTitle(self::Ptr{ImPlotPlot})::Bool
end

"""
    GetTitle(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1117).
"""
function GetTitle(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_GetTitle(self::Ptr{ImPlotPlot})::Cstring
end

"""
    XAxis(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}}, i::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1119).
"""
function XAxis(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}}, i::Integer)
    @ccall libcimgui.ImPlotPlot_XAxis_Nil(self::Ptr{ImPlotPlot}, i::Cint)::Ptr{ImPlotAxis}
end

"""
    YAxis(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}}, i::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1121).
"""
function YAxis(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}}, i::Integer)
    @ccall libcimgui.ImPlotPlot_YAxis_Nil(self::Ptr{ImPlotPlot}, i::Cint)::Ptr{ImPlotAxis}
end

"""
    EnabledAxesX(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1124).
"""
function EnabledAxesX(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_EnabledAxesX(self::Ptr{ImPlotPlot})::Cint
end

"""
    EnabledAxesY(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1131).
"""
function EnabledAxesY(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}})
    @ccall libcimgui.ImPlotPlot_EnabledAxesY(self::Ptr{ImPlotPlot})::Cint
end

"""
    SetAxisLabel(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}}, axis, label)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1138).
"""
function SetAxisLabel(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}}, axis, label)
    @ccall libcimgui.ImPlotPlot_SetAxisLabel(self::Ptr{ImPlotPlot}, axis::Ptr{ImPlotAxis}, label::Cstring)::Cvoid
end

"""
    GetAxisLabel(self::Union{ImPlotPlot, Ptr{ImPlotPlot}, Ref{ImPlotPlot}}, axis::ImPlotAxis)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1148).
"""
function GetAxisLabel(self::Union{ImPlotPlot,Ptr{ImPlotPlot},Ref{ImPlotPlot}}, axis::ImPlotAxis)
    @ccall libcimgui.ImPlotPlot_GetAxisLabel(self::Ptr{ImPlotPlot}, axis::ImPlotAxis)::Cstring
end

"""
    ImPlotSubplot()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1173).
"""
function ImPlotSubplot()
    @ccall libcimgui.ImPlotSubplot_ImPlotSubplot()::Ptr{ImPlotSubplot}
end

function Base.finalizer(self::Union{Ptr{ImPlotSubplot},ImPlotSubplot})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotSubplot_destroy(self::Ptr{ImPlotSubplot})::Cvoid)
end

"""
    ImPlotNextPlotData()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1196).
"""
function ImPlotNextPlotData()
    @ccall libcimgui.ImPlotNextPlotData_ImPlotNextPlotData()::Ptr{ImPlotNextPlotData}
end

function Base.finalizer(self::Union{Ptr{ImPlotNextPlotData},ImPlotNextPlotData})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotNextPlotData_destroy(self::Ptr{ImPlotNextPlotData})::Cvoid)
end

"""
    Reset(self::Union{ImPlotNextPlotData, Ptr{ImPlotNextPlotData}, Ref{ImPlotNextPlotData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1198).
"""
function Reset(self::Union{ImPlotNextPlotData,Ptr{ImPlotNextPlotData},Ref{ImPlotNextPlotData}})
    @ccall libcimgui.ImPlotNextPlotData_Reset(self::Ptr{ImPlotNextPlotData})::Cvoid
end

"""
    ImPlotNextItemData()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1219).
"""
function ImPlotNextItemData()
    @ccall libcimgui.ImPlotNextItemData_ImPlotNextItemData()::Ptr{ImPlotNextItemData}
end

function Base.finalizer(self::Union{Ptr{ImPlotNextItemData},ImPlotNextItemData})
    ptr = pointer_from_objref(self)
    GC.@preserve self @ccall(libcimgui.ImPlotNextItemData_destroy(self::Ptr{ImPlotNextItemData})::Cvoid)
end

"""
    Reset(self::Union{ImPlotNextItemData, Ptr{ImPlotNextItemData}, Ref{ImPlotNextItemData}})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1220).
"""
function Reset(self::Union{ImPlotNextItemData,Ptr{ImPlotNextItemData},Ref{ImPlotNextItemData}})
    @ccall libcimgui.ImPlotNextItemData_Reset(self::Ptr{ImPlotNextItemData})::Cvoid
end

"""
    Initialize(ctx)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1287).
"""
function Initialize(ctx)
    @ccall libcimgui.ImPlot_Initialize(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    ResetCtxForNextPlot(ctx)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1289).
"""
function ResetCtxForNextPlot(ctx)
    @ccall libcimgui.ImPlot_ResetCtxForNextPlot(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    ResetCtxForNextAlignedPlots(ctx)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1291).
"""
function ResetCtxForNextAlignedPlots(ctx)
    @ccall libcimgui.ImPlot_ResetCtxForNextAlignedPlots(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    ResetCtxForNextSubplot(ctx)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1293).
"""
function ResetCtxForNextSubplot(ctx)
    @ccall libcimgui.ImPlot_ResetCtxForNextSubplot(ctx::Ptr{ImPlotContext})::Cvoid
end

"""
    GetPlot(title)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1300).
"""
function GetPlot(title)
    @ccall libcimgui.ImPlot_GetPlot(title::Cstring)::Ptr{ImPlotPlot}
end

"""
    GetCurrentPlot()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1302).
"""
function GetCurrentPlot()
    @ccall libcimgui.ImPlot_GetCurrentPlot()::Ptr{ImPlotPlot}
end

"""
    BustPlotCache()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1304).
"""
function BustPlotCache()
    @ccall libcimgui.ImPlot_BustPlotCache()::Cvoid
end

"""
    ShowPlotContextMenu(plot)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1307).
"""
function ShowPlotContextMenu(plot)
    @ccall libcimgui.ImPlot_ShowPlotContextMenu(plot::Ptr{ImPlotPlot})::Cvoid
end

"""
    SetupLock()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1314).
"""
function SetupLock()
    @ccall libcimgui.ImPlot_SetupLock()::Cvoid
end

"""
    SubplotNextCell()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1326).
"""
function SubplotNextCell()
    @ccall libcimgui.ImPlot_SubplotNextCell()::Cvoid
end

"""
    ShowSubplotsContextMenu(subplot)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1329).
"""
function ShowSubplotsContextMenu(subplot)
    @ccall libcimgui.ImPlot_ShowSubplotsContextMenu(subplot::Ptr{ImPlotSubplot})::Cvoid
end

"""
    BeginItem(label_id, spec::ImPlotSpec = ImPlotSpec(), item_col = IMPLOT_AUTO_COL, item_mkr = ImPlotMarker_Invalid)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1336).
"""
function BeginItem(
    label_id,
    spec::ImPlotSpec = ImPlotSpec(),
    item_col = IMPLOT_AUTO_COL,
    item_mkr = ImPlotMarker_Invalid,
)
    @ccall libcimgui.ImPlot_BeginItem(
        label_id::Cstring,
        spec::ImPlotSpec,
        item_col::ImVec4,
        item_mkr::ImPlotMarker,
    )::Bool
end

"""
    EndItem()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1351).
"""
function EndItem()
    @ccall libcimgui.ImPlot_EndItem()::Cvoid
end

"""
    RegisterOrGetItem(label_id, flags::Union{ImPlotItemFlags_, Integer}, just_created = C_NULL)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1354).
"""
function RegisterOrGetItem(label_id, flags::Union{ImPlotItemFlags_,Integer}, just_created = C_NULL)
    @ccall libcimgui.ImPlot_RegisterOrGetItem(
        label_id::Cstring,
        flags::ImPlotItemFlags,
        just_created::Ptr{Bool},
    )::Ptr{ImPlotItem}
end

"""
    GetItem(label_id)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1356).
"""
function GetItem(label_id)
    @ccall libcimgui.ImPlot_GetItem(label_id::Cstring)::Ptr{ImPlotItem}
end

"""
    GetCurrentItem()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1358).
"""
function GetCurrentItem()
    @ccall libcimgui.ImPlot_GetCurrentItem()::Ptr{ImPlotItem}
end

"""
    BustItemCache()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1360).
"""
function BustItemCache()
    @ccall libcimgui.ImPlot_BustItemCache()::Cvoid
end

"""
    AnyAxesInputLocked(axes, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1367).
"""
function AnyAxesInputLocked(axes, count::Integer)
    @ccall libcimgui.ImPlot_AnyAxesInputLocked(axes::Ptr{ImPlotAxis}, count::Cint)::Bool
end

"""
    AllAxesInputLocked(axes, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1376).
"""
function AllAxesInputLocked(axes, count::Integer)
    @ccall libcimgui.ImPlot_AllAxesInputLocked(axes::Ptr{ImPlotAxis}, count::Cint)::Bool
end

"""
    AnyAxesHeld(axes, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1384).
"""
function AnyAxesHeld(axes, count::Integer)
    @ccall libcimgui.ImPlot_AnyAxesHeld(axes::Ptr{ImPlotAxis}, count::Cint)::Bool
end

"""
    AnyAxesHovered(axes, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1392).
"""
function AnyAxesHovered(axes, count::Integer)
    @ccall libcimgui.ImPlot_AnyAxesHovered(axes::Ptr{ImPlotAxis}, count::Cint)::Bool
end

"""
    FitThisFrame()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1401).
"""
function FitThisFrame()
    @ccall libcimgui.ImPlot_FitThisFrame()::Bool
end

"""
    FitPointX(x::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1406).
"""
function FitPointX(x::Real)
    @ccall libcimgui.ImPlot_FitPointX(x::Cdouble)::Cvoid
end

"""
    FitPointY(y::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1413).
"""
function FitPointY(y::Real)
    @ccall libcimgui.ImPlot_FitPointY(y::Cdouble)::Cvoid
end

"""
    FitPoint(p::ImPlotPoint)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1420).
"""
function FitPoint(p::ImPlotPoint)
    @ccall libcimgui.ImPlot_FitPoint(p::ImPlotPoint)::Cvoid
end

"""
    RangesOverlap(r1::ImPlotRange, r2::ImPlotRange)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1429).
"""
function RangesOverlap(r1::ImPlotRange, r2::ImPlotRange)
    @ccall libcimgui.ImPlot_RangesOverlap(r1::ImPlotRange, r2::ImPlotRange)::Bool
end

"""
    ShowAxisContextMenu(axis, equal_axis, time_allowed = false)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1433).
"""
function ShowAxisContextMenu(axis, equal_axis, time_allowed = false)
    @ccall libcimgui.ImPlot_ShowAxisContextMenu(
        axis::Ptr{ImPlotAxis},
        equal_axis::Ptr{ImPlotAxis},
        time_allowed::Bool,
    )::Cvoid
end

"""
    GetLocationPos(outer_rect::ImRect, inner_size::ImVec2, location::Union{ImPlotLocation_, Integer}, pad::ImVec2 = ImVec2(0, 0))



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1440).
"""
function GetLocationPos(
    outer_rect::ImRect,
    inner_size::ImVec2,
    location::Union{ImPlotLocation_,Integer},
    pad::ImVec2 = ImVec2(0, 0),
)
    @ccall libcimgui.ImPlot_GetLocationPos(
        outer_rect::ImRect,
        inner_size::ImVec2,
        location::ImPlotLocation,
        pad::ImVec2,
    )::ImVec2
end

"""
    CalcLegendSize(items, pad::ImVec2, spacing::ImVec2, vertical::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1442).
"""
function CalcLegendSize(items, pad::ImVec2, spacing::ImVec2, vertical::Bool)
    @ccall libcimgui.ImPlot_CalcLegendSize(
        items::Ptr{ImPlotItemGroup},
        pad::ImVec2,
        spacing::ImVec2,
        vertical::Bool,
    )::ImVec2
end

"""
    ClampLegendRect(legend_rect, outer_rect::ImRect, pad::ImVec2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1444).
"""
function ClampLegendRect(legend_rect, outer_rect::ImRect, pad::ImVec2)
    @ccall libcimgui.ImPlot_ClampLegendRect(legend_rect::Ptr{ImRect}, outer_rect::ImRect, pad::ImVec2)::Bool
end

"""
    ShowLegendEntries(items, legend_bb::ImRect, interactable::Bool, pad::ImVec2, spacing::ImVec2, vertical::Bool, DrawList)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1446).
"""
function ShowLegendEntries(
    items,
    legend_bb::ImRect,
    interactable::Bool,
    pad::ImVec2,
    spacing::ImVec2,
    vertical::Bool,
    DrawList,
)
    @ccall libcimgui.ImPlot_ShowLegendEntries(
        items::Ptr{ImPlotItemGroup},
        legend_bb::ImRect,
        interactable::Bool,
        pad::ImVec2,
        spacing::ImVec2,
        vertical::Bool,
        DrawList::Ptr{ImDrawList},
    )::Bool
end

"""
    ShowAltLegend(title_id, vertical = true, size::ImVec2 = ImVec2(0, 0), interactable = true)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1448).
"""
function ShowAltLegend(title_id, vertical = true, size::ImVec2 = ImVec2(0, 0), interactable = true)
    @ccall libcimgui.ImPlot_ShowAltLegend(title_id::Cstring, vertical::Bool, size::ImVec2, interactable::Bool)::Cvoid
end

"""
    ShowLegendContextMenu(legend, visible::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1450).
"""
function ShowLegendContextMenu(legend, visible::Bool)
    @ccall libcimgui.ImPlot_ShowLegendContextMenu(legend::Ptr{ImPlotLegend}, visible::Bool)::Bool
end

"""
    LabelAxisValue(axis::ImPlotAxis, value::Real, buff, size::Integer, round = false)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1457).
"""
function LabelAxisValue(axis::ImPlotAxis, value::Real, buff, size::Integer, round = false)
    @ccall libcimgui.ImPlot_LabelAxisValue(
        axis::ImPlotAxis,
        value::Cdouble,
        buff::Cstring,
        size::Cint,
        round::Bool,
    )::Cvoid
end

"""
    GetItemData()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1464).
"""
function GetItemData()
    @ccall libcimgui.ImPlot_GetItemData()::Ptr{ImPlotNextItemData}
end

"""
    IsColorAuto(col::ImVec4)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1467).
"""
function IsColorAuto(col::ImVec4)
    @ccall libcimgui.ImPlot_IsColorAuto_Vec4(col::ImVec4)::Bool
end

"""
    IsColorAuto(idx::Union{ImPlotCol_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1469).
"""
function IsColorAuto(idx::Union{ImPlotCol_,Integer})
    @ccall libcimgui.ImPlot_IsColorAuto_PlotCol(idx::ImPlotCol)::Bool
end

"""
    GetAutoColor(idx::Union{ImPlotCol_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1471).
"""
function GetAutoColor(idx::Union{ImPlotCol_,Integer})
    @ccall libcimgui.ImPlot_GetAutoColor(idx::ImPlotCol)::ImVec4
end

"""
    GetStyleColorVec4(idx::Union{ImPlotCol_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1474).
"""
function GetStyleColorVec4(idx::Union{ImPlotCol_,Integer})
    @ccall libcimgui.ImPlot_GetStyleColorVec4(idx::ImPlotCol)::ImVec4
end

"""
    GetStyleColorU32(idx::Union{ImPlotCol_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1475).
"""
function GetStyleColorU32(idx::Union{ImPlotCol_,Integer})
    @ccall libcimgui.ImPlot_GetStyleColorU32(idx::ImPlotCol)::ImU32
end

"""
    AddTextVertical(DrawList, pos::ImVec2, col::Integer, text_begin, text_end = C_NULL)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1478).
"""
function AddTextVertical(DrawList, pos::ImVec2, col::Integer, text_begin, text_end = C_NULL)
    @ccall libcimgui.ImPlot_AddTextVertical(
        DrawList::Ptr{ImDrawList},
        pos::ImVec2,
        col::ImU32,
        text_begin::Cstring,
        text_end::Cstring,
    )::Cvoid
end

"""
    AddTextCentered(DrawList, top_center::ImVec2, col::Integer, text_begin, text_end = C_NULL)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1480).
"""
function AddTextCentered(DrawList, top_center::ImVec2, col::Integer, text_begin, text_end = C_NULL)
    @ccall libcimgui.ImPlot_AddTextCentered(
        DrawList::Ptr{ImDrawList},
        top_center::ImVec2,
        col::ImU32,
        text_begin::Cstring,
        text_end::Cstring,
    )::Cvoid
end

"""
    CalcTextSizeVertical(text)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1482).
"""
function CalcTextSizeVertical(text)
    @ccall libcimgui.ImPlot_CalcTextSizeVertical(text::Cstring)::ImVec2
end

"""
    CalcTextColor(bg::ImVec4)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1487).
"""
function CalcTextColor(bg::ImVec4)
    @ccall libcimgui.ImPlot_CalcTextColor_Vec4(bg::ImVec4)::ImU32
end

"""
    CalcTextColor(bg::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1488).
"""
function CalcTextColor(bg::Integer)
    @ccall libcimgui.ImPlot_CalcTextColor_U32(bg::ImU32)::ImU32
end

"""
    CalcHoverColor(col::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1490).
"""
function CalcHoverColor(col::Integer)
    @ccall libcimgui.ImPlot_CalcHoverColor(col::ImU32)::ImU32
end

"""
    ClampLabelPos(pos::ImVec2, size::ImVec2, Min::ImVec2, Max::ImVec2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1493).
"""
function ClampLabelPos(pos::ImVec2, size::ImVec2, Min::ImVec2, Max::ImVec2)
    @ccall libcimgui.ImPlot_ClampLabelPos(pos::ImVec2, size::ImVec2, Min::ImVec2, Max::ImVec2)::ImVec2
end

"""
    GetColormapColorU32(idx::Integer, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1502).
"""
function GetColormapColorU32(idx::Integer, cmap::Union{ImPlotColormap_,Integer})
    @ccall libcimgui.ImPlot_GetColormapColorU32(idx::Cint, cmap::ImPlotColormap)::ImU32
end

"""
    NextColormapColorU32()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1504).
"""
function NextColormapColorU32()
    @ccall libcimgui.ImPlot_NextColormapColorU32()::ImU32
end

"""
    SampleColormapU32(t::Real, cmap::Union{ImPlotColormap_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1506).
"""
function SampleColormapU32(t::Real, cmap::Union{ImPlotColormap_,Integer})
    @ccall libcimgui.ImPlot_SampleColormapU32(t::Cfloat, cmap::ImPlotColormap)::ImU32
end

"""
    RenderColorBar(colors::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, size::Integer, DrawList, bounds::ImRect, vert::Bool, reversed::Bool, continuous::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1509).
"""
function RenderColorBar(
    colors::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    size::Integer,
    DrawList,
    bounds::ImRect,
    vert::Bool,
    reversed::Bool,
    continuous::Bool,
)
    @ccall libcimgui.ImPlot_RenderColorBar(
        colors::Ptr{ImU32},
        size::Cint,
        DrawList::Ptr{ImDrawList},
        bounds::ImRect,
        vert::Bool,
        reversed::Bool,
        continuous::Bool,
    )::Cvoid
end

"""
    AddLineH(draw_list, x1::Real, x2::Real, y::Real, col::Integer, thickness::Real = 1.0 * f)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1516).
"""
function AddLineH(draw_list, x1::Real, x2::Real, y::Real, col::Integer, thickness::Real = 1.0 * f)
    @ccall libcimgui.ImPlot_AddLineH(
        draw_list::Ptr{ImDrawList},
        x1::Cfloat,
        x2::Cfloat,
        y::Cfloat,
        col::ImU32,
        thickness::Cfloat,
    )::Cvoid
end

"""
    AddLineV(draw_list, x::Real, y1::Real, y2::Real, col::Integer, thickness::Real = 1.0 * f)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1517).
"""
function AddLineV(draw_list, x::Real, y1::Real, y2::Real, col::Integer, thickness::Real = 1.0 * f)
    @ccall libcimgui.ImPlot_AddLineV(
        draw_list::Ptr{ImDrawList},
        x::Cfloat,
        y1::Cfloat,
        y2::Cfloat,
        col::ImU32,
        thickness::Cfloat,
    )::Cvoid
end

"""
    NiceNum(x::Real, round::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1525).
"""
function NiceNum(x::Real, round::Bool)
    @ccall libcimgui.ImPlot_NiceNum(x::Cdouble, round::Bool)::Cdouble
end

"""
    OrderOfMagnitude(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1527).
"""
function OrderOfMagnitude(val::Real)
    @ccall libcimgui.ImPlot_OrderOfMagnitude(val::Cdouble)::Cint
end

"""
    OrderToPrecision(order::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1529).
"""
function OrderToPrecision(order::Integer)
    @ccall libcimgui.ImPlot_OrderToPrecision(order::Cint)::Cint
end

"""
    Precision(val::Real)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1531).
"""
function Precision(val::Real)
    @ccall libcimgui.ImPlot_Precision(val::Cdouble)::Cint
end

"""
    RoundTo(val::Real, prec::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1533).
"""
function RoundTo(val::Real, prec::Integer)
    @ccall libcimgui.ImPlot_RoundTo(val::Cdouble, prec::Cint)::Cdouble
end

"""
    Intersection(a1::ImVec2, a2::ImVec2, b1::ImVec2, b2::ImVec2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1536).
"""
function Intersection(a1::ImVec2, a2::ImVec2, b1::ImVec2, b2::ImVec2)
    @ccall libcimgui.ImPlot_Intersection(a1::ImVec2, a2::ImVec2, b1::ImVec2, b2::ImVec2)::ImVec2
end

"""
    IsLeapYear(year::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1578).
"""
function IsLeapYear(year::Integer)
    @ccall libcimgui.ImPlot_IsLeapYear(year::Cint)::Bool
end

"""
    GetDaysInMonth(year::Integer, month::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1582).
"""
function GetDaysInMonth(year::Integer, month::Integer)
    @ccall libcimgui.ImPlot_GetDaysInMonth(year::Cint, month::Cint)::Cint
end

"""
    MkGmtTime(ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1588).
"""
function MkGmtTime(ptm)
    @ccall libcimgui.ImPlot_MkGmtTime(ptm::Ptr{tm})::ImPlotTime
end

"""
    GetGmtTime(t::ImPlotTime, ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1590).
"""
function GetGmtTime(t::ImPlotTime, ptm)
    @ccall libcimgui.ImPlot_GetGmtTime(t::ImPlotTime, ptm::Ptr{tm})::Ptr{tm}
end

"""
    MkLocTime(ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1593).
"""
function MkLocTime(ptm)
    @ccall libcimgui.ImPlot_MkLocTime(ptm::Ptr{tm})::ImPlotTime
end

"""
    GetLocTime(t::ImPlotTime, ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1595).
"""
function GetLocTime(t::ImPlotTime, ptm)
    @ccall libcimgui.ImPlot_GetLocTime(t::ImPlotTime, ptm::Ptr{tm})::Ptr{tm}
end

"""
    MkTime(ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1601).
"""
function MkTime(ptm)
    @ccall libcimgui.ImPlot_MkTime(ptm::Ptr{tm})::ImPlotTime
end

"""
    GetTime(t::ImPlotTime, ptm)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1606).
"""
function GetTime(t::ImPlotTime, ptm)
    @ccall libcimgui.ImPlot_GetTime(t::ImPlotTime, ptm::Ptr{tm})::Ptr{tm}
end

"""
    MakeTime(year::Integer, month::Integer = 0, day::Integer = 1, hour::Integer = 0, min::Integer = 0, sec::Integer = 0, us::Integer = 0)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1613).
"""
function MakeTime(
    year::Integer,
    month::Integer = 0,
    day::Integer = 1,
    hour::Integer = 0,
    min::Integer = 0,
    sec::Integer = 0,
    us::Integer = 0,
)
    @ccall libcimgui.ImPlot_MakeTime(
        year::Cint,
        month::Cint,
        day::Cint,
        hour::Cint,
        min::Cint,
        sec::Cint,
        us::Cint,
    )::ImPlotTime
end

"""
    GetYear(t::ImPlotTime)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1615).
"""
function GetYear(t::ImPlotTime)
    @ccall libcimgui.ImPlot_GetYear(t::ImPlotTime)::Cint
end

"""
    GetMonth(t::ImPlotTime)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1617).
"""
function GetMonth(t::ImPlotTime)
    @ccall libcimgui.ImPlot_GetMonth(t::ImPlotTime)::Cint
end

"""
    AddTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_, Integer}, count::Integer)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1620).
"""
function AddTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_,Integer}, count::Integer)
    @ccall libcimgui.ImPlot_AddTime(t::ImPlotTime, unit::ImPlotTimeUnit, count::Cint)::ImPlotTime
end

"""
    FloorTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1622).
"""
function FloorTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_,Integer})
    @ccall libcimgui.ImPlot_FloorTime(t::ImPlotTime, unit::ImPlotTimeUnit)::ImPlotTime
end

"""
    CeilTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1624).
"""
function CeilTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_,Integer})
    @ccall libcimgui.ImPlot_CeilTime(t::ImPlotTime, unit::ImPlotTimeUnit)::ImPlotTime
end

"""
    RoundTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_, Integer})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1626).
"""
function RoundTime(t::ImPlotTime, unit::Union{ImPlotTimeUnit_,Integer})
    @ccall libcimgui.ImPlot_RoundTime(t::ImPlotTime, unit::ImPlotTimeUnit)::ImPlotTime
end

"""
    CombineDateTime(date_part::ImPlotTime, time_part::ImPlotTime)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1628).
"""
function CombineDateTime(date_part::ImPlotTime, time_part::ImPlotTime)
    @ccall libcimgui.ImPlot_CombineDateTime(date_part::ImPlotTime, time_part::ImPlotTime)::ImPlotTime
end

"""
    Now()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1631).
"""
function Now()
    @ccall libcimgui.ImPlot_Now()::ImPlotTime
end

"""
    Today()



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1633).
"""
function Today()
    @ccall libcimgui.ImPlot_Today()::ImPlotTime
end

"""
    FormatTime(t::ImPlotTime, buffer, size::Integer, fmt::Union{ImPlotTimeFmt_, Integer}, use_24_hr_clk::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1636).
"""
function FormatTime(t::ImPlotTime, buffer, size::Integer, fmt::Union{ImPlotTimeFmt_,Integer}, use_24_hr_clk::Bool)
    @ccall libcimgui.ImPlot_FormatTime(
        t::ImPlotTime,
        buffer::Cstring,
        size::Cint,
        fmt::ImPlotTimeFmt,
        use_24_hr_clk::Bool,
    )::Cint
end

"""
    FormatDate(t::ImPlotTime, buffer, size::Integer, fmt::Union{ImPlotDateFmt_, Integer}, use_iso_8601::Bool)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1638).
"""
function FormatDate(t::ImPlotTime, buffer, size::Integer, fmt::Union{ImPlotDateFmt_,Integer}, use_iso_8601::Bool)
    @ccall libcimgui.ImPlot_FormatDate(
        t::ImPlotTime,
        buffer::Cstring,
        size::Cint,
        fmt::ImPlotDateFmt,
        use_iso_8601::Bool,
    )::Cint
end

"""
    FormatDateTime(t::ImPlotTime, buffer, size::Integer, fmt::ImPlotDateTimeSpec)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1640).
"""
function FormatDateTime(t::ImPlotTime, buffer, size::Integer, fmt::ImPlotDateTimeSpec)
    @ccall libcimgui.ImPlot_FormatDateTime(t::ImPlotTime, buffer::Cstring, size::Cint, fmt::ImPlotDateTimeSpec)::Cint
end

"""
    ShowDatePicker(id, level, t, t1, t2)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1646).
"""
function ShowDatePicker(id, level, t, t1, t2)
    @ccall libcimgui.ImPlot_ShowDatePicker(
        id::Cstring,
        level::Ptr{Cint},
        t::Ptr{ImPlotTime},
        t1::Ptr{ImPlotTime},
        t2::Ptr{ImPlotTime},
    )::Bool
end

"""
    ShowTimePicker(id, t)



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1649).
"""
function ShowTimePicker(id, t)
    @ccall libcimgui.ImPlot_ShowTimePicker(id::Cstring, t::Ptr{ImPlotTime})::Bool
end

"""
    TransformForward_Log10(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1655).
"""
function TransformForward_Log10(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformForward_Log10(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    TransformInverse_Log10(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1660).
"""
function TransformInverse_Log10(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformInverse_Log10(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    TransformForward_SymLog(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1664).
"""
function TransformForward_SymLog(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformForward_SymLog(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    TransformInverse_SymLog(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1668).
"""
function TransformInverse_SymLog(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformInverse_SymLog(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    TransformForward_Logit(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1672).
"""
function TransformForward_Logit(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformForward_Logit(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    TransformInverse_Logit(v::Real, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1677).
"""
function TransformInverse_Logit(v::Real, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_TransformInverse_Logit(v::Cdouble, noname1::Ptr{Cvoid})::Cdouble
end

"""
    Formatter_Default(value::Real, buff, size::Integer, data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1685).
"""
function Formatter_Default(value::Real, buff, size::Integer, data::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_Formatter_Default(value::Cdouble, buff::Cstring, size::Cint, data::Ptr{Cvoid})::Cint
end

"""
    Formatter_Logit(value::Real, buff, size::Integer, noname1::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1690).
"""
function Formatter_Logit(value::Real, buff, size::Integer, noname1::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_Formatter_Logit(value::Cdouble, buff::Cstring, size::Cint, noname1::Ptr{Cvoid})::Cint
end

"""
    Formatter_Time(noname1::Real, buff, size::Integer, data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1706).
"""
function Formatter_Time(noname1::Real, buff, size::Integer, data::Union{Ptr,Ref,AbstractArray})
    @ccall libcimgui.ImPlot_Formatter_Time(noname1::Cdouble, buff::Cstring, size::Cint, data::Ptr{Cvoid})::Cint
end

"""
    Locator_Default(ticker, range::ImPlotRange, pixels::Real, vertical::Bool, formatter::ImPlotFormatter, formatter_data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1715).
"""
function Locator_Default(
    ticker,
    range::ImPlotRange,
    pixels::Real,
    vertical::Bool,
    formatter::ImPlotFormatter,
    formatter_data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlot_Locator_Default(
        ticker::Ptr{ImPlotTicker},
        range::ImPlotRange,
        pixels::Cfloat,
        vertical::Bool,
        formatter::ImPlotFormatter,
        formatter_data::Ptr{Cvoid},
    )::Cvoid
end

"""
    Locator_Time(ticker, range::ImPlotRange, pixels::Real, vertical::Bool, formatter::ImPlotFormatter, formatter_data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1716).
"""
function Locator_Time(
    ticker,
    range::ImPlotRange,
    pixels::Real,
    vertical::Bool,
    formatter::ImPlotFormatter,
    formatter_data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlot_Locator_Time(
        ticker::Ptr{ImPlotTicker},
        range::ImPlotRange,
        pixels::Cfloat,
        vertical::Bool,
        formatter::ImPlotFormatter,
        formatter_data::Ptr{Cvoid},
    )::Cvoid
end

"""
    Locator_Log10(ticker, range::ImPlotRange, pixels::Real, vertical::Bool, formatter::ImPlotFormatter, formatter_data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1717).
"""
function Locator_Log10(
    ticker,
    range::ImPlotRange,
    pixels::Real,
    vertical::Bool,
    formatter::ImPlotFormatter,
    formatter_data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlot_Locator_Log10(
        ticker::Ptr{ImPlotTicker},
        range::ImPlotRange,
        pixels::Cfloat,
        vertical::Bool,
        formatter::ImPlotFormatter,
        formatter_data::Ptr{Cvoid},
    )::Cvoid
end

"""
    Locator_SymLog(ticker, range::ImPlotRange, pixels::Real, vertical::Bool, formatter::ImPlotFormatter, formatter_data::Union{Ptr, Ref, AbstractArray})



!!! warning
    This function is internal, it may change in the future.

[Upstream link](https://github.com/epezent/implot/blob/851cdbd/implot_internal.h#L1718).
"""
function Locator_SymLog(
    ticker,
    range::ImPlotRange,
    pixels::Real,
    vertical::Bool,
    formatter::ImPlotFormatter,
    formatter_data::Union{Ptr,Ref,AbstractArray},
)
    @ccall libcimgui.ImPlot_Locator_SymLog(
        ticker::Ptr{ImPlotTicker},
        range::ImPlotRange,
        pixels::Cfloat,
        vertical::Bool,
        formatter::ImPlotFormatter,
        formatter_data::Ptr{Cvoid},
    )::Cvoid
end

function Annotation(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    @ccall libcimgui.ImPlot_Annotation_Str(
        x::Cdouble,
        y::Cdouble,
        col::ImVec4,
        pix_offset::ImVec2,
        false::Bool,
        fmt::Cstring,
    )::Cvoid
end

function AnnotationClamped(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    @ccall libcimgui.ImPlot_Annotation_Str(
        x::Cdouble,
        y::Cdouble,
        col::ImVec4,
        pix_offset::ImVec2,
        true::Bool,
        fmt::Cstring,
    )::Cvoid
end

function Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    @ccall libcimgui.ImPlot_Annotation_Str(
        x::Cdouble,
        y::Cdouble,
        col::ImVec4,
        pix_offset::ImVec2,
        false::Bool,
        fmt::Cstring,
    )::Cvoid
end

function AnnotationClamped(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    @ccall libcimgui.ImPlot_Annotation_Str(
        x::Cdouble,
        y::Cdouble,
        col::ImVec4,
        pix_offset::ImVec2,
        true::Bool,
        fmt::Cstring,
    )::Cvoid
end


# exports
let prefixes = ["ImPlot", "IMPLOT"],
    internal = Set([
        :Formatter_Time_Data,
        :ImPlotAlignmentData,
        :ImPlotAnnotation,
        :ImPlotAnnotationCollection,
        :ImPlotAxis,
        :ImPlotColormapData,
        :ImPlotContext,
        :ImPlotDateFmt,
        :ImPlotDateFmt_,
        :ImPlotDateFmt_DayMo,
        :ImPlotDateFmt_DayMoYr,
        :ImPlotDateFmt_Mo,
        :ImPlotDateFmt_MoYr,
        :ImPlotDateFmt_None,
        :ImPlotDateFmt_Yr,
        :ImPlotDateTimeSpec,
        :ImPlotItem,
        :ImPlotItemGroup,
        :ImPlotLegend,
        :ImPlotMarkerInternal,
        :ImPlotMarkerInternal_,
        :ImPlotMarker_Invalid,
        :ImPlotNextItemData,
        :ImPlotNextPlotData,
        :ImPlotPlot,
        :ImPlotPointError,
        :ImPlotSubplot,
        :ImPlotTag,
        :ImPlotTagCollection,
        :ImPlotTick,
        :ImPlotTicker,
        :ImPlotTime,
        :ImPlotTimeFmt,
        :ImPlotTimeFmt_,
        :ImPlotTimeFmt_Hr,
        :ImPlotTimeFmt_HrMin,
        :ImPlotTimeFmt_HrMinS,
        :ImPlotTimeFmt_HrMinSMs,
        :ImPlotTimeFmt_MinSMs,
        :ImPlotTimeFmt_None,
        :ImPlotTimeFmt_S,
        :ImPlotTimeFmt_SMs,
        :ImPlotTimeFmt_SUs,
        :ImPlotTimeFmt_Us,
        :ImPlotTimeUnit,
        :ImPlotTimeUnit_,
        :ImPlotTimeUnit_COUNT,
        :ImPlotTimeUnit_Day,
        :ImPlotTimeUnit_Hr,
        :ImPlotTimeUnit_Min,
        :ImPlotTimeUnit_Mo,
        :ImPlotTimeUnit_Ms,
        :ImPlotTimeUnit_S,
        :ImPlotTimeUnit_Us,
        :ImPlotTimeUnit_Yr,
    ])

    for name in names(@__MODULE__; all = true)
        if any(p -> startswith(string(name), p), prefixes) && name ∉ internal
            @eval export $name
        end
    end
end

@static if VERSION >= v"1.11"
    eval(
        Meta.parse(
            "public AddColormap, Annotation, AnnotationClamped, BeginAlignedPlots, BeginDragDropSourceAxis, BeginDragDropSourceItem, BeginDragDropSourcePlot, BeginDragDropTargetAxis, BeginDragDropTargetLegend, BeginDragDropTargetPlot, BeginLegendPopup, BeginPlot, BeginSubplots, BustColorCache, CancelPlotSelection, Clamp, ColormapButton, ColormapIcon, ColormapScale, ColormapSlider, Contains, CreateContext, DestroyContext, DragLineX, DragLineY, DragPoint, DragRect, EndAlignedPlots, EndDragDropSource, EndDragDropTarget, EndLegendPopup, EndPlot, EndSubplots, GetColormapColor, GetColormapCount, GetColormapIndex, GetColormapName, GetColormapSize, GetCurrentContext, GetInputMap, GetLastItemColor, GetMarkerName, GetPlotDrawList, GetPlotLimits, GetPlotMousePos, GetPlotPos, GetPlotSelection, GetPlotSize, GetStyle, GetStyleColorName, HideNextItem, IsAxisHovered, IsLegendEntryHovered, IsPlotHovered, IsPlotSelected, IsSubplotsHovered, ItemIcon, MapInputDefault, MapInputReverse, Max, Min, NextColormapColor, NextMarker, PixelsToPlot, PlotBarGroups, PlotBars, PlotBarsG, PlotBubbles, PlotDigital, PlotDigitalG, PlotDummy, PlotErrorBars, PlotHeatmap, PlotHistogram, PlotHistogram2D, PlotImage, PlotInfLines, PlotLine, PlotLineG, PlotPieChart, PlotPolygon, PlotScatter, PlotScatterG, PlotShaded, PlotShadedG, PlotStairs, PlotStairsG, PlotStems, PlotText, PlotToPixels, PopColormap, PopPlotClipRect, PopStyleColor, PopStyleVar, PushColormap, PushPlotClipRect, PushStyleColor, PushStyleVar, SampleColormap, SetAxes, SetAxis, SetCurrentContext, SetImGuiContext, SetNextAxesLimits, SetNextAxesToFit, SetNextAxisLimits, SetNextAxisLinks, SetNextAxisToFit, SetupAxes, SetupAxesLimits, SetupAxis, SetupAxisFormat, SetupAxisLimits, SetupAxisLimitsConstraints, SetupAxisLinks, SetupAxisScale, SetupAxisTicks, SetupAxisZoomConstraints, SetupFinish, SetupLegend, SetupMouseText, ShowColormapSelector, ShowDemoWindow, ShowInputMapSelector, ShowMetricsWindow, ShowStyleEditor, ShowStyleSelector, ShowUserGuide, Size, StyleColorsAuto, StyleColorsClassic, StyleColorsDark, StyleColorsLight, TagX, TagY",
        ),
    )
end
