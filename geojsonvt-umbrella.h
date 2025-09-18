#pragma once

// GeoJSON-VT C++ Library - Umbrella Header for Swift Package Manager
// This header provides a single include point for all GeoJSON-VT functionality

// Note: When using this umbrella header, ensure your include paths are set correctly:
// -I include -I deps/include

// Core GeoJSON-VT headers
#include <mapbox/geojsonvt.hpp>
#include <mapbox/geojsonvt/types.hpp>
#include <mapbox/geojsonvt/convert.hpp>
#include <mapbox/geojsonvt/wrap.hpp>
#include <mapbox/geojsonvt/clip.hpp>
#include <mapbox/geojsonvt/simplify.hpp>
#include <mapbox/geojsonvt/tile.hpp>

// Dependency headers (available via symlinks in deps/include)
#include <mapbox/geometry.hpp>
#include <mapbox/feature.hpp>
#include <mapbox/variant.hpp>
#include <mapbox/geojson.hpp>

// Note: RapidJSON headers are available but not included here as they are only needed
// for specific use cases (JSON parsing). Include "deps/include/rapidjson/..." as needed.