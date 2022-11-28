#include "oazapp_bridge.h"
#include "level/oaz_level_adopter.h"


@implementation OazApp

- (void)test {

}

- (void)loadLevel {
    void *lib_handle = dlopen("libl_forest.dylib",
                              RTLD_LAZY);
    if (!lib_handle) {
        NSLog(@"Failed to load level");
    }

    LevelForObjc *(*createForest)() =(LevelForObjc *(*)()) dlsym(lib_handle, "createLevel");
    LevelForObjc *forest = createForest();
    //forest->_pActor[0]->tick60ps();
    forest->init();
    NSLog(@"tick now");
    forest->_pActor[0]->tick60ps();


    //void* test = dlsym(lib_handle, "createLevel");

}

@end