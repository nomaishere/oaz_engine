//
// Created by nomamac2 on 2022/11/21.
//

#ifndef OAZ_ACTOR_BASE_H
#define OAZ_ACTOR_BASE_H

namespace oaz {

    class Actor {
    public:
        // Init function
        virtual void init() {};

        virtual void destroy() {};

        virtual void tick60ps() {};

    };

}

#endif //OAZ_ACTOR_BASE_H
