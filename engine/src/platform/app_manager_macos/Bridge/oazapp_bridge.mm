#include "oazapp_bridge.h"
#include "level/oaz_level_adopter.h"


@implementation OazApp {
    LevelForObjc *_level;
}

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
    _level = forest;


    [NSThread detachNewThreadSelector:@selector(run60TickPerSecondLoop) toTarget:self withObject:nil];

    //[self setTickManager:[[TickManager alloc] init]];
    //  self.tickManager.startFixedTickLoop;
    //void* test = dlsym(lib_handle, "createLevel");

}

- (void)run60TickPerSecondLoop {
    // Thread Priority 를 높게 지정할 수록 latency 가 줄어듬
    [NSThread setThreadPriority:1.0];
    NSTimeInterval gapSumPerSecond = 0;
    NSTimeInterval prevLoopGapAverage = 0;
    NSDate *fullTime = [NSDate date];
    NSDate *date = [NSDate date];
    while (![[NSThread currentThread] isCancelled]) {
        gapSumPerSecond = 0;
        fullTime = [NSDate now];
        for (int step = 0; step < 60; step++) {
            date = [NSDate now];

            for (auto & actor : _level->_pActor) {
                if(actor == nullptr) {
                    break;
                }
                actor->tick60ps();
            }
            // do something
            int a = 5;
            for (int i = 0; i < 30000; i++) {
                a += 1;
            }

            NSTimeInterval sleepTime = (1 / 60.0) + [date timeIntervalSinceNow] - prevLoopGapAverage;
            NSDate *newDate = [NSDate date];
            [NSThread sleepForTimeInterval:sleepTime];
            gapSumPerSecond += -[newDate timeIntervalSinceNow] - sleepTime;
        }
        NSLog(@"-----Tick loop was done by %f (ms)-----",
              [fullTime timeIntervalSinceNow] * -1000);
        prevLoopGapAverage = gapSumPerSecond / 60.0;
        NSLog(@"-----Gap Average : %f (ms)-----", prevLoopGapAverage);
    }
}
@end