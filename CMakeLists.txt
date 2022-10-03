cmake_minimum_required(VERSION 3.23)

set(NAME oaz_engine)
project(${NAME} VERSION 0.1.0)

set(CMAKE_CXX_STANDARD 20)

# Find required package
find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)
find_package(glm REQUIRED)
find_package(spdlog REQUIRED)
find_package(nlohmann_json REQUIRED)

# Automatically add cpp files to list
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/src/*.cpp)
add_executable(${PROJECT_NAME} ${SOURCES})

target_include_directories(${PROJECT_NAME} PUBLIC
        ${PROJECT_SOURCE_DIR}/src
        ${Vulkan_INCLUDE_DIRS}
        ${GLFW_INCLUDE_DIRS}
        ${GLM_PATH}
        )
target_link_directories(${PROJECT_NAME} PUBLIC
        ${Vulkan_LIBRARIES}
        ${GLFW_LIB}
        )
target_link_libraries(${PROJECT_NAME} glfw3 vulkan-1 nlohmann_json::nlohmann_json spdlog::spdlog)

