cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET app_manager_macos)

find_library(Cocoa Cocoa REQUIRED)
find_library(AppKit AppKit REQUIRED)
find_library(Foundation Foundation REQUIRED)
find_library(Metal Metal REQUIRED)
find_library(CoreVideo CoreVideo REQUIRED)
find_library(QuartzCore QuartzCore REQUIRED)


add_compile_definitions(TARGET_MACOS=1)

set(APP_SOURCE_FILE
        ./main.m
        ./Application/AAPLAppDelegate.m
        ./Renderer/AAPLRenderer.m
        ./Application/OAZWindowDelegate.m
        ./Application/OAZView.m
        ./Application/OAZViewController.m

        )


set(APP_HEADER_FILE
        ./Application/AAPLAppDelegate.h
        ./Application/AAPLConfig.h
        ./Renderer/AAPLRenderer.h
        ./Renderer/AAPLShaderTypes.h
        ./Application/OAZWindowDelegate.h
        ./Application/OAZView.h
        ./Application/OAZViewController.h

        )

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