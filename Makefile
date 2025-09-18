CXXFLAGS += -I include -I deps/include -std=c++14 -Wall -Wextra -D_GLIBCXX_USE_CXX11_ABI=0
RELEASE_FLAGS ?= -O3 -DNDEBUG -g -ggdb3
DEBUG_FLAGS ?= -g -O0 -DDEBUG

# Using local dependencies via git submodules
BASE_FLAGS = -I deps/include
RAPIDJSON_FLAGS = -I deps/include
GTEST_FLAGS = -lgtest -lpthread
BENCHMARK_FLAGS = -lbenchmark
GLFW_FLAGS = -lglfw -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo

DEPS = deps/include/mapbox/geometry.hpp include/mapbox/geojsonvt/*.hpp include/mapbox/geojsonvt.hpp bench/util.hpp Makefile

default: test

deps/include/mapbox/geometry.hpp: deps/geometry/include/mapbox/geometry.hpp
	@echo "Dependencies are managed via git submodules. Run 'git submodule update --init --recursive' if needed."

build:
	mkdir -p build

build/bench: build bench/main.cpp bench/benchmark.cpp $(DEPS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(RELEASE_FLAGS) bench/main.cpp bench/benchmark.cpp -o build/bench $(BASE_FLAGS) $(RAPIDJSON_FLAGS) $(BENCHMARK_FLAGS)

build/debug: build debug/debug.cpp $(DEPS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(DEBUG_FLAGS) debug/debug.cpp -o build/debug $(BASE_FLAGS) $(GLFW_FLAGS) $(RAPIDJSON_FLAGS)

build/test: build test/*.cpp test/*.hpp $(DEPS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(DEBUG_FLAGS) test/test.cpp test/util.cpp -o build/test $(BASE_FLAGS) $(GTEST_FLAGS) $(RAPIDJSON_FLAGS)

bench: build/bench
	./build/bench

debug: build/debug
	./build/debug

test: build/test
	./build/test

format:
	clang-format include/mapbox/geojsonvt/*.hpp include/mapbox/geojsonvt.hpp test/*.cpp test/*.hpp debug/debug.cpp bench/*.cpp -i

clean:
	rm -rf build
