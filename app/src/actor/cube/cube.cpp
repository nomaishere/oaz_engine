//
// Created by nomamac2 on 2022/11/25.
//

//#include "cube.h"
//#include "cube.h"
#include "oaz_foundation.h"

/*
void Cube::init() {
    std::cout << "init cube" << std::endl;
}

void Cube::destroy() {
    std::cout << "destroy cube" << std::endl;
}

void Cube::tick60ps() {
    std::cout << "--tick cube--" << std::endl;

}*/


class Cube: oaz::Actor {
public:
    void init() override{
        std::cout << "init" << std::endl;
    }

    void destroy() override{
        std::cout << "destroy" << std::endl;
    }

    void tick60ps() override {
        std::cout << "tick!" << std::endl;
    }
};

/*
void init() {
    std::cout << "init" << std::endl;
}

void Cube::destroy() {
    std::cout << "destroy" << std::endl;
}

void Cube::tick60ps() {
    std::cout << "tick!" << std::endl;
}
*/

extern "C" {


class Cube *createActor() {
    Cube *temp;
    temp = new Cube;
    return temp;
} ;

void destroyActor(Cube *actor) {
    actor->destroy();
    delete actor;
}

}