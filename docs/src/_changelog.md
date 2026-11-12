```@meta
CurrentModule = ImPlot
```

# Changelog
This documents notable changes in ImPlot.jl. The format is based on [Keep a
Changelog](https://keepachangelog.com).

## [v1.0.0] - 2026-11-12

### Added
- Added `Ptr{T}` accessors for the internal `ImPlotPlot` struct ([#52]).
- The functions from `implot_internal.h` are now wrapped too. They aren't
  exported or public, and their docstrings are marked as internal ([#52]).
- Because the high-level plotting methods are now generated, some plot types
  gained methods that previously had to be called with the low-level API
  ([#52]):
  - [`PlotHistogram()`](@ref) and [`PlotHistogram2D()`](@ref) accept arrays
    directly.
  - [`PlotBars()`](@ref) accepts a single array of values.
  - [`PlotBubbles()`](@ref) accepts values and sizes with an `AbstractRange` or
    `xscale`/`xstart` for the x values.
  - [`PlotBars()`](@ref), [`PlotStems()`](@ref), [`PlotPolygon()`](@ref), and
    [`PlotHistogram2D()`](@ref) accept a vector of structs with field names,
    like [`PlotLine()`](@ref).
  - The single-array methods of [`PlotLine()`](@ref), [`PlotScatter()`](@ref),
    [`PlotStairs()`](@ref), and [`PlotShaded()`](@ref) accept `xscale`/`xstart`
    keyword arguments, and [`PlotStems()`](@ref) accepts `scale`/`start`.

### Changed
- **Breaking**: the high-level plotting methods are now generated
  automatically, and their keyword arguments use the same names as upstream.
  The only rename is the `y_ref` keyword argument of [`PlotShaded()`](@ref),
  which is now `yref` ([#52]).
- **Breaking**: the types, enums, and enum values from `implot_internal.h` are
  no longer exported. They're still accessible with e.g. `ImPlot.ImPlotAxis`,
  but they're internal and may change at any time ([#52]).
- **Breaking**: `void*` user data arguments must now be a `Ptr`, `Ref`, or
  `AbstractArray`. This affects the `data` argument of
  [`SetupAxisFormat()`](@ref), [`SetupAxisScale()`](@ref), and the `PlotXG()`
  functions like [`PlotLineG()`](@ref), and the `fmt_data` argument of
  [`PlotPieChart()`](@ref). This fixes method ambiguities in
  [`PlotPieChart()`](@ref) ([#52]).
- All non-internal functions are now marked as `public` on Julia 1.11+
  ([#52]).

## [v0.8.2] - 2026-10-17

### Changed
- Updated for ImGui 1.93.0, we now require CImGui.jl v10 ([#51]).

## [v0.8.1] - 2026-08-20

### Changed
- Added compat with the latest CImGui release ([#50]).

## [v0.8.0] - 2026-06-18

### Changed
- **Breaking**: Updated to [ImPlot
  1.0](https://github.com/epezent/implot/releases/tag/v1.0) and ImGui 1.92.8.

  Key changes:
  - Every `PlotX` styling now goes through a single by-value `ImPlotSpec` struct
    instead of trailing arguments and functions like
    `SetNextLineStyle`. Construct `ImPlotSpec` with keywords,
    e.g. `PlotLine("x", xs, ys; spec=ImPlotSpec(LineColor=col,
    Marker=ImPlotMarker_Circle))`.
  - New plot types: `PlotInfLines`, `PlotPolygon`, `PlotBubbles`, `PlotBarGroups`.
  - Array lengths of `x` and `y` are required to be the same, `count` is
    automatically derived from `length`.
  - `PlotHeatmap` now takes an `AbstractMatrix` directly instead of
    manually-flattened vector.

## [v0.7.5] - 2026-05-23

### Fixed
- Fixed various internal calls to `PlotLines` ([#48]).

## [v0.7.4] - 2026-05-21

### Fixed
- Fixed calls to low-level `PlotBars` functions ([#47]).

## [v0.7.3] - 2026-05-20

### Fixed
- Fixed calls to low-level `PlotShaded` functions, which were missing arguments
  that caused visual artifacts ([#45]).

## [v0.7.2] - 2026-01-05

### Changed
- Updated to [ImPlot
  0.17](https://github.com/epezent/implot/releases/tag/v0.17)/ImGui 1.92.5
  ([#43]).

## [v0.7.1] - 2025-10-16

### Changed
- Added compat with the latest CImGui release ([#42]).

## [v0.7.0] - 2025-07-09

### Changed
- **Breaking**: We updated to the latest master of ImPlot to support ImGui
  v1.92/CImGui.jl v6. The only breaking change in this release is that
  [`PlotImage()`](@ref) now takes in a `ImTextureRef` instead of an
  `ImTextureID`.

## [v0.6.0] - 2025-02-09

### Changed
- Updated to latest master of ImPlot, fixed compat for CImGui.jl v5.
