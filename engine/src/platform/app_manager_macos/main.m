#import <Cocoa/Cocoa.h>
#import "Application/AAPLAppDelegate.h"

#define RENDER_ON_MAIN_THREAD 0
#define ANIMATION_RENDERING   1
#define AUTOMATICALLY_RESIZE  1
#define CREATE_DEPTH_BUFFER   1

void frame() {
    @autoreleasepool {
        NSEvent *event;
        do {
            event = [NSApp nextEventMatchingMask:NSAnyEventMask
                                    untilDate:nil
                                       inMode:NSDefaultRunLoopMode
                                      dequeue:YES];
            if (event) {
                // handle events here
                [NSApp sendEvent:event];
                //NSLog(@"hi");
                switch(event.type) {
                    case NSEventTypeKeyDown:
                        NSLog(@"%@", event.characters);
                        NSLog(@"keyDown!");
                        break;
                    case NSEventTypeKeyUp:
                        NSLog(@"keyUp!");
                        break;
                }
            }
        } while (event);
       // NSLog(@"doneloop");
    }
}


int main(int argc, const char *argv[]) {
    AAPLAppDelegate *appDelegate = [AAPLAppDelegate alloc];
    [appDelegate init];
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp setPresentationOptions:NSApplicationPresentationDefault];
    [NSApp activateIgnoringOtherApps:YES];
    //[ NSBundle loadNibNamed:@"myMain" owner:NSApp ];
    [NSApp setDelegate:appDelegate];
    [NSApp finishLaunching];

    while(1) {
        frame();
        // state update
        // render

    }
    //[NSApp run];
    return 0;
}