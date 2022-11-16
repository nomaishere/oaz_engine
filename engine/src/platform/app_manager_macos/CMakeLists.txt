cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET app_manager_macos)

find_library(Cocoa Cocoa REQUIRED)
find_library(AppKit AppKit REQUIRED)
find_library(Foundation Foundation REQUIRED)
find_library(Metal Metal REQUIRED)
find_library(CoreVideo CoreVideo REQUIRED)
find_library(QuartzCore QuartzCore REQUIRED)

# find_library(AppKit AppKit HINTS "${CMAKE_SOURCE_DIR}/engine/external_dependencies" REQUIRED)
# find_library(Metal Metal HINTS "${CMAKE_SOURCE_DIR}/engine/external_dependencies" REQUIRED)
# find_library(MetalKit MetalKit HINTS "${CMAKE_SOURCE_DIR}/engine/external_dependencies" REQUIRED)
# find_library(QuartzCore QuartzCore HINTS "${CMAKE_SOURCE_DIR}/engine/external_dependencies" REQUIRED)
# find_library(Foundation Foundation HINTS "${CMAKE_SOURCE_DIR}/engine/external_dependencies" REQUIRED)
# find_library(Metal_Renderer metal_renderer HINTS "${CMAKE_SOURCE_DIR}/cmake-build-debug/engine/src/metal_renderer" REQUIRED)

#file(GLOB_RECURSE APP_MANAGER_MACOS_SOURCE . *.cpp)
#add_library(${CUR_TARGET} STATIC ${APP_MANAGER_MACOS_SOURCE})



#target_include_directories(${CUR_TARGET} PUBLIC
    #    ${CMAKE_SOURCE_DIR}/engine/external_dependencies/metal-cpp
    #    ${CMAKE_SOURCE_DIR}/engine/external_dependencies/metal-cpp-extensions
    #    ${CMAKE_SOURCE_DIR}/engine/src/metal_renderer
#        )

add_compile_definitions(TARGET_MACOS=1)

set(APP_SOURCE_FILE
        ./main.m
        ./Application/AAPLAppDelegate.m
        ./Renderer/AAPLRenderer.m
        ./Renderer/AAPLShaders.metal
        )

set(CUSTOM_SOURCE_HEADER_FILE
        ./Application/OAZView.m
        ./Application/OAZView.h
        ./Application/OAZViewController.m
        ./Application/OAZViewController.h
        )



set(APP_HEADER_FILE
        ./Application/AAPLAppDelegate.h
        ./Application/AAPLConfig.h
        ./Renderer/AAPLRenderer.h
        ./Renderer/AAPLShaderTypes.h)

add_executable(
        ${CUR_TARGET}
        MACOSX_BUNDLE
        ${APP_SOURCE_FILE}
        ${APP_HEADER_FILE}
        ${CUSTOM_SOURCE_HEADER_FILE}
)


# ARC 활성화
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fobjc-arc")

set_target_properties(${CUR_TARGET} PROPERTIES
        BUNDLE True
        MACOSX_BUNDLE_GUI_IDENTIFIER my.domain.style.identifier.${CUR_TARGET}
        MACOSX_BUNDLE_NAME ${CUR_TARGET}
        MACOSX_BUNDLE_BUNDLE_VERSION "0.1"
        MACOSX_BUNDLE_SORT_VERSION_STRING "0.1"
        MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/MacOSXBundleInfo.plist.in
        )

target_link_libraries(${CUR_TARGET} PUBLIC
        ${Cocoa}
        ${CoreVideo}
        ${Metal}
        ${QuartzCore}
        )