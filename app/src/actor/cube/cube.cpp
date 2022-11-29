//
// Created by nomamac2 on 2022/11/25.
//

#include "cube.h"
//#include "cube.h"

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


void Cube::init() {
    std::cout << "init" << std::endl;
}

void Cube::destroy() {
    std::cout << "destroy" << std::endl;
}

void Cube::tick60ps() {
    std::cout << "tick!" << std::endl;
}


extern "C" {

uint32_t add(uint32_t a, uint32_t b) {
    return a + b;
}

void testWithExternC() {
    std::cout << "testWithExternC" << std::endl;
}


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