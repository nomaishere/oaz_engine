cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET metal_renderer)
project(${CUR_TARGET} VERSION 0.1.0)

# Dependencies
# find_package(spdlog REQUIRED)
# find_package(nlohmann_json REQUIRED)

find_library(AppKit AppKit REQUIRED)
find_library(Metal Metal REQUIRED)
find_library(MetalKit MetalKit REQUIRED)
find_library(QuartzCore QuartzCore REQUIRED)
find_library(Foundation Foundation REQUIRED)

#file(GLOB_RECURSE METAL_RENDERER_SOURCE . *.cpp)
# add_library(${CUR_TARGET} STATIC ${METAL_RENDERER_SOURCE})

target_include_directories(${CUR_TARGET} PRIVATE
        ${CMAKE_SOURCE_DIR}/engine/external_dependencies/metal-cpp
        ${CMAKE_SOURCE_DIR}/engine/external_dependencies/metal-cpp-extensions
        )

target_compile_features(${CUR_TARGET} PRIVATE cxx_std_17)

target_link_libraries(${CUR_TARGET} PUBLIC
        ${AppKit}
        ${Foundation}
        ${QuartzCore}
        ${Metal}
        ${MetalKit}
        )

message(STATUS "Metal Renderer Compiler")
message(STATUS " - ID       \t: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS " - Version  \t: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS " - Path     \t: ${CMAKE_CXX_COMPILER}")