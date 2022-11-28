//
// Created by nomamac2 on 2022/11/25.
//

#ifndef APPLICATION_SINGLE_STATE_H
#define APPLICATION_SINGLE_STATE_H

#include <cstdint>

namespace oaz {

    template<typename T>
    struct singleState {
        uint16_t actorID;
        T data;
    };
}

#endif //APPLICATION_SINGLE_STATE_H
