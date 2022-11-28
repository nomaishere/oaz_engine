set(CUR_TARGET oaz_engine)
project(${CUR_TARGET} VERSION 0.1.0)

#add_subdirectory(src/metal_renderer)
add_subdirectory(src/platform/app_manager_macos)
add_subdirectory(src/oaz_foundation)

#add_dependencies(app_manager_macos metal_renderer)
