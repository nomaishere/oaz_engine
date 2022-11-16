#import "OAZWindowDelegate.h"

@implementation OAZWindowDelegate

- (void)windowDidBecomeKey:(NSNotification *)notification {
    NSLog(@"Window: become key");
}

- (void)windowDidBecomeMain:(NSNotification *)notification {
    NSLog(@"Window: become main");
}

- (void)windowDidResignKey:(NSNotification *)notification {
    NSLog(@"Window: resign key");
}

- (void)windowDidResignMain:(NSNotification *)notification {
    NSLog(@"Window: resign main");
}

// This will close/terminate the application when the main window is closed.
- (void)windowWillClose:(NSNotification *)notification {
    NSWindow *window = notification.object;
    if (window.isMainWindow) {
        NSLog(@"Window is closing!");
        [NSApp terminate:nil];
    }
}

@end