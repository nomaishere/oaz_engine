#include <AppKit/AppKit.h>
#import "CocoaView.h"
#import "../Renderer/AAPLRenderer.h"

@interface CocoaViewController : NSViewController <OAZViewDelegate>

@property (nonatomic) CGRect frameForViewCreation;

- (void)initWithFrame:(CGRect)frame;

@end