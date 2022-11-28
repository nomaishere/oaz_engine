//
// Created by nomamac2 on 2022/11/25.
//

#ifndef APPLICATION_OAZ_LEVEL_H
#define APPLICATION_OAZ_LEVEL_H

#include "../config.h"
#include "../actor/oaz_actor.h"

namespace oaz {
    class Level {
    private:


    public:
        Actor *_pActor[MAX_ACTOR_PER_LEVEL];

        virtual void init() {};

        virtual void destroy() {};

    };


}

#endif //APPLICATION_OAZ_LEVEL_H
