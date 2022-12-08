//
// Created by nomamac2 on 2022/11/25.
//


#include "oaz_foundation.h"
#include <iostream>


class Cube : oaz::Actor {
public:
    void init() override {
        std::cout << "init" << std::endl;
    }

    void destroy() override {
        std::cout << "destroy" << std::endl;
    }

    void tick60ps() override {
        std::cout << "tick!" << std::endl;
    }
};

extern "C" {


class Cube *createActor() {
    Cube *temp;
    temp = new Cube;
    return temp;
};

void destroyActor(Cube *actor) {
    actor->destroy();
    delete actor;
}

}