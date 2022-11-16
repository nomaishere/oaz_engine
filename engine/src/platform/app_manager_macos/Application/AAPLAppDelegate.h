/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Application delegate for Metal Sample Code
*/

#if TARGET_IOS || TARGET_TVOS
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif


#import "OAZView.h"
#import "OAZViewController.h"

#if TARGET_IOS || TARGET_TVOS
@interface AAPLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
#else
@interface AAPLAppDelegate : NSObject <NSApplicationDelegate>

#endif

@end
