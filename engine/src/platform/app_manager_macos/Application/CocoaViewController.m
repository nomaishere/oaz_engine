#import "CocoaViewController.h"


@implementation CocoaViewController {
    AAPLRenderer *_aaplRenderer;
}

// https://medium.com/hyperoslo/how-to-write-an-nsviewcontroller-without-interface-builder-on-macos-760283648f12
- (void)loadView {
    // create CocoaView
    NSLog(@"[ CocoaViewController ] : loadView() ");
    self.view = [[CocoaView alloc] initWithFrame:_frameForViewCreation];
}

- (void)viewDidLoad {
    NSLog(@"[ CocoaViewController ]: viewDidLoad() ");
    [super viewDidLoad];

    CocoaView *_pView = (CocoaView *) self.view;

    id <MTLDevice> device = MTLCreateSystemDefaultDevice();
    _pView.metalLayer.device = device;
    _pView.oazViewDelegate = self;
    _pView.metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm_sRGB;

    // create provided layer
    _aaplRenderer = [[AAPLRenderer alloc] initWithMetalDevice:device
                                          drawablePixelFormat:_pView.metalLayer.pixelFormat];

}

- (void)initWithFrame:(CGRect)frame {
    NSLog(@"[ CocoaViewController ] : initWithFrame() ");
    [super init];
    self.frameForViewCreation = frame;
}

- (void)drawableResize:(CGSize)size
{
    [_aaplRenderer drawableResize:size];
}

- (void)renderToCAMetalLayer:(nonnull CAMetalLayer *)caMetalLayer {
    //NSLog(@"render!");
    [_aaplRenderer renderToMetalLayer:caMetalLayer];
}

@end