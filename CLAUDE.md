# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a C++ port of the JavaScript GeoJSON-VT library for slicing GeoJSON into vector tiles on the fly. The library provides efficient spatial indexing and tile generation from GeoJSON data.

## Build System & Commands

This project uses Make as its build system with Mason for dependency management.

### Essential Commands
- `make` or `make test` - Build and run tests (default target)
- `make bench` - Build and run benchmarks
- `make debug` - Build debug executable with visualization
- `make format` - Format code using clang-format
- `make clean` - Clean build artifacts

### Dependencies
Dependencies are managed via Git submodules for better Swift Package Manager compatibility. Key dependencies include:
- geometry (Mapbox geometry types) - `deps/geometry/`
- geojson (GeoJSON parsing) - `deps/geojson/`
- variant (C++14 variant implementation) - `deps/variant/`
- rapidjson (JSON parsing) - `deps/rapidjson/`
- gtest (for testing) - system dependency
- benchmark (for performance testing) - system dependency

Run `git submodule update --init --recursive` to initialize dependencies.

### Swift Package Manager Integration

This repository is prepared for consumption by Swift Package Manager:

**For Swift Package creators:**
- Include paths are organized in `deps/include/` for easy SPM integration
- Use `geojsonvt-umbrella.h` as the main header for Swift bridging
- Module map available at `module.modulemap`
- All dependencies are header-only and included via git submodules

**Required compiler flags for SPM:**
- `-I include -I deps/include`
- `-std=c++14` (minimum)
- Enable C++ interoperability with `.interoperabilityMode(.Cxx)`

## Architecture

### Core Components

**Main API (`include/mapbox/geojsonvt.hpp`)**:
- `GeoJSONVT` class - Main tile index, handles spatial indexing and tile generation
- `geoJSONToTile()` function - Direct tile generation without indexing
- `Options` and `TileOptions` structs - Configuration parameters

**Internal Types (`include/mapbox/geojsonvt/types.hpp`)**:
- `vt_*` geometry types - Vector tile optimized geometry representations with additional metadata (z-values for simplification, distance/area calculations)
- `vt_feature` - Features with bounding boxes and point counts for efficient processing

**Processing Pipeline**:
1. **convert.hpp** - Converts GeoJSON to internal vt_* types with simplification
2. **wrap.hpp** - Handles coordinate wrapping and line metrics
3. **clip.hpp** - Clips geometries to tile boundaries using Sutherland-Hodgman algorithm
4. **simplify.hpp** - Douglas-Peucker line simplification
5. **tile.hpp** - Final tile generation and serialization

### Key Algorithms

The library implements a hierarchical spatial index where:
- Tiles are generated on-demand through recursive subdivision
- Parent tiles store source features for drilling down to higher zoom levels
- Clipping and simplification are applied at each zoom level
- Features are indexed up to `indexMaxZoom`, then stored as source geometry

## Code Style

- Uses clang-format for formatting (run `make format`)
- C++14 standard
- Header-only implementation in `include/` directory
- Follows Mapbox C++ conventions
- Template specialization for geometry type handling

## Testing & Debugging

- Tests in `test/` directory using Google Test
- Benchmarks in `bench/` directory using Google Benchmark
- Debug visualization available via `make debug` (requires GLFW)
- Test with `./build/test`, benchmark with `./build/bench`