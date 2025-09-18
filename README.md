# geojson-vt-cpp

Port to C++ of [JS GeoJSON-VT](https://github.com/mapbox/geojson-vt) for slicing GeoJSON into vector tiles on the fly.

[![Build Status](https://travis-ci.org/mapbox/geojson-vt-cpp.svg?branch=master)](https://travis-ci.org/mapbox/geojson-vt-cpp)

## Building

### Prerequisites

Initialize git submodules to get dependencies:
```bash
git submodule update --init --recursive
```

### Build Commands

- `make` or `make test` - Build and run tests (default target)
- `make bench` - Build and run benchmarks
- `make debug` - Build debug executable with visualization
- `make format` - Format code using clang-format
- `make clean` - Clean build artifacts

## Swift Package Manager

This repository is prepared for consumption by Swift Package Manager. Dependencies are managed via git submodules rather than the Mason package manager for better SPM compatibility.

Key files for SPM integration:
- `geojsonvt-umbrella.h` - Main umbrella header
- `module.modulemap` - Module definition
- `deps/include/` - Organized dependency headers

See [CLAUDE.md](CLAUDE.md) for detailed integration instructions.