using CEnum

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


const __darwin_time_t = Clong

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

const time_t = __darwin_time_t

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

const ImPlotFlags = Cint

const ImPlotLocation = Cint

const ImPlotMouseTextFlags = Cint

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

const ImPlotMarker = Cint

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
    ImPlotMarker_COUNT = 10
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

struct ImPlotPoint
    x::Cdouble
    y::Cdouble
end

struct ImPlotRect
    X::ImPlotRange
    Y::ImPlotRange
end

# typedef ImPlotPoint_c ( * ImPlotGetter ) ( int idx , void * user_data )
const ImPlotGetter = Ptr{Cvoid}

const ImPlotTimeUnit = Cint

const ImPlotDateFmt = Cint

const ImPlotTimeFmt = Cint

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

struct ImPlotDateTimeSpec
    Date::ImPlotDateFmt
    Time::ImPlotTimeFmt
    UseISO8601::Bool
    Use24HourClock::Bool
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

const ImPlotDateTimeSpec = ImPlotDateTimeSpec

const ImPlotPoint = ImPlotPoint

const ImPlotRange = ImPlotRange

const ImPlotTime = ImPlotTime

const ImPlotRect = ImPlotRect

const ImPlotSpec = ImPlotSpec

const ImPlotTick = ImPlotTick

const ImPlotAxis = ImPlotAxis

# typedef void * ( * ImPlotPoint_getter ) ( void * data , int idx , ImPlotPoint_c * point )
const ImPlotPoint_getter = Ptr{Cvoid}

"""
    ImPlotSpec()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L534).
"""
function ImPlotSpec()
    ccall((:ImPlotSpec_ImPlotSpec, libcimgui), Ptr{ImPlotSpec}, ())
end

function Base.finalizer(self::Union{Ptr{ImPlotSpec},ImPlotSpec})
    ptr = pointer_from_objref(self)
    GC.@preserve self ccall((:ImPlotSpec_destroy, libcimgui), Cvoid, (Ptr{ImPlotSpec},), self)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Float32)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Float32)
    ccall((:ImPlotSpec_SetProp_Float, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, Cfloat), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Float64)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Float64)
    ccall((:ImPlotSpec_SetProp_double, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, Cdouble), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Int8)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Int8)
    ccall((:ImPlotSpec_SetProp_S8, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImS8), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::UInt8)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::UInt8)
    ccall((:ImPlotSpec_SetProp_U8, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImU8), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Int16)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Int16)
    ccall((:ImPlotSpec_SetProp_S16, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImS16), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::UInt16)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::UInt16)
    ccall((:ImPlotSpec_SetProp_U16, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImU16), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Int32)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Int32)
    ccall((:ImPlotSpec_SetProp_S32, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImS32), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::UInt32)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::UInt32)
    ccall((:ImPlotSpec_SetProp_U32, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImU32), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Int64)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::Int64)
    ccall((:ImPlotSpec_SetProp_S64, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImS64), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::UInt64)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L552).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::UInt64)
    ccall((:ImPlotSpec_SetProp_U64, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImU64), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L573).
"""
function SetProp(
    self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}},
    prop::Union{ImPlotProp_,Integer},
    v::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
)
    ccall((:ImPlotSpec_SetProp_U32Ptr, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, Ptr{ImU32}), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L585).
"""
function SetProp(
    self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}},
    prop::Union{ImPlotProp_,Integer},
    v::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
)
    ccall((:ImPlotSpec_SetProp_FloatPtr, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, Ptr{Cfloat}), self, prop, v)
end

"""
    SetProp(self::Union{ImPlotSpec, Ptr{ImPlotSpec}, Ref{ImPlotSpec}}, prop::Union{ImPlotProp_, Integer}, v::ImVec4)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L594).
"""
function SetProp(self::Union{ImPlotSpec,Ptr{ImPlotSpec},Ref{ImPlotSpec}}, prop::Union{ImPlotProp_,Integer}, v::ImVec4)
    ccall((:ImPlotSpec_SetProp_Vec4, libcimgui), Cvoid, (Ptr{ImPlotSpec}, ImPlotProp, ImVec4), self, prop, v)
end

"""
    ImPlotPoint_ImPlotPoint_Nil()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L610).
"""
function ImPlotPoint_ImPlotPoint_Nil()
    ccall((:ImPlotPoint_ImPlotPoint_Nil, libcimgui), Ptr{ImPlotPoint}, ())
end

"""
    ImPlotPoint_ImPlotPoint_double(_x::Cdouble, _y::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L611).
"""
function ImPlotPoint_ImPlotPoint_double(_x::Cdouble, _y::Cdouble)
    ccall((:ImPlotPoint_ImPlotPoint_double, libcimgui), Ptr{ImPlotPoint}, (Cdouble, Cdouble), _x, _y)
end

"""
    ImPlotPoint_ImPlotPoint_Vec2(p::ImVec2)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L612).
"""
function ImPlotPoint_ImPlotPoint_Vec2(p::ImVec2)
    ccall((:ImPlotPoint_ImPlotPoint_Vec2, libcimgui), Ptr{ImPlotPoint}, (ImVec2,), p)
end

"""
    ImPlotRange_ImPlotRange_Nil()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L625).
"""
function ImPlotRange_ImPlotRange_Nil()
    ccall((:ImPlotRange_ImPlotRange_Nil, libcimgui), Ptr{ImPlotRange}, ())
end

"""
    ImPlotRange_ImPlotRange_double(_min::Cdouble, _max::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L626).
"""
function ImPlotRange_ImPlotRange_double(_min::Cdouble, _max::Cdouble)
    ccall((:ImPlotRange_ImPlotRange_double, libcimgui), Ptr{ImPlotRange}, (Cdouble, Cdouble), _min, _max)
end

"""
    Contains(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}}, value::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L627).
"""
function Contains(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}}, value::Real)
    ccall((:ImPlotRange_Contains, libcimgui), Bool, (Ptr{ImPlotRange}, Cdouble), self, value)
end

"""
    Size(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L628).
"""
function Size(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}})
    ccall((:ImPlotRange_Size, libcimgui), Cdouble, (Ptr{ImPlotRange},), self)
end

"""
    Clamp(self::Union{ImPlotRange, Ptr{ImPlotRange}, Ref{ImPlotRange}}, value::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L629).
"""
function Clamp(self::Union{ImPlotRange,Ptr{ImPlotRange},Ref{ImPlotRange}}, value::Real)
    ccall((:ImPlotRange_Clamp, libcimgui), Cdouble, (Ptr{ImPlotRange}, Cdouble), self, value)
end

"""
    ImPlotRect_ImPlotRect_Nil()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L635).
"""
function ImPlotRect_ImPlotRect_Nil()
    ccall((:ImPlotRect_ImPlotRect_Nil, libcimgui), Ptr{ImPlotRect}, ())
end

function ImPlotRect_destroy(self)
    ccall((:ImPlotRect_destroy, libcimgui), Cvoid, (Ptr{ImPlotRect},), self)
end

"""
    ImPlotRect_ImPlotRect_double(x_min::Cdouble, x_max::Cdouble, y_min::Cdouble, y_max::Cdouble)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L636).
"""
function ImPlotRect_ImPlotRect_double(x_min::Cdouble, x_max::Cdouble, y_min::Cdouble, y_max::Cdouble)
    ccall(
        (:ImPlotRect_ImPlotRect_double, libcimgui),
        Ptr{ImPlotRect},
        (Cdouble, Cdouble, Cdouble, Cdouble),
        x_min,
        x_max,
        y_min,
        y_max,
    )
