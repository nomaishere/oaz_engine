cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET first_oaz_app)
project(${CUR_TARGET} VERSION 0.1.0)

find_library(oaz_foundation oaz_foundation HINTS "${CMAKE_SOURCE_DIR}/cmake/release/engine/src/oaz_foundation" REQUIRED)

add_subdirectory(src/actor/cube)
add_subdirectory(src/level/forest)

