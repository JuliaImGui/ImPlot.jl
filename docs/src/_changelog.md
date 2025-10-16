```@meta
CurrentModule = ImPlot
```

# Changelog
This documents notable changes in ImPlot.jl. The format is based on [Keep a
Changelog](https://keepachangelog.com).

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
