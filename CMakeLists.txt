cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET oaz_engine)
project(${CUR_TARGET} VERSION 0.1.0)

set(ENGINE_BUILD_TARGET macos)
set(APPLICATION_BUILD_TARGET macos)


# Platform-Specific Dependencies
if(${ENGINE_BUILD_TARGET} STREQUAL "macos")
    find_library(AppKit AppKit REQUIRED)
    find_library(Metal Metal REQUIRED)
    find_library(MetalKit MetalKit REQUIRED)
    find_library(QuartzCore QuartzCore REQUIRED)
    find_library(Foundation Foundation REQUIRED)
elseif(${ENGINE_BUILD_TARGET} STREQUAL "windows")
    find_package(Vulkan REQUIRED)
    find_package(glfw3 REQUIRED)
    find_package(glm REQUIRED)
else()
    message("This is not a supported environment.")
endif()


if(${ENGINE_BUILD_TARGET} STREQUAL "macos")
    message(STATUS "Root Compiler")
    message(STATUS " - ID       \t: ${CMAKE_CXX_COMPILER_ID}")
    message(STATUS " - Version  \t: ${CMAKE_CXX_COMPILER_VERSION}")
    message(STATUS " - Path     \t: ${CMAKE_CXX_COMPILER}")

    message(STATUS "load subdirectories")
    add_subdirectory(src/metal_renderer)
    find_library(Metal_Renderer Metal_Renderer HINTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake-build-debug/src/metal_renderer" REQUIRED)

    file(GLOB_RECURSE APP_MANAGER_MACOS_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/app_manager_macos/*.cpp)
    add_executable(${CUR_TARGET} MACOSX_BUNDLE ${APP_MANAGER_MACOS_SOURCES})

    add_dependencies(${CUR_TARGET} Metal_Renderer)
    set_target_properties(${CUR_TARGET} PROPERTIES
            BUNDLE True
            MACOSX_BUNDLE_GUI_IDENTIFIER my.domain.style.identifier.${CUR_TARGET}
            MACOSX_BUNDLE_NAME ${CUR_TARGET}
            MACOSX_BUNDLE_BUNDLE_VERSION "0.1"
            MACOSX_BUNDLE_SORT_VERSION_STRING "0.1"
            MACOSX_BUNDLE_INFO_PLIST ${CMAKE_SOURCE_DIR}/MacOSXBundleInfo.plist.in
            )

    target_include_directories(${CUR_TARGET} PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/src/app_manager_macos
            ${CMAKE_CURRENT_SOURCE_DIR}/src/metal_renderer
            ${CMAKE_CURRENT_SOURCE_DIR}/external_dependencies/metal-cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/external_dependencies/metal-cpp-extensions
            )

    target_compile_features(${CUR_TARGET} PRIVATE cxx_std_17)

    target_link_libraries(
            ${CUR_TARGET}
            ${AppKit}
            ${Foundation}
            ${QuartzCore}
            ${Metal}
            ${MetalKit}
            ${Metal_Renderer}
    )
endif()
