/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Application delegate for Metal Sample Code
*/

#import "CocoaAppDelegate.h"
#import "CocoaWindowDelegate.h"


@implementation CocoaAppDelegate

- (void)keyDown:(NSEvent *)event {
    NSLog(@"hi");
    NSLog(@"Key: %hu", event.keyCode);
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSLog(@"[ CocoaAppDelegate ]: applicationDidFinishLaunching");

    CGRect frame = (CGRect) {{196.0,  240.0},
                             {1024.0, 768.0}};
    NSWindow *_pWindow = [NSWindow alloc];
    [_pWindow initWithContentRect:frame styleMask:NSWindowStyleMaskClosable |
                                                  NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:false];

    [_pWindow setDelegate:[[CocoaWindowDelegate alloc] init]];
    [_pWindow setTitle:@"test title"];


    CocoaViewController *_pViewController = [CocoaViewController alloc];
    [_pViewController initWithFrame:frame];

    [_pWindow setContentViewController:_pViewController];
    [_pWindow setContentView:_pViewController.view];

    [_pWindow makeKeyAndOrderFront:NULL];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)app {
    return YES;
}


@end
