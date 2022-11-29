#import <Cocoa/Cocoa.h>
#import "Application/CocoaAppDelegate.h"
#import "Bridge/oazapp_bridge.h"

#define RENDER_ON_MAIN_THREAD 0
#define ANIMATION_RENDERING   1
#define AUTOMATICALLY_RESIZE  1
#define CREATE_DEPTH_BUFFER   1

@interface WindowCloseEventListener : NSObject
@property BOOL isAppWillTerminate;
@end

@implementation WindowCloseEventListener

- (void)makeAppTerminate {
    self.isAppWillTerminate = YES;
}

- (BOOL)isWillTerminate {
    return _isAppWillTerminate;
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
    CocoaAppDelegate *appDelegate = [CocoaAppDelegate alloc];
    [appDelegate init];
    [NSApplication sharedApplication];

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp setPresentationOptions:NSApplicationPresentationDefault];
    [NSApp activateIgnoringOtherApps:YES];

    [NSApp setDelegate:appDelegate];

    WindowCloseEventListener *_windowCloseEventListener = [[WindowCloseEventListener alloc] init];
    NSNotificationCenter *_pNotificationCenter = [NSNotificationCenter defaultCenter];
    [_pNotificationCenter addObserver:_windowCloseEventListener
                             selector:@selector(makeAppTerminate)
                                 name:NSWindowWillCloseNotification
                               object:NSApp.mainWindow];


    [NSApp finishLaunching];

    OazApp *_oazApp = [[OazApp alloc] init];
    [_oazApp loadLevel];



    while (1) {
        getEventQueue();

        // TODO Command + Q 로 Application 을 종료하면 CocoaWindowDelegate 에서는 해당 Notification 을 받지만 이곳에선 처리가 안됨. 해결 필요
        if ([_windowCloseEventListener isWillTerminate]) {
            NSLog(@"[ Main ][ Cleanup ]: Terminate Main Loop");
            break;
        }
    }
    [NSApp terminate:nil];

    return 0;
}
