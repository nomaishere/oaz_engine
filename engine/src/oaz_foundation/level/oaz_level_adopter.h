//
// Created by nomamac2 on 2022/11/28.
//

#ifndef APPLICATION_OAZ_LEVEL_ADOPTER_H
#define APPLICATION_OAZ_LEVEL_ADOPTER_H
#include "../config.h"

#endif //APPLICATION_OAZ_LEVEL_ADOPTER_H


class ActorForObjc {
public:
    // Init function
    virtual void init() {};

    virtual void destroy() {};

    virtual void tick60ps() {};

};


class LevelForObjc {
private:


public:
    ActorForObjc *_pActor[MAX_ACTOR_PER_LEVEL];

    virtual void init() {};

    virtual void destroy() {};

};