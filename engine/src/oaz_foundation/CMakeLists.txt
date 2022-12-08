set(CUR_TARGET oaz_foundation)
project(${CUR_TARGET} LANGUAGES CXX VERSION 0.1.0)

set(CUR_HEADER_FILE
        state/oaz_state.h
        actor/oaz_actor.h
        level/tick_queue.h
        oaz_foundation.h
        state/unified_state_group.h
        state/single_state.h level/oaz_level.h config.h state/state_server.h level/oaz_level_adopter.h
        state/state_type.h type.h)

set(CUR_SOURCE_FILE
        level/tick_queue.cpp
        state/unified_state_group.cpp
        state/state_server.cpp level/oaz_level.cpp)



find_package(spdlog REQUIRED)
find_package(nlohmann_json 3.2.0 REQUIRED)


add_library(${CUR_TARGET} STATIC ${CUR_HEADER_FILE} ${CUR_SOURCE_FILE})


target_compile_features(${CUR_TARGET} PRIVATE cxx_std_17)

target_link_libraries(${CUR_TARGET} PUBLIC spdlog::spdlog nlohmann_json::nlohmann_json)
