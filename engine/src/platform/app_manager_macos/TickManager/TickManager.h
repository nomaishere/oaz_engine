#import <Cocoa/Cocoa.h>

@interface TickManager : NSObject

- (void)startFixedTickLoop;

- (void)run60TickPerSecondLoop;
@end

