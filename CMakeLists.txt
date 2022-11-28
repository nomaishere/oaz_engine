cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET application)
project(${CUR_TARGET} VERSION 0.1.0)

set(ENGINE_BUILD_TARGET macos)
set(APPLICATION_BUILD_TARGET macos)

add_subdirectory(app)
add_subdirectory(engine)

