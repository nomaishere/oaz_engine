#import <Cocoa/Cocoa.h>
#import "Application/AAPLAppDelegate.h"

#define RENDER_ON_MAIN_THREAD 0
#define ANIMATION_RENDERING   1
#define AUTOMATICALLY_RESIZE  1
#define CREATE_DEPTH_BUFFER   1


int main(int argc, const char * argv[]) {
    AAPLAppDelegate *appDelegate = [ AAPLAppDelegate alloc ];
    [ appDelegate init];
    [ NSApplication sharedApplication ];
    //[ NSBundle loadNibNamed:@"myMain" owner:NSApp ];
    [ NSApp setDelegate:appDelegate ];
    [ NSApp run ];
    return 0;
}