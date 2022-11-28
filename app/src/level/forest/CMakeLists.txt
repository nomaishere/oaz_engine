cmake_minimum_required(VERSION 3.23)

set(CUR_TARGET l_forest)
project(${CUR_TARGET} VERSION 0.1.0)

find_library(oaz_foundation oaz_foundation HINTS "${CMAKE_SOURCE_DIR}/cmake/release/engine/src/oaz_foundation" REQUIRED)


set(CUR_SOURCE forest.cpp)

add_library(${CUR_TARGET} SHARED ${CUR_SOURCE})
#add_executable(${CUR_TARGET} ${CUR_SOURCE})

target_include_directories(${CUR_TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/engine/src/oaz_foundation ${CMAKE_SOURCE_DIR}/app/src/actor/cube)

target_compile_features(${CUR_TARGET} PRIVATE cxx_std_17)

target_link_libraries(${CUR_TARGET} PUBLIC
        ${oaz_foundation})

