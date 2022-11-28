set(CUR_TARGET oaz_foundation)
project(${CUR_TARGET} LANGUAGES CXX VERSION 0.1.0)

set(CUR_HEADER_FILE
        state/oaz_state.h
        actor/oaz_actor.h
        level/tick_queue.h
        oaz_foundation.h
        state/unified_state_group.h
        state/single_state.h level/oaz_level.h config.h app/oaz_app.h)

set(CUR_SOURCE_FILE
        level/tick_queue.cpp
        state/unified_state_group.cpp
        app/oaz_app.cpp)

add_library(${CUR_TARGET} STATIC ${CUR_HEADER_FILE} ${CUR_SOURCE_FILE})

target_compile_features(${CUR_TARGET} PRIVATE cxx_std_17)
