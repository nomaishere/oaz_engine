
#include "oaz_foundation.h"
#include "cube.h"
#include <dlfcn.h>


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


        auto createActor =  (oaz::Actor*(*)())dlsym(lib_handle, "createActor");
        oaz::Actor* myCube;
        myCube = createActor();
        _pActor[0] = (oaz::Actor*)myCube;
    }

    void destroy() override {
        std::cout << "destroy forest" << std::endl;
        for(auto & i : _pActor) {
            std::cout << "delete!" << std::endl;
            delete i;
        }
    }

};

extern "C" {
    class Forest* createLevel() {
        Forest* temp;
        temp = new Forest;
        return temp;
    }
    void destroyLevel(Forest* level) {
        level->destroy();
        delete level;
    }
}