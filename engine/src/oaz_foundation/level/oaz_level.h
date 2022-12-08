//
// Created by nomamac2 on 2022/11/25.
//

#ifndef APPLICATION_OAZ_LEVEL_H
#define APPLICATION_OAZ_LEVEL_H

#include "../config.h"
#include "../type.h"
#include "../actor/oaz_actor.h"

/*
#include <fstream>

#include <nlohmann/json.hpp>
#include "spdlog/spdlog.h"
 */

namespace oaz {
    class Level {
    private:


    public:
        //Level();

        Actor *_pActor[MAX_ACTOR_PER_LEVEL];

        virtual void init() {};

        virtual void destroy() {};

    };


}

#endif //APPLICATION_OAZ_LEVEL_H
