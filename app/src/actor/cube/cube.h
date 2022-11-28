//
// Created by nomamac2 on 2022/11/28.
//

#ifndef APPLICATION_CUBE_H
#define APPLICATION_CUBE_H

#include "oaz_foundation.h"
#include <iostream>
#include <cstdint>



class Cube : oaz::Actor {

public:
    void init() override;

    void destroy() override;

    void tick60ps() override;
};

extern "C" {
    class Cube* createActor();
    void destroyActor(Cube* actor);
};



#endif //APPLICATION_CUBE_H
