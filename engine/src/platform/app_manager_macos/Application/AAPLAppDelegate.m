/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Application delegate for Metal Sample Code
*/

#import "AAPLAppDelegate.h"
#import "OAZWindowDelegate.h"


@implementation AAPLAppDelegate

- (void)keyDown:(NSEvent *)event {
    NSLog(@"hi");
    NSLog(@"Key: %hu", event.keyCode);
}

#if TARGET_MACOS
// Close app when window is closed

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"STEP: applicationDidFinishLaunching");

    // Window Creation
    CGRect frame = (CGRect) {{196.0,  240.0},
                             {1024.0, 768.0}};
    NSWindow *_pWindow = [NSWindow alloc];
    [_pWindow initWithContentRect:frame styleMask:NSWindowStyleMaskClosable |
                                                  NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:false];

    [_pWindow setDelegate:[[OAZWindowDelegate alloc] init]];
    [_pWindow setTitle:@"test title"];

    if(_pWindow.acceptsFirstResponder == YES) {
        NSLog(@"yes");
    } else if(_pWindow.acceptsFirstResponder == NO) {
        NSLog(@"no");
    } else {

    }
    [_pWindow becomeFirstResponder];
    if(_pWindow.acceptsFirstResponder == YES) {
        NSLog(@"yes");
    } else if(_pWindow.acceptsFirstResponder == NO) {
        NSLog(@"no");
    } else {

    }



    // Create view
    /*
    OAZView* _pView = [ OAZView alloc ];
    NSRect viewRect = NSRectFromCGRect(frame);
    [ _pView initWithFrame:viewRect ];
    */

    OAZViewController *_pViewController = [OAZViewController alloc];
    [_pViewController initWithFrame:frame];

    [_pWindow setContentViewController:_pViewController];
    [_pWindow setContentView:_pViewController.view];
    //NSLog(@"Window View :%@", ((OAZView*)_pViewController.view).name );

    [_pWindow makeKeyAndOrderFront:NULL];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}

#endif

@end