end

"""
    Contains(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, p::ImPlotPoint)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L637).
"""
function Contains(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, p::ImPlotPoint)
    ccall((:ImPlotRect_Contains_PlotPoint, libcimgui), Bool, (Ptr{ImPlotRect}, ImPlotPoint), self, p)
end

"""
    Contains(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, x::Real, y::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L638).
"""
function Contains(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, x::Real, y::Real)
    ccall((:ImPlotRect_Contains_double, libcimgui), Bool, (Ptr{ImPlotRect}, Cdouble, Cdouble), self, x, y)
end

"""
    Size(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L639).
"""
function Size(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    ccall((:ImPlotRect_Size, libcimgui), ImPlotPoint, (Ptr{ImPlotRect},), self)
end

"""
    Clamp(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, p::ImPlotPoint)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L640).
"""
function Clamp(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, p::ImPlotPoint)
    ccall((:ImPlotRect_Clamp_PlotPoint, libcimgui), ImPlotPoint, (Ptr{ImPlotRect}, ImPlotPoint), self, p)
end

"""
    Clamp(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}}, x::Real, y::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L641).
"""
function Clamp(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}}, x::Real, y::Real)
    ccall((:ImPlotRect_Clamp_double, libcimgui), ImPlotPoint, (Ptr{ImPlotRect}, Cdouble, Cdouble), self, x, y)
end

"""
    Min(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L642).
"""
function Min(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    ccall((:ImPlotRect_Min, libcimgui), ImPlotPoint, (Ptr{ImPlotRect},), self)
end

"""
    Max(self::Union{ImPlotRect, Ptr{ImPlotRect}, Ref{ImPlotRect}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L643).
"""
function Max(self::Union{ImPlotRect,Ptr{ImPlotRect},Ref{ImPlotRect}})
    ccall((:ImPlotRect_Max, libcimgui), ImPlotPoint, (Ptr{ImPlotRect},), self)
end

"""
    ImPlotStyle()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L678).
"""
function ImPlotStyle()
    ccall((:ImPlotStyle_ImPlotStyle, libcimgui), Ptr{ImPlotStyle}, ())
end

function Base.finalizer(self::Union{Ptr{ImPlotStyle},ImPlotStyle})
    ptr = pointer_from_objref(self)
    GC.@preserve self ccall((:ImPlotStyle_destroy, libcimgui), Cvoid, (Ptr{ImPlotStyle},), self)
end

"""
    ImPlotInputMap()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L710).
"""
function ImPlotInputMap()
    ccall((:ImPlotInputMap_ImPlotInputMap, libcimgui), Ptr{ImPlotInputMap}, ())
end

function Base.finalizer(self::Union{Ptr{ImPlotInputMap},ImPlotInputMap})
    ptr = pointer_from_objref(self)
    GC.@preserve self ccall((:ImPlotInputMap_destroy, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), self)
end

"""
    CreateContext()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L733).
"""
function CreateContext()
    ccall((:ImPlot_CreateContext, libcimgui), Ptr{ImPlotContext}, ())
end

"""
    DestroyContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L735).
"""
function DestroyContext(ctx)
    ccall((:ImPlot_DestroyContext, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

"""
    GetCurrentContext()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L737).
"""
function GetCurrentContext()
    ccall((:ImPlot_GetCurrentContext, libcimgui), Ptr{ImPlotContext}, ())
end

"""
    SetCurrentContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L739).
"""
function SetCurrentContext(ctx)
    ccall((:ImPlot_SetCurrentContext, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

"""
    SetImGuiContext(ctx)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L745).
"""
function SetImGuiContext(ctx)
    ccall((:ImPlot_SetImGuiContext, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

"""
    BeginPlot(title_id, size::ImVec2 = ImVec2(-1, 0), flags::Union{ImPlotFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L767).
"""
function BeginPlot(title_id, size::ImVec2 = ImVec2(-1, 0), flags::Union{ImPlotFlags_,Integer} = 0)
    ccall((:ImPlot_BeginPlot, libcimgui), Bool, (Cstring, ImVec2, ImPlotFlags), title_id, size, flags)
end

"""
    EndPlot()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L771).
"""
function EndPlot()
    ccall((:ImPlot_EndPlot, libcimgui), Cvoid, ())
end

"""
    BeginSubplots(title_id, rows::Integer, cols::Integer, size::ImVec2, flags::Union{ImPlotSubplotFlags_, Integer} = 0, row_ratios::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}} = C_NULL, col_ratios::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}} = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L823).
"""
function BeginSubplots(
    title_id,
    rows::Integer,
    cols::Integer,
    size::ImVec2,
    flags::Union{ImPlotSubplotFlags_,Integer} = 0,
    row_ratios::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}} = C_NULL,
    col_ratios::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}} = C_NULL,
)
    ccall(
        (:ImPlot_BeginSubplots, libcimgui),
        Bool,
        (Cstring, Cint, Cint, ImVec2, ImPlotSubplotFlags, Ptr{Cfloat}, Ptr{Cfloat}),
        title_id,
        rows,
        cols,
        size,
        flags,
        row_ratios,
        col_ratios,
    )
end

"""
    EndSubplots()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L833).
"""
function EndSubplots()
    ccall((:ImPlot_EndSubplots, libcimgui), Cvoid, ())
end

"""
    SetupAxis(axis::Union{ImAxis_, Integer}, label = C_NULL, flags::Union{ImPlotAxisFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L865).
"""
function SetupAxis(axis::Union{ImAxis_,Integer}, label = C_NULL, flags::Union{ImPlotAxisFlags_,Integer} = 0)
    ccall((:ImPlot_SetupAxis, libcimgui), Cvoid, (ImAxis, Cstring, ImPlotAxisFlags), axis, label, flags)
end

"""
    SetupAxisLimits(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L867).
"""
function SetupAxisLimits(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)
    ccall((:ImPlot_SetupAxisLimits, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble, ImPlotCond), axis, v_min, v_max, cond)
end

"""
    SetupAxisLinks(axis::Union{ImAxis_, Integer}, link_min::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, link_max::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L869).
"""
function SetupAxisLinks(
    axis::Union{ImAxis_,Integer},
    link_min::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    link_max::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
)
    ccall((:ImPlot_SetupAxisLinks, libcimgui), Cvoid, (ImAxis, Ptr{Cdouble}, Ptr{Cdouble}), axis, link_min, link_max)
end

"""
    SetupAxisFormat(axis::Union{ImAxis_, Integer}, fmt)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L871).
"""
function SetupAxisFormat(axis::Union{ImAxis_,Integer}, fmt)
    ccall((:ImPlot_SetupAxisFormat_Str, libcimgui), Cvoid, (ImAxis, Cstring), axis, fmt)
end

"""
    SetupAxisFormat(axis::Union{ImAxis_, Integer}, formatter::ImPlotFormatter, data)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L873).
"""
function SetupAxisFormat(axis::Union{ImAxis_,Integer}, formatter::ImPlotFormatter, data)
    ccall(
        (:ImPlot_SetupAxisFormat_PlotFormatter, libcimgui),
        Cvoid,
        (ImAxis, ImPlotFormatter, Ptr{Cvoid}),
        axis,
        formatter,
        data,
    )
end

"""
    SetupAxisTicks(axis::Union{ImAxis_, Integer}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, n_ticks::Integer, labels::Union{Ptr{Nothing}, String, AbstractArray{String}} = C_NULL, keep_default = false)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L875).
"""
function SetupAxisTicks(
    axis::Union{ImAxis_,Integer},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    n_ticks::Integer,
    labels::Union{Ptr{Nothing},String,AbstractArray{String}} = C_NULL,
    keep_default = false,
)
    ccall(
        (:ImPlot_SetupAxisTicks_doublePtr, libcimgui),
        Cvoid,
        (ImAxis, Ptr{Cdouble}, Cint, Ptr{Cstring}, Bool),
        axis,
        values,
        n_ticks,
        labels,
        keep_default,
    )
end

"""
    SetupAxisTicks(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, n_ticks::Integer, labels::Union{Ptr{Nothing}, String, AbstractArray{String}} = C_NULL, keep_default = false)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L877).
"""
function SetupAxisTicks(
    axis::Union{ImAxis_,Integer},
    v_min::Real,
    v_max::Real,
    n_ticks::Integer,
    labels::Union{Ptr{Nothing},String,AbstractArray{String}} = C_NULL,
    keep_default = false,
)
    ccall(
        (:ImPlot_SetupAxisTicks_double, libcimgui),
        Cvoid,
        (ImAxis, Cdouble, Cdouble, Cint, Ptr{Cstring}, Bool),
        axis,
        v_min,
        v_max,
        n_ticks,
        labels,
        keep_default,
    )
end

"""
    SetupAxisScale(axis::Union{ImAxis_, Integer}, scale::Union{ImPlotScale_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L879).
"""
function SetupAxisScale(axis::Union{ImAxis_,Integer}, scale::Union{ImPlotScale_,Integer})
    ccall((:ImPlot_SetupAxisScale_PlotScale, libcimgui), Cvoid, (ImAxis, ImPlotScale), axis, scale)
end

"""
    SetupAxisScale(axis::Union{ImAxis_, Integer}, forward::ImPlotTransform, inverse::ImPlotTransform, data)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L881).
"""
function SetupAxisScale(axis::Union{ImAxis_,Integer}, forward::ImPlotTransform, inverse::ImPlotTransform, data)
    ccall(
        (:ImPlot_SetupAxisScale_PlotTransform, libcimgui),
        Cvoid,
        (ImAxis, ImPlotTransform, ImPlotTransform, Ptr{Cvoid}),
        axis,
        forward,
        inverse,
        data,
    )
end

"""
    SetupAxisLimitsConstraints(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L883).
"""
function SetupAxisLimitsConstraints(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real)
    ccall((:ImPlot_SetupAxisLimitsConstraints, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble), axis, v_min, v_max)
end

"""
    SetupAxisZoomConstraints(axis::Union{ImAxis_, Integer}, z_min::Real, z_max::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L885).
"""
function SetupAxisZoomConstraints(axis::Union{ImAxis_,Integer}, z_min::Real, z_max::Real)
    ccall((:ImPlot_SetupAxisZoomConstraints, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble), axis, z_min, z_max)
end

"""
    SetupAxes(x_label, y_label, x_flags::Union{ImPlotAxisFlags_, Integer} = 0, y_flags::Union{ImPlotAxisFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L888).
"""
function SetupAxes(
    x_label,
    y_label,
    x_flags::Union{ImPlotAxisFlags_,Integer} = 0,
    y_flags::Union{ImPlotAxisFlags_,Integer} = 0,
)
    ccall(
        (:ImPlot_SetupAxes, libcimgui),
        Cvoid,
        (Cstring, Cstring, ImPlotAxisFlags, ImPlotAxisFlags),
        x_label,
        y_label,
        x_flags,
        y_flags,
    )
end

"""
    SetupAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L890).
"""
function SetupAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)
    ccall(
        (:ImPlot_SetupAxesLimits, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, Cdouble, Cdouble, ImPlotCond),
        x_min,
        x_max,
        y_min,
        y_max,
        cond,
    )
end

"""
    SetupLegend(location::Union{ImPlotLocation_, Integer}, flags::Union{ImPlotLegendFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L893).
"""
function SetupLegend(location::Union{ImPlotLocation_,Integer}, flags::Union{ImPlotLegendFlags_,Integer} = 0)
    ccall((:ImPlot_SetupLegend, libcimgui), Cvoid, (ImPlotLocation, ImPlotLegendFlags), location, flags)
end

"""
    SetupMouseText(location::Union{ImPlotLocation_, Integer}, flags::Union{ImPlotMouseTextFlags_, Integer} = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L895).
"""
function SetupMouseText(location::Union{ImPlotLocation_,Integer}, flags::Union{ImPlotMouseTextFlags_,Integer} = 0)
    ccall((:ImPlot_SetupMouseText, libcimgui), Cvoid, (ImPlotLocation, ImPlotMouseTextFlags), location, flags)
end

"""
    SetupFinish()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L899).
"""
function SetupFinish()
    ccall((:ImPlot_SetupFinish, libcimgui), Cvoid, ())
end

"""
    SetNextAxisLimits(axis::Union{ImAxis_, Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L925).
"""
function SetNextAxisLimits(axis::Union{ImAxis_,Integer}, v_min::Real, v_max::Real, cond = ImPlotCond_Once)
    ccall(
        (:ImPlot_SetNextAxisLimits, libcimgui),
        Cvoid,
        (ImAxis, Cdouble, Cdouble, ImPlotCond),
        axis,
        v_min,
        v_max,
        cond,
    )
end

"""
    SetNextAxisLinks(axis::Union{ImAxis_, Integer}, link_min::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, link_max::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L927).
"""
function SetNextAxisLinks(
    axis::Union{ImAxis_,Integer},
    link_min::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    link_max::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
)
    ccall((:ImPlot_SetNextAxisLinks, libcimgui), Cvoid, (ImAxis, Ptr{Cdouble}, Ptr{Cdouble}), axis, link_min, link_max)
end

"""
    SetNextAxisToFit(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L929).
"""
function SetNextAxisToFit(axis::Union{ImAxis_,Integer})
    ccall((:ImPlot_SetNextAxisToFit, libcimgui), Cvoid, (ImAxis,), axis)
end

"""
    SetNextAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L932).
"""
function SetNextAxesLimits(x_min::Real, x_max::Real, y_min::Real, y_max::Real, cond = ImPlotCond_Once)
    ccall(
        (:ImPlot_SetNextAxesLimits, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, Cdouble, Cdouble, ImPlotCond),
        x_min,
        x_max,
        y_min,
        y_max,
        cond,
    )
end

"""
    SetNextAxesToFit()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L934).
"""
function SetNextAxesToFit()
    ccall((:ImPlot_SetNextAxesToFit, libcimgui), Cvoid, ())
end

"""
    PlotLine(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L989).
"""
function PlotLine(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_FloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_doublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_S64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLine(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L990).
"""
function PlotLine(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotLine_U64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotLineG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L991).
"""
function PlotLineG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotLineG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, Cint, ImPlotSpec),
        label_id,
        getter,
        data,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L994).
"""
function PlotScatter(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_FloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_doublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_S64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatter(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L995).
"""
function PlotScatter(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotScatter_U64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotScatterG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L996).
"""
function PlotScatterG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotScatterG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, Cint, ImPlotSpec),
        label_id,
        getter,
        data,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, szs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    szs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_FloatPtrFloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, szs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    szs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_doublePtrdoublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, szs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    szs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S8PtrS8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, szs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    szs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U8PtrU8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, szs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    szs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S16PtrS16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, szs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    szs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U16PtrU16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, szs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    szs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S32PtrS32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, szs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    szs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U32PtrU32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, szs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    szs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S64PtrS64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, szs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L999).
"""
function PlotBubbles(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    szs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U64PtrU64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        szs,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, szs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    szs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_FloatPtrFloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, szs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    szs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_doublePtrdoublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, szs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    szs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S8PtrS8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, szs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    szs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U8PtrU8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, szs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    szs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S16PtrS16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, szs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    szs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U16PtrU16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, szs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    szs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S32PtrS32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, szs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    szs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U32PtrU32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, szs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    szs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_S64PtrS64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotBubbles(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, szs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1000).
"""
function PlotBubbles(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    szs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBubbles_U64PtrU64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        szs,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_FloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_doublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_S8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_U8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_S16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_U16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_S32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_U32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_S64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotPolygon(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1003).
"""
function PlotPolygon(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPolygon_U64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1006).
"""
function PlotStairs(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_FloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_doublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_S64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairs(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1007).
"""
function PlotStairs(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStairs_U64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotStairsG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1008).
"""
function PlotStairsG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotStairsG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, Cint, ImPlotSpec),
        label_id,
        getter,
        data,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, yref::Real = 0, xscale::Real = 1, xstart::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1011).
"""
function PlotShaded(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    yref::Real = 0,
    xscale::Real = 1,
    xstart::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        yref,
        xscale,
        xstart,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_FloatPtrFloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_doublePtrdoublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S8PtrS8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U8PtrU8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S16PtrS16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U16PtrU16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S32PtrS32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U32PtrU32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S64PtrS64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, yref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1012).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    yref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U64PtrU64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        yref,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys1::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys2::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys1::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys2::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_FloatPtrFloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys1::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys2::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys1::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys2::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys1::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys2::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S8PtrS8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys1::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys2::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys1::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys2::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U8PtrU8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys1::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys2::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys1::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys2::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S16PtrS16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys1::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys2::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys1::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys2::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U16PtrU16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys1::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys2::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys1::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys2::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S32PtrS32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys1::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys2::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys1::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys2::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U32PtrU32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys1::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys2::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys1::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys2::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_S64PtrS64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShaded(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys1::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys2::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1013).
"""
function PlotShaded(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys1::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys2::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShaded_U64PtrU64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys1,
        ys2,
        count,
        spec,
    )
end

"""
    PlotShadedG(label_id, getter1::ImPlotGetter, data1, getter2::ImPlotGetter, data2, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1014).
"""
function PlotShadedG(
    label_id,
    getter1::ImPlotGetter,
    data1,
    getter2::ImPlotGetter,
    data2,
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotShadedG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, ImPlotGetter, Ptr{Cvoid}, Cint, ImPlotSpec),
        label_id,
        getter1,
        data1,
        getter2,
        data2,
        count,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bar_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1017).
"""
function PlotBars(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bar_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        bar_size,
        shift,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_FloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_doublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_S64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1018).
"""
function PlotBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bar_size::Real,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBars_U64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBarsG(label_id, getter::ImPlotGetter, data, count::Integer, bar_size::Real, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1019).
"""
function PlotBarsG(label_id, getter::ImPlotGetter, data, count::Integer, bar_size::Real, spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotBarsG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, Cint, Cdouble, ImPlotSpec),
        label_id,
        getter,
        data,
        count,
        bar_size,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_FloatPtr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cfloat}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_doublePtr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cdouble}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_S8Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS8}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_U8Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU8}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_S16Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS16}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_U16Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU16}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_S32Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS32}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_U32Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU32}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_S64Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS64}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotBarGroups(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, item_count::Integer, group_count::Integer, group_size::Real = 0.67, shift::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1022).
"""
function PlotBarGroups(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    item_count::Integer,
    group_count::Integer,
    group_size::Real = 0.67,
    shift::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotBarGroups_U64Ptr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU64}, Cint, Cint, Cdouble, Cdouble, ImPlotSpec),
        label_ids,
        values,
        item_count,
        group_count,
        group_size,
        shift,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, err::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    err::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, err::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    err::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, err::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    err::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, err::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    err::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, err::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    err::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, err::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    err::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, err::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    err::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, err::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    err::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, err::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    err::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, err::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1025).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    err::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        err,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, neg::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, pos::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    neg::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    pos::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, neg::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, pos::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    neg::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    pos::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, neg::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, pos::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    neg::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    pos::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, neg::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, pos::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    neg::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    pos::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, neg::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, pos::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    neg::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    pos::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, neg::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, pos::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    neg::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    pos::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, neg::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, pos::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    neg::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    pos::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, neg::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, pos::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    neg::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    pos::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, neg::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, pos::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    neg::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    pos::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotErrorBars(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, neg::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, pos::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1026).
"""
function PlotErrorBars(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    neg::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    pos::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        neg,
        pos,
        count,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_FloatPtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_doublePtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U8PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U16PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U32PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, ref::Real = 0, scale::Real = 1, start::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1029).
"""
function PlotStems(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    ref::Real = 0,
    scale::Real = 1,
    start::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U64PtrInt, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotSpec),
        label_id,
        values,
        count,
        ref,
        scale,
        start,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_FloatPtrFloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_doublePtrdoublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S8PtrS8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U8PtrU8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S16PtrS16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U16PtrU16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S32PtrS32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U32PtrU32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_S64PtrS64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotStems(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, ref::Real = 0, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1030).
"""
function PlotStems(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    ref::Real = 0,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotStems_U64PtrU64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        ref,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_FloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_doublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_S8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_U8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_S16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_U16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_S32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_U32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_S64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotInfLines(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1033).
"""
function PlotInfLines(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotInfLines_U64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        values,
        count,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_FloatPtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_doublePtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S8PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U8PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S16PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U16PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S32PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U32PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S64PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x::Real, y::Real, radius::Real, fmt::ImPlotFormatter, fmt_data, angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1036).
"""
function PlotPieChart(
    label_ids::Union{Ptr{Nothing},String,AbstractArray{String}},
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    x::Real,
    y::Real,
    radius::Real,
    fmt::ImPlotFormatter,
    fmt_data,
    angle0::Real = 90,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U64PtrPlotFormatter, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        fmt,
        fmt_data,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_FloatPtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_doublePtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S8PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U8PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S16PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U16PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S32PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U32PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_S64PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotPieChart(label_ids::Union{Ptr{Nothing}, String, AbstractArray{String}}, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x::Real, y::Real, radius::Real, label_fmt = "%.1f", angle0::Real = 90, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1037).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotPieChart_U64PtrStr, libcimgui),
        Cvoid,
        (Ptr{Cstring}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, Cstring, Cdouble, ImPlotSpec),
        label_ids,
        values,
        count,
        x,
        y,
        radius,
        label_fmt,
        angle0,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_FloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_doublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_S8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_U8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_S16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_U16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_S32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_U32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_S64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHeatmap(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, rows::Integer, cols::Integer, scale_min::Real = 0, scale_max::Real = 0, label_fmt = "%.1f", bounds_min::ImPlotPoint = ImPlotPoint(0, 0), bounds_max::ImPlotPoint = ImPlotPoint(1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1040).
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
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHeatmap_U64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Cint, Cint, Cdouble, Cdouble, Cstring, ImPlotPoint, ImPlotPoint, ImPlotSpec),
        label_id,
        values,
        rows,
        cols,
        scale_min,
        scale_max,
        label_fmt,
        bounds_min,
        bounds_max,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_FloatPtr, libcimgui),
        Cdouble,
        (Cstring, Ptr{Cfloat}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_doublePtr, libcimgui),
        Cdouble,
        (Cstring, Ptr{Cdouble}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_S8Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS8}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_U8Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU8}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_S16Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS16}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_U16Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU16}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_S32Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS32}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_U32Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU32}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_S64Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS64}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram(label_id, values::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, bins::Integer = ImPlotBin_Sturges, bar_scale::Real = 1.0, range::ImPlotRange = ImPlotRange(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1044).
"""
function PlotHistogram(
    label_id,
    values::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    bins::Integer = ImPlotBin_Sturges,
    bar_scale::Real = 1.0,
    range::ImPlotRange = ImPlotRange(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram_U64Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU64}, Cint, Cint, Cdouble, ImPlotRange, ImPlotSpec),
        label_id,
        values,
        count,
        bins,
        bar_scale,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_FloatPtr, libcimgui),
        Cdouble,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_doublePtr, libcimgui),
        Cdouble,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_S8Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_U8Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_S16Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_U16Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_S32Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_U32Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_S64Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotHistogram2D(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, x_bins::Integer = ImPlotBin_Sturges, y_bins::Integer = ImPlotBin_Sturges, range::ImPlotRect = ImPlotRect(), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1048).
"""
function PlotHistogram2D(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    x_bins::Integer = ImPlotBin_Sturges,
    y_bins::Integer = ImPlotBin_Sturges,
    range::ImPlotRect = ImPlotRect(),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotHistogram2D_U64Ptr, libcimgui),
        Cdouble,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint, ImPlotRect, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        x_bins,
        y_bins,
        range,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, ys::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    ys::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_FloatPtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, ys::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    ys::Union{Ptr{Cdouble},Ref{Cdouble},AbstractArray{Cdouble}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_doublePtr, libcimgui),
        Cvoid,
        (Cstring, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, ys::Union{Ptr{ImS8}, Ref{ImS8}, AbstractArray{ImS8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    ys::Union{Ptr{ImS8},Ref{ImS8},AbstractArray{ImS8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_S8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, ys::Union{Ptr{ImU8}, Ref{ImU8}, AbstractArray{ImU8}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    ys::Union{Ptr{ImU8},Ref{ImU8},AbstractArray{ImU8}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_U8Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, ys::Union{Ptr{ImS16}, Ref{ImS16}, AbstractArray{ImS16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    ys::Union{Ptr{ImS16},Ref{ImS16},AbstractArray{ImS16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_S16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, ys::Union{Ptr{ImU16}, Ref{ImU16}, AbstractArray{ImU16}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    ys::Union{Ptr{ImU16},Ref{ImU16},AbstractArray{ImU16}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_U16Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, ys::Union{Ptr{ImS32}, Ref{ImS32}, AbstractArray{ImS32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    ys::Union{Ptr{ImS32},Ref{ImS32},AbstractArray{ImS32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_S32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, ys::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    ys::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_U32Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, ys::Union{Ptr{ImS64}, Ref{ImS64}, AbstractArray{ImS64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    ys::Union{Ptr{ImS64},Ref{ImS64},AbstractArray{ImS64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_S64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigital(label_id, xs::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, ys::Union{Ptr{ImU64}, Ref{ImU64}, AbstractArray{ImU64}}, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1051).
"""
function PlotDigital(
    label_id,
    xs::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    ys::Union{Ptr{ImU64},Ref{ImU64},AbstractArray{ImU64}},
    count::Integer,
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotDigital_U64Ptr, libcimgui),
        Cvoid,
        (Cstring, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotSpec),
        label_id,
        xs,
        ys,
        count,
        spec,
    )
end

"""
    PlotDigitalG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1052).
"""
function PlotDigitalG(label_id, getter::ImPlotGetter, data, count::Integer, spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotDigitalG, libcimgui),
        Cvoid,
        (Cstring, ImPlotGetter, Ptr{Cvoid}, Cint, ImPlotSpec),
        label_id,
        getter,
        data,
        count,
        spec,
    )
end

"""
    PlotImage(label_id, tex_ref::ImTextureRef, bounds_min::ImPlotPoint, bounds_max::ImPlotPoint, uv0::ImVec2 = ImVec2(0, 0), uv1::ImVec2 = ImVec2(1, 1), tint_col::ImVec4 = ImVec4(1, 1, 1, 1), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1056).
"""
function PlotImage(
    label_id,
    tex_ref::ImTextureRef,
    bounds_min::ImPlotPoint,
    bounds_max::ImPlotPoint,
    uv0::ImVec2 = ImVec2(0, 0),
    uv1::ImVec2 = ImVec2(1, 1),
    tint_col::ImVec4 = ImVec4(1, 1, 1, 1),
    spec = ImPlotSpec(),
)
    ccall(
        (:ImPlot_PlotImage, libcimgui),
        Cvoid,
        (Cstring, ImTextureRef, ImPlotPoint, ImPlotPoint, ImVec2, ImVec2, ImVec4, ImPlotSpec),
        label_id,
        tex_ref,
        bounds_min,
        bounds_max,
        uv0,
        uv1,
        tint_col,
        spec,
    )
end

"""
    PlotText(text, x::Real, y::Real, pix_offset::ImVec2 = ImVec2(0, 0), spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1062).
"""
function PlotText(text, x::Real, y::Real, pix_offset::ImVec2 = ImVec2(0, 0), spec = ImPlotSpec())
    ccall(
        (:ImPlot_PlotText, libcimgui),
        Cvoid,
        (Cstring, Cdouble, Cdouble, ImVec2, ImPlotSpec),
        text,
        x,
        y,
        pix_offset,
        spec,
    )
end

"""
    PlotDummy(label_id, spec = ImPlotSpec())

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1065).
"""
function PlotDummy(label_id, spec = ImPlotSpec())
    ccall((:ImPlot_PlotDummy, libcimgui), Cvoid, (Cstring, ImPlotSpec), label_id, spec)
end

"""
    DragPoint(id::Integer, x::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, size::Real = 4, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1078).
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
    ccall(
        (:ImPlot_DragPoint, libcimgui),
        Bool,
        (Cint, Ptr{Cdouble}, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}),
        id,
        x,
        y,
        col,
        size,
        flags,
        out_clicked,
        out_hovered,
        out_held,
    )
end

"""
    DragLineX(id::Integer, x::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, thickness::Real = 1, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1080).
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
    ccall(
        (:ImPlot_DragLineX, libcimgui),
        Bool,
        (Cint, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}),
        id,
        x,
        col,
        thickness,
        flags,
        out_clicked,
        out_hovered,
        out_held,
    )
end

"""
    DragLineY(id::Integer, y::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, thickness::Real = 1, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1082).
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
    ccall(
        (:ImPlot_DragLineY, libcimgui),
        Bool,
        (Cint, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}),
        id,
        y,
        col,
        thickness,
        flags,
        out_clicked,
        out_hovered,
        out_held,
    )
end

"""
    DragRect(id::Integer, x1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y1::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, x2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, y2::Union{Ptr{Cdouble}, Ref{Cdouble}, AbstractArray{Cdouble}}, col::ImVec4, flags::Union{ImPlotDragToolFlags_, Integer} = 0, out_clicked = C_NULL, out_hovered = C_NULL, out_held = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1084).
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
    ccall(
        (:ImPlot_DragRect, libcimgui),
        Bool,
        (
            Cint,
            Ptr{Cdouble},
            Ptr{Cdouble},
            Ptr{Cdouble},
            Ptr{Cdouble},
            ImVec4,
            ImPlotDragToolFlags,
            Ptr{Bool},
            Ptr{Bool},
            Ptr{Bool},
        ),
        id,
        x1,
        y1,
        x2,
        y2,
        col,
        flags,
        out_clicked,
        out_hovered,
        out_held,
    )
end

"""
    Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, clamp::Bool, round = false)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1087).
"""
function Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, clamp::Bool, round = false)
    ccall(
        (:ImPlot_Annotation_Bool, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Bool),
        x,
        y,
        col,
        pix_offset,
        clamp,
        round,
    )
end

"""
    TagX(x::Real, col::ImVec4, round = false)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1092).
"""
function TagX(x::Real, col::ImVec4, round = false)
    ccall((:ImPlot_TagX_Bool, libcimgui), Cvoid, (Cdouble, ImVec4, Bool), x, col, round)
end

"""
    TagY(y::Real, col::ImVec4, round = false)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1097).
"""
function TagY(y::Real, col::ImVec4, round = false)
    ccall((:ImPlot_TagY_Bool, libcimgui), Cvoid, (Cdouble, ImVec4, Bool), y, col, round)
end

"""
    SetAxis(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1106).
"""
function SetAxis(axis::Union{ImAxis_,Integer})
    ccall((:ImPlot_SetAxis, libcimgui), Cvoid, (ImAxis,), axis)
end

"""
    SetAxes(x_axis::Union{ImAxis_, Integer}, y_axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1107).
"""
function SetAxes(x_axis::Union{ImAxis_,Integer}, y_axis::Union{ImAxis_,Integer})
    ccall((:ImPlot_SetAxes, libcimgui), Cvoid, (ImAxis, ImAxis), x_axis, y_axis)
end

"""
    PixelsToPlot(pix::ImVec2, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1110).
"""
function PixelsToPlot(
    pix::ImVec2,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    ccall((:ImPlot_PixelsToPlot_Vec2, libcimgui), ImPlotPoint, (ImVec2, ImAxis, ImAxis), pix, x_axis, y_axis)
end

"""
    PixelsToPlot(x::Real, y::Real, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1111).
"""
function PixelsToPlot(
    x::Real,
    y::Real,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    ccall((:ImPlot_PixelsToPlot_Float, libcimgui), ImPlotPoint, (Cfloat, Cfloat, ImAxis, ImAxis), x, y, x_axis, y_axis)
end

"""
    PlotToPixels(plt::ImPlotPoint, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1114).
"""
function PlotToPixels(
    plt::ImPlotPoint,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    ccall((:ImPlot_PlotToPixels_PlotPoint, libcimgui), ImVec2, (ImPlotPoint, ImAxis, ImAxis), plt, x_axis, y_axis)
end

"""
    PlotToPixels(x::Real, y::Real, x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1115).
"""
function PlotToPixels(
    x::Real,
    y::Real,
    x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
    y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO,
)
    ccall((:ImPlot_PlotToPixels_double, libcimgui), ImVec2, (Cdouble, Cdouble, ImAxis, ImAxis), x, y, x_axis, y_axis)
end

"""
    GetPlotPos()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1118).
"""
function GetPlotPos()
    ccall((:ImPlot_GetPlotPos, libcimgui), ImVec2, ())
end

"""
    GetPlotSize()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1120).
"""
function GetPlotSize()
    ccall((:ImPlot_GetPlotSize, libcimgui), ImVec2, ())
end

"""
    GetPlotMousePos(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1123).
"""
function GetPlotMousePos(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_GetPlotMousePos, libcimgui), ImPlotPoint, (ImAxis, ImAxis), x_axis, y_axis)
end

"""
    GetPlotLimits(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1125).
"""
function GetPlotLimits(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_GetPlotLimits, libcimgui), ImPlotRect, (ImAxis, ImAxis), x_axis, y_axis)
end

"""
    IsPlotHovered()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1128).
"""
function IsPlotHovered()
    ccall((:ImPlot_IsPlotHovered, libcimgui), Bool, ())
end

"""
    IsAxisHovered(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1130).
"""
function IsAxisHovered(axis::Union{ImAxis_,Integer})
    ccall((:ImPlot_IsAxisHovered, libcimgui), Bool, (ImAxis,), axis)
end

"""
    IsSubplotsHovered()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1132).
"""
function IsSubplotsHovered()
    ccall((:ImPlot_IsSubplotsHovered, libcimgui), Bool, ())
end

"""
    IsPlotSelected()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1135).
"""
function IsPlotSelected()
    ccall((:ImPlot_IsPlotSelected, libcimgui), Bool, ())
end

"""
    GetPlotSelection(x_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1137).
"""
function GetPlotSelection(x_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO, y_axis::Union{ImAxis_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_GetPlotSelection, libcimgui), ImPlotRect, (ImAxis, ImAxis), x_axis, y_axis)
end

"""
    CancelPlotSelection()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1139).
"""
function CancelPlotSelection()
    ccall((:ImPlot_CancelPlotSelection, libcimgui), Cvoid, ())
end

"""
    HideNextItem(hidden = true, cond = ImPlotCond_Once)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1143).
"""
function HideNextItem(hidden = true, cond = ImPlotCond_Once)
    ccall((:ImPlot_HideNextItem, libcimgui), Cvoid, (Bool, ImPlotCond), hidden, cond)
end

"""
    BeginAlignedPlots(group_id, vertical = true)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1152).
"""
function BeginAlignedPlots(group_id, vertical = true)
    ccall((:ImPlot_BeginAlignedPlots, libcimgui), Bool, (Cstring, Bool), group_id, vertical)
end

"""
    EndAlignedPlots()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1154).
"""
function EndAlignedPlots()
    ccall((:ImPlot_EndAlignedPlots, libcimgui), Cvoid, ())
end

"""
    BeginLegendPopup(label_id, mouse_button = 1)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1161).
"""
function BeginLegendPopup(label_id, mouse_button = 1)
    ccall((:ImPlot_BeginLegendPopup, libcimgui), Bool, (Cstring, ImGuiMouseButton), label_id, mouse_button)
end

"""
    EndLegendPopup()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1163).
"""
function EndLegendPopup()
    ccall((:ImPlot_EndLegendPopup, libcimgui), Cvoid, ())
end

"""
    IsLegendEntryHovered(label_id)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1165).
"""
function IsLegendEntryHovered(label_id)
    ccall((:ImPlot_IsLegendEntryHovered, libcimgui), Bool, (Cstring,), label_id)
end

"""
    BeginDragDropTargetPlot()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1172).
"""
function BeginDragDropTargetPlot()
    ccall((:ImPlot_BeginDragDropTargetPlot, libcimgui), Bool, ())
end

"""
    BeginDragDropTargetAxis(axis::Union{ImAxis_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1174).
"""
function BeginDragDropTargetAxis(axis::Union{ImAxis_,Integer})
    ccall((:ImPlot_BeginDragDropTargetAxis, libcimgui), Bool, (ImAxis,), axis)
end

"""
    BeginDragDropTargetLegend()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1176).
"""
function BeginDragDropTargetLegend()
    ccall((:ImPlot_BeginDragDropTargetLegend, libcimgui), Bool, ())
end

"""
    EndDragDropTarget()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1178).
"""
function EndDragDropTarget()
    ccall((:ImPlot_EndDragDropTarget, libcimgui), Cvoid, ())
end

"""
    BeginDragDropSourcePlot(flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1184).
"""
function BeginDragDropSourcePlot(flags = 0)
    ccall((:ImPlot_BeginDragDropSourcePlot, libcimgui), Bool, (ImGuiDragDropFlags,), flags)
end

"""
    BeginDragDropSourceAxis(axis::Union{ImAxis_, Integer}, flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1186).
"""
function BeginDragDropSourceAxis(axis::Union{ImAxis_,Integer}, flags = 0)
    ccall((:ImPlot_BeginDragDropSourceAxis, libcimgui), Bool, (ImAxis, ImGuiDragDropFlags), axis, flags)
end

"""
    BeginDragDropSourceItem(label_id, flags = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1188).
"""
function BeginDragDropSourceItem(label_id, flags = 0)
    ccall((:ImPlot_BeginDragDropSourceItem, libcimgui), Bool, (Cstring, ImGuiDragDropFlags), label_id, flags)
end

"""
    EndDragDropSource()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1190).
"""
function EndDragDropSource()
    ccall((:ImPlot_EndDragDropSource, libcimgui), Cvoid, ())
end

"""
    GetStyle()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1209).
"""
function GetStyle()
    ccall((:ImPlot_GetStyle, libcimgui), Ptr{ImPlotStyle}, ())
end

"""
    StyleColorsAuto(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1212).
"""
function StyleColorsAuto(dst)
    ccall((:ImPlot_StyleColorsAuto, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

"""
    StyleColorsClassic(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1214).
"""
function StyleColorsClassic(dst)
    ccall((:ImPlot_StyleColorsClassic, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

"""
    StyleColorsDark(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1216).
"""
function StyleColorsDark(dst)
    ccall((:ImPlot_StyleColorsDark, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

"""
    StyleColorsLight(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1218).
"""
function StyleColorsLight(dst)
    ccall((:ImPlot_StyleColorsLight, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

"""
    PushStyleColor(idx::Union{ImPlotCol_, Integer}, col::Integer)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1225).
"""
function PushStyleColor(idx::Union{ImPlotCol_,Integer}, col::Integer)
    ccall((:ImPlot_PushStyleColor_U32, libcimgui), Cvoid, (ImPlotCol, ImU32), idx, col)
end

"""
    PushStyleColor(idx::Union{ImPlotCol_, Integer}, col::ImVec4)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1226).
"""
function PushStyleColor(idx::Union{ImPlotCol_,Integer}, col::ImVec4)
    ccall((:ImPlot_PushStyleColor_Vec4, libcimgui), Cvoid, (ImPlotCol, ImVec4), idx, col)
end

"""
    PopStyleColor(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1228).
"""
function PopStyleColor(count::Integer = 1)
    ccall((:ImPlot_PopStyleColor, libcimgui), Cvoid, (Cint,), count)
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::Real)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1231).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::Real)
    ccall((:ImPlot_PushStyleVar_Float, libcimgui), Cvoid, (ImPlotStyleVar, Cfloat), idx, val)
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::Integer)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1233).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::Integer)
    ccall((:ImPlot_PushStyleVar_Int, libcimgui), Cvoid, (ImPlotStyleVar, Cint), idx, val)
end

"""
    PushStyleVar(idx::Union{ImPlotStyleVar_, Integer}, val::ImVec2)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1235).
"""
function PushStyleVar(idx::Union{ImPlotStyleVar_,Integer}, val::ImVec2)
    ccall((:ImPlot_PushStyleVar_Vec2, libcimgui), Cvoid, (ImPlotStyleVar, ImVec2), idx, val)
end

"""
    PopStyleVar(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1237).
"""
function PopStyleVar(count::Integer = 1)
    ccall((:ImPlot_PopStyleVar, libcimgui), Cvoid, (Cint,), count)
end

"""
    GetLastItemColor()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1240).
"""
function GetLastItemColor()
    ccall((:ImPlot_GetLastItemColor, libcimgui), ImVec4, ())
end

"""
    GetStyleColorName(idx::Union{ImPlotCol_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1243).
"""
function GetStyleColorName(idx::Union{ImPlotCol_,Integer})
    ccall((:ImPlot_GetStyleColorName, libcimgui), Cstring, (ImPlotCol,), idx)
end

"""
    GetMarkerName(idx::Union{ImPlotMarker_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1245).
"""
function GetMarkerName(idx::Union{ImPlotMarker_,Integer})
    ccall((:ImPlot_GetMarkerName, libcimgui), Cstring, (ImPlotMarker,), idx)
end

"""
    NextMarker()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1248).
"""
function NextMarker()
    ccall((:ImPlot_NextMarker, libcimgui), ImPlotMarker, ())
end

"""
    AddColormap(name, cols::Union{ImVec4, AbstractArray{ImVec4}}, size::Integer, qual = true)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1269).
"""
function AddColormap(name, cols::Union{ImVec4,AbstractArray{ImVec4}}, size::Integer, qual = true)
    ccall(
        (:ImPlot_AddColormap_Vec4Ptr, libcimgui),
        ImPlotColormap,
        (Cstring, Ptr{ImVec4}, Cint, Bool),
        name,
        cols,
        size,
        qual,
    )
end

"""
    AddColormap(name, cols::Union{Ptr{ImU32}, Ref{ImU32}, AbstractArray{ImU32}}, size::Integer, qual = true)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1270).
"""
function AddColormap(name, cols::Union{Ptr{ImU32},Ref{ImU32},AbstractArray{ImU32}}, size::Integer, qual = true)
    ccall(
        (:ImPlot_AddColormap_U32Ptr, libcimgui),
        ImPlotColormap,
        (Cstring, Ptr{ImU32}, Cint, Bool),
        name,
        cols,
        size,
        qual,
    )
end

"""
    GetColormapCount()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1273).
"""
function GetColormapCount()
    ccall((:ImPlot_GetColormapCount, libcimgui), Cint, ())
end

"""
    GetColormapName(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1275).
"""
function GetColormapName(cmap::Union{ImPlotColormap_,Integer})
    ccall((:ImPlot_GetColormapName, libcimgui), Cstring, (ImPlotColormap,), cmap)
end

"""
    GetColormapIndex(name)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1277).
"""
function GetColormapIndex(name)
    ccall((:ImPlot_GetColormapIndex, libcimgui), ImPlotColormap, (Cstring,), name)
end

"""
    PushColormap(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1280).
"""
function PushColormap(cmap::Union{ImPlotColormap_,Integer})
    ccall((:ImPlot_PushColormap_PlotColormap, libcimgui), Cvoid, (ImPlotColormap,), cmap)
end

"""
    PushColormap(name)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1282).
"""
function PushColormap(name)
    ccall((:ImPlot_PushColormap_Str, libcimgui), Cvoid, (Cstring,), name)
end

"""
    PopColormap(count::Integer = 1)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1284).
"""
function PopColormap(count::Integer = 1)
    ccall((:ImPlot_PopColormap, libcimgui), Cvoid, (Cint,), count)
end

"""
    NextColormapColor()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1288).
"""
function NextColormapColor()
    ccall((:ImPlot_NextColormapColor, libcimgui), ImVec4, ())
end

"""
    GetColormapSize(cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1294).
"""
function GetColormapSize(cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_GetColormapSize, libcimgui), Cint, (ImPlotColormap,), cmap)
end

"""
    GetColormapColor(idx::Integer, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1296).
"""
function GetColormapColor(idx::Integer, cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_GetColormapColor, libcimgui), ImVec4, (Cint, ImPlotColormap), idx, cmap)
end

"""
    SampleColormap(t::Real, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1298).
"""
function SampleColormap(t::Real, cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_SampleColormap, libcimgui), ImVec4, (Cfloat, ImPlotColormap), t, cmap)
end

"""
    ColormapScale(label, scale_min::Real, scale_max::Real, size::ImVec2 = ImVec2(0, 0), format = "%g", flags::Union{ImPlotColormapScaleFlags_, Integer} = 0, cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1301).
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
    ccall(
        (:ImPlot_ColormapScale, libcimgui),
        Cvoid,
        (Cstring, Cdouble, Cdouble, ImVec2, Cstring, ImPlotColormapScaleFlags, ImPlotColormap),
        label,
        scale_min,
        scale_max,
        size,
        format,
        flags,
        cmap,
    )
end

"""
    ColormapSlider(label, t::Union{Ptr{Cfloat}, Ref{Cfloat}, AbstractArray{Cfloat}}, out, format = "", cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1303).
"""
function ColormapSlider(
    label,
    t::Union{Ptr{Cfloat},Ref{Cfloat},AbstractArray{Cfloat}},
    out,
    format = "",
    cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO,
)
    ccall(
        (:ImPlot_ColormapSlider, libcimgui),
        Bool,
        (Cstring, Ptr{Cfloat}, Ptr{ImVec4}, Cstring, ImPlotColormap),
        label,
        t,
        out,
        format,
        cmap,
    )
end

"""
    ColormapButton(label, size::ImVec2 = ImVec2(0, 0), cmap::Union{ImPlotColormap_, Integer} = IMPLOT_AUTO)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1305).
"""
function ColormapButton(label, size::ImVec2 = ImVec2(0, 0), cmap::Union{ImPlotColormap_,Integer} = IMPLOT_AUTO)
    ccall((:ImPlot_ColormapButton, libcimgui), Bool, (Cstring, ImVec2, ImPlotColormap), label, size, cmap)
end

"""
    BustColorCache(plot_title_id = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1314).
"""
function BustColorCache(plot_title_id = C_NULL)
    ccall((:ImPlot_BustColorCache, libcimgui), Cvoid, (Cstring,), plot_title_id)
end

"""
    GetInputMap()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1321).
"""
function GetInputMap()
    ccall((:ImPlot_GetInputMap, libcimgui), Ptr{ImPlotInputMap}, ())
end

"""
    MapInputDefault(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1324).
"""
function MapInputDefault(dst)
    ccall((:ImPlot_MapInputDefault, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), dst)
end

"""
    MapInputReverse(dst)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1326).
"""
function MapInputReverse(dst)
    ccall((:ImPlot_MapInputReverse, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), dst)
end

"""
    ItemIcon(col::ImVec4)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1333).
"""
function ItemIcon(col::ImVec4)
    ccall((:ImPlot_ItemIcon_Vec4, libcimgui), Cvoid, (ImVec4,), col)
end

"""
    ItemIcon(col::Integer)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1334).
"""
function ItemIcon(col::Integer)
    ccall((:ImPlot_ItemIcon_U32, libcimgui), Cvoid, (ImU32,), col)
end

"""
    ColormapIcon(cmap::Union{ImPlotColormap_, Integer})

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1335).
"""
function ColormapIcon(cmap::Union{ImPlotColormap_,Integer})
    ccall((:ImPlot_ColormapIcon, libcimgui), Cvoid, (ImPlotColormap,), cmap)
end

"""
    GetPlotDrawList()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1338).
"""
function GetPlotDrawList()
    ccall((:ImPlot_GetPlotDrawList, libcimgui), Ptr{ImDrawList}, ())
end

"""
    PushPlotClipRect(expand::Real = 0)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1340).
"""
function PushPlotClipRect(expand::Real = 0)
    ccall((:ImPlot_PushPlotClipRect, libcimgui), Cvoid, (Cfloat,), expand)
end

"""
    PopPlotClipRect()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1342).
"""
function PopPlotClipRect()
    ccall((:ImPlot_PopPlotClipRect, libcimgui), Cvoid, ())
end

"""
    ShowStyleSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1345).
"""
function ShowStyleSelector(label)
    ccall((:ImPlot_ShowStyleSelector, libcimgui), Bool, (Cstring,), label)
end

"""
    ShowColormapSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1347).
"""
function ShowColormapSelector(label)
    ccall((:ImPlot_ShowColormapSelector, libcimgui), Bool, (Cstring,), label)
end

"""
    ShowInputMapSelector(label)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1349).
"""
function ShowInputMapSelector(label)
    ccall((:ImPlot_ShowInputMapSelector, libcimgui), Bool, (Cstring,), label)
end

"""
    ShowStyleEditor(ref)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1351).
"""
function ShowStyleEditor(ref)
    ccall((:ImPlot_ShowStyleEditor, libcimgui), Cvoid, (Ptr{ImPlotStyle},), ref)
end

"""
    ShowUserGuide()

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1353).
"""
function ShowUserGuide()
    ccall((:ImPlot_ShowUserGuide, libcimgui), Cvoid, ())
end

"""
    ShowMetricsWindow(p_popen = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1355).
"""
function ShowMetricsWindow(p_popen = C_NULL)
    ccall((:ImPlot_ShowMetricsWindow, libcimgui), Cvoid, (Ptr{Bool},), p_popen)
end

"""
    ShowDemoWindow(p_open = C_NULL)

[Upstream link](https://github.com/epezent/implot/blob/0.17/implot.h#L1362).
"""
function ShowDemoWindow(p_open = C_NULL)
    ccall((:ImPlot_ShowDemoWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function Annotation(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    ccall(
        (:ImPlot_Annotation_Str, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Cstring),
        x,
        y,
        col,
        pix_offset,
        false,
        fmt,
    )
end

function AnnotationClamped(x::Real, y::Real, pix_offset::ImVec2, fmt::String)
    col = GetLastItemColor()
    ccall(
        (:ImPlot_Annotation_Str, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Cstring),
        x,
        y,
        col,
        pix_offset,
        true,
        fmt,
    )
end

function Annotation(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    ccall(
        (:ImPlot_Annotation_Str, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Cstring),
        x,
        y,
        col,
        pix_offset,
        false,
        fmt,
    )
end

function AnnotationClamped(x::Real, y::Real, col::ImVec4, pix_offset::ImVec2, fmt::String)
    ccall(
        (:ImPlot_Annotation_Str, libcimgui),
        Cvoid,
        (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Cstring),
        x,
        y,
        col,
        pix_offset,
        true,
        fmt,
    )
end


# exports
const PREFIXES = ["ImPlot", "IMPLOT"]
for name in names(@__MODULE__; all = true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end
