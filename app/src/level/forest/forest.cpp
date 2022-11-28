//
// Created by nomamac2 on 2022/11/26.
//

#include "oaz_foundation.h"
#include "cube.h"
#include <dlfcn.h>


/*
void (*testWithExternC)() = (void (*)()) dlsym(lib_handle, "testWithExternC");
testWithExternC();

uint32_t (*add)(uint32_t, uint32_t) = (uint32_t(*)(uint32_t, uint32_t)) dlsym(lib_handle, "add");
uint32_t c = add(3, 5);

uint32_t (*minNoExternC)(uint32_t, uint32_t) = (uint32_t(*)(uint32_t, uint32_t)) dlsym(lib_handle, "minNoExternC");
uint32_t t = minNoExternC(5, 3);

std::cout << t << std::endl;
std::cout << "test2" << std::endl;
 */
//void* tick60ps = dlsym(lib_handle, "")

class Forest : oaz::Level {
public:

    void init() override {
        void *lib_handle = dlopen("/Users/noma/Desktop/dev/oaz_engine/cmake/debug/app/src/actor/cube/liba_cube.dylib",
                                  RTLD_GLOBAL);
        std::cout << "load library" << std::endl;
        if (lib_handle == nullptr) {
            std::cout << "load actor error" << std::endl;
            exit(EXIT_FAILURE);
        }


        auto createActor =  (Cube*(*)())dlsym(lib_handle, "createActor");
        Cube* myCube;
        myCube = createActor();
        myCube->tick60ps();

    }

    void destroy() override {
        std::cout << "test" << std::endl;
    }

};

int main() {
    auto *forest = new Forest();
    forest->init();
}