#import <QuartzCore/CAMetalLayer.h>
#import <Metal/Metal.h>
#import <AppKit/AppKit.h>

@protocol OAZViewDelegate <NSObject>

-(void)renderToCAMetalLayer:(nonnull CAMetalLayer*)caMetalLayer;

@end


@interface OAZView : NSView <CALayerDelegate>

@property NSString *name;

@property(nonatomic, nonnull, readonly) CAMetalLayer *metalLayer;

@property (nonatomic, nullable) id<OAZViewDelegate> oazViewDelegate;

- (void)resizeDrawable:(CGFloat)scaleFactor;

- (void)initMore;

- (void)render;

@end