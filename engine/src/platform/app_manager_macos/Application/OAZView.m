#import "OAZView.h"

@implementation OAZView {
    CVDisplayLinkRef _cvDisplayLink;
}

- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"STEP: initWithFrame in OAZView.m");
    self = [super initWithFrame:frame];
    if (self) {
        [self initMore];
    }
    return self;
}

- (void)initMore {
    NSLog(@"STEP: initMore in OAZView.m");

    self.name = @"test view name";
    // view 를 layer-backed view 로 변경함.
    self.wantsLayer = YES;
    self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawDuringViewResize;

    _metalLayer = (CAMetalLayer *) self.layer;
    self.layer.delegate = self;
    NSLog(@"layer's frame width : %f height: %f", self.layer.frame.size.width, self.layer.frame.size.height);

}

// AppKit 이 해당 Method 를 호출해서 자동으로 underlying layer object 를 만듦.
- (CALayer *)makeBackingLayer {
    return [CAMetalLayer layer];
}

- (void)viewDidMoveToWindow {
    NSLog(@"[ OAZView ] viewDidMoveToWindo() ");
    [super viewDidMoveToWindow];

    // setup CVDisplayLink for screen
    CVDisplayLinkCreateWithActiveCGDisplays(&_cvDisplayLink);
    CVDisplayLinkSetOutputCallback(_cvDisplayLink, &DispatchRenderLoop, (__bridge void *) self);

    CGDirectDisplayID cgDirectDisplayId = (CGDirectDisplayID) [self.window.screen.deviceDescription[@"NSScreenNumber"] unsignedIntegerValue];;
    CVDisplayLinkSetCurrentCGDisplay(_cvDisplayLink, cgDirectDisplayId);
    CVDisplayLinkStart(_cvDisplayLink);
    NSNotificationCenter *_pNotificationCenter = [NSNotificationCenter defaultCenter];
    [_pNotificationCenter addObserver:self
                             selector:@selector(windowWillClose:)
                                 name:NSWindowWillCloseNotification
                               object:self.window];

    // resize
    [self resizeDrawable:self.window.screen.backingScaleFactor];
}

- (void)windowWillClose:(NSNotification *)_pNotification {
    if (_pNotification.object == self.window) {
        CVDisplayLinkStop(_cvDisplayLink);
    }
}

static CVReturn DispatchRenderLoop(CVDisplayLinkRef displayLink,
                                   const CVTimeStamp *now,
                                   const CVTimeStamp *outputTime,
                                   CVOptionFlags flagsIn,
                                   CVOptionFlags *flagsOut,
                                   void *displayLinkContext) {
    @autoreleasepool {
        OAZView *_pOazView = (__bridge OAZView *) displayLinkContext;
        [_pOazView render];
    }
    return kCVReturnSuccess;
}

- (void)render {
    @synchronized (_metalLayer) {
        [_oazViewDelegate renderToCAMetalLayer:_metalLayer];
    }
}

/////////////////////////// RESIZING /////////////////////////////////

- (void)resizeDrawable:(CGFloat)scaleFactor {
    CGSize newSize = self.bounds.size;
    newSize.width *= scaleFactor;
    newSize.height *= scaleFactor;

    if (newSize.width <= 0 || newSize.height <= 0) {
        return;
    }

    @synchronized (_metalLayer) {
        if (newSize.width == _metalLayer.drawableSize.width &&
            newSize.height == _metalLayer.drawableSize.height) {
            return;
        }
        _metalLayer.drawableSize = newSize;
        [_oazViewDelegate drawableResize:newSize];
    }

}


@end