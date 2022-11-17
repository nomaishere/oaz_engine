#import "OAZWindowDelegate.h"

@implementation OAZWindowDelegate

- (void)windowDidBecomeKey:(NSNotification *)notification {
    // NSLog(@"Window: become key");
}

- (void)windowDidBecomeMain:(NSNotification *)notification {
    // NSLog(@"Window: become main");
}

- (void)windowDidResignKey:(NSNotification *)notification {
    // NSLog(@"Window: resign key");
}

- (void)windowDidResignMain:(NSNotification *)notification {
    // NSLog(@"Window: resign main");
}

// This will close/terminate the application when the main window is closed.
// TODO 여기서 windowWillClose notification 을 받았을 때 Log 가 두번 출력됨. 원인 파악 필요
- (void)windowWillClose:(NSNotification *)notification {
    NSWindow *window = notification.object;
    if (window.isMainWindow) {
        NSLog(@"[ OAZWindowDelegate ][ Cleanup ]: stop NSApp");
    }
}

@end