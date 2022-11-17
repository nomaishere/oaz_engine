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

@interface TickThread : NSThread
@end

@implementation TickThread

- (void)init {
    [super init];
}


- (void)main {
    NSLog(@"tickthread is working!");
    while (![self isCancelled]) {
        //NSLog(@"w");
        //NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.0166 target:self selector:@selector(tickmethod:) userInfo:nil repeats:NO];
        NSDate *date = [NSDate date];
        //NSLog(@"while is working! ");
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

    // Main Loop for games
    BOOL isMultiThreaded = [NSThread isMultiThreaded];
    NSThread *currentThread = [NSThread currentThread];
    if (isMultiThreaded == YES) {
        NSLog(@"[ Main ][ Init ]: Multithreading Now!");
        NSLog(@"[ Main ][ Init ]: Current Thread Name: %@", currentThread.name);
    } else {
        NSLog(@"[ Main ][ Init ]: Single Thread Now!");
    }

    TickThread *_tickThread = [[TickThread alloc] init];
    [_tickThread start];

    TestObject *testObject = [[TestObject alloc] init];
    NSNotificationCenter *_pNotificationCenter = [NSNotificationCenter defaultCenter];
    [_pNotificationCenter addObserver:testObject
                             selector:@selector(makeAppTerminate)
                                 name:NSWindowWillCloseNotification
                               object:NSApp.mainWindow];


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

    //[NSApp run];
    return 0;
}
