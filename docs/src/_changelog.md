```@meta
CurrentModule = ImPlot
```

# Changelog
This documents notable changes in ImPlot.jl. The format is based on [Keep a
Changelog](https://keepachangelog.com).

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
