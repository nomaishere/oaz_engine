#import <Cocoa/Cocoa.h>
#import "Application/AAPLAppDelegate.h"

#define RENDER_ON_MAIN_THREAD 0
#define ANIMATION_RENDERING   1
#define AUTOMATICALLY_RESIZE  1
#define CREATE_DEPTH_BUFFER   1

@interface TestObject : NSObject
@property BOOL isAppWillTerminate;
@end

@implementation TestObject

- (void)makeAppTerminate {
    self.isAppWillTerminate = YES;
}

- (BOOL)isWillTerminate {
    return _isAppWillTerminate;
}

@end
/////////////////////////////////////////

@interface TickThread : NSThread
@end

@implementation TickThread

+ (TickThread *)createNewOne:(SEL)selector toTarget:(id)target withObject:(nullable id)argument {
    TickThread *newTickThread;
    [super detachNewThreadSelector:selector toTarget:target withObject:argument];
    return newTickThread;
}

- (instancetype)init {
    self = [super init];
    return self;
}


- (void)runTickLoopInTickThread {
    NSLog(@"tickthread is working!");
    while (![self isCancelled]) {
        //NSLog(@"w");
        //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.0166 target:self selector:@selector(tickmethod:) userInfo:nil repeats:NO];
        NSDate *date = [NSDate date];
        NSLog(@"while is working! ");
        int a = 5;
        int i;
        for (i = 0; i < 3000; i++) {
            a += 1;
        }
        // do tick method

        double timePassed_ms = [date timeIntervalSinceNow] * -1;
        NSTimeInterval restTime = 0.016666 - timePassed_ms;
        [NSThread sleepForTimeInterval:restTime];

    }
}

- (void)tickmethod:(NSTimer *)timer {
    NSLog(@"hi");
}

@end
////////////////

@interface OazApp : NSObject
@end

@implementation OazApp

- (void)startTickLoop {
    [NSThread detachNewThreadSelector:@selector(runTickLoop) toTarget:self withObject:nil];

}

// 나중에 직접 clock register에 접근하는 방식으로 개선하기
- (void)runTickLoop {
    NSLog(@"tickthread is working!");
    // Thread Priority 를 높게 설정할수록 오차가 준다.
    [ NSThread setThreadPriority:1.0];
    double gapSumPerSecond = 0;
    double tickPerSecond = 60;
    double prevSecondGapAverage = 0;
    while ([[NSThread currentThread] isCancelled] == false) {
        gapSumPerSecond = 0;
        NSDate *fullTime = [NSDate date];
        for (int step = 0; step < tickPerSecond; step++) {
            NSDate *date = [NSDate date];

            // do something
            int a = 5;
            for (int i = 0; i < 30000; i++) {
                a += 1;
            }

            NSTimeInterval sleepTime = (1 / tickPerSecond) + [date timeIntervalSinceNow] - (prevSecondGapAverage / 1000);
            //NSLog(@"Predicted Sleep Time(ms): : %f", sleepTime * 1000); // average is 9.99ms
            NSDate *newDate = [NSDate date];
            [NSThread sleepForTimeInterval:sleepTime];
            double actualSleepTime = [newDate timeIntervalSinceNow] * -1000 ;
            gapSumPerSecond += actualSleepTime - (sleepTime * 1000);
            //NSLog(@"Actual Sleep Time(ms): %f", gapSumPerSecond); // average is 12.77 ms. Why?
        }
        NSLog(@"-----Tickloop is done by %f (ms)-----",
              [fullTime timeIntervalSinceNow] * -1000); // average is 1200ms(1.2s).
        prevSecondGapAverage = gapSumPerSecond / tickPerSecond;
        NSLog(@"-----Gap Average : %f (ms)-----", prevSecondGapAverage);
    }
}

@end


void getEventQueue() {
    @autoreleasepool {
        NSEvent *event;
        int a = 0;
        do {
            a += 1;
            event = [NSApp nextEventMatchingMask:NSAnyEventMask
                                       untilDate:nil
                                          inMode:NSDefaultRunLoopMode
                                         dequeue:YES];
            if (event) {
                // handle events here
                [NSApp sendEvent:event];
                switch (event.type) {
                    case NSEventTypeKeyDown:
                        //NSLog(@"%@", event.characters);
                        //NSLog(@"keyDown!");
                        break;
                    case NSEventTypeKeyUp:
                        //NSLog(@"keyUp!");
                        break;
                }
            }
        } while (event);
        //NSLog(@"doneloop");
    }
}


int main(int argc, const char *argv[]) {
    AAPLAppDelegate *appDelegate = [AAPLAppDelegate alloc];
    [appDelegate init];
    [NSApplication sharedApplication];

    // 나중에 봐야함
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp setPresentationOptions:NSApplicationPresentationDefault];

    // 나중에 봐야함22
    [NSApp activateIgnoringOtherApps:YES];

    [NSApp setDelegate:appDelegate];
    [NSApp finishLaunching];

    BOOL isMultiThreaded = [NSThread isMultiThreaded];
    NSThread *currentThread = [NSThread currentThread];
    if (isMultiThreaded == YES) {
        NSLog(@"[ Main ][ Init ]: Multithreading Now!");
        NSLog(@"[ Main ][ Init ]: Current Thread Name: %s", currentThread.name);
    } else {
        NSLog(@"[ Main ][ Init ]: Single Thread Now!");
    }

    TestObject *testObject = [[TestObject alloc] init];
    NSNotificationCenter *_pNotificationCenter = [NSNotificationCenter defaultCenter];
    [_pNotificationCenter addObserver:testObject
                             selector:@selector(makeAppTerminate)
                                 name:NSWindowWillCloseNotification
                               object:NSApp.mainWindow];


    OazApp *_oazApp = [[OazApp alloc] init];
    [_oazApp startTickLoop];

    [NSApp run];
    /*
    while (1) {
        getEventQueue();
        if (isMultiThreaded == YES) {
            //NSLog(@"Multithreading Now!");
        } else {
            NSLog(@"[ Main ][ MainLoop ]: Single Thread Now!");
        }

        // TODO Command + Q 로 Application 을 종료하면 OAZWindowDelegate 에서는 해당 Notification 을 받지만 이곳에선 처리가 안됨. 해결 필요
        if ([testObject isWillTerminate]) {
            NSLog(@"[ Main ][ Cleanup ]: Terminate Main Loop");
            break;
        }
    }
    [NSApp terminate:nil];
     */

    return 0;
}
