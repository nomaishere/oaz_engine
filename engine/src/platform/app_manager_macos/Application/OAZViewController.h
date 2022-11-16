#include <AppKit/AppKit.h>
#import "OAZView.h"
#import "../Renderer/AAPLRenderer.h"

@interface OAZViewController : NSViewController <OAZViewDelegate>

@property (nonatomic) CGRect frameForViewCreation;

- (void)initWithFrame:(CGRect)frame;

@end