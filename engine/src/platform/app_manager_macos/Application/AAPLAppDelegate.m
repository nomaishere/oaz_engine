/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Application delegate for Metal Sample Code
*/

#import "AAPLAppDelegate.h"

@implementation AAPLAppDelegate

#if TARGET_MACOS
// Close app when window is closed

-(void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"STEP: applicationDidFinishLaunching");

    // Window Creation
    CGRect frame = (CGRect){ {196.0, 240.0}, {1024.0, 768.0} };
    NSWindow* _pWindow = [ NSWindow alloc ];
    [ _pWindow initWithContentRect:frame styleMask:NSWindowStyleMaskClosable|NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:false ];
    [_pWindow setTitle:@"test title"];

    // Create view
    /*
    OAZView* _pView = [ OAZView alloc ];
    NSRect viewRect = NSRectFromCGRect(frame);
    [ _pView initWithFrame:viewRect ];
    */

    OAZViewController* _pViewController = [ OAZViewController alloc ];
    [ _pViewController initWithFrame:frame ];

    [ _pWindow setContentViewController:_pViewController ];
    [ _pWindow setContentView:_pViewController.view ];
    //NSLog(@"Window View :%@", ((OAZView*)_pViewController.view).name );

    [_pWindow makeKeyAndOrderFront:NULL];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}
#endif

@end
