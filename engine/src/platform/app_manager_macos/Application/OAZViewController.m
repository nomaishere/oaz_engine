#import "OAZViewController.h"


@implementation OAZViewController {
    AAPLRenderer *_aaplRenderer;
}

// https://medium.com/hyperoslo/how-to-write-an-nsviewcontroller-without-interface-builder-on-macos-760283648f12
- (void)loadView {
    // create OAZView
    NSLog(@"[ OAZViewController ] : loadView() ");
    self.view = [[OAZView alloc] initWithFrame:_frameForViewCreation];
}

- (void)viewDidLoad {
    NSLog(@"[ OAZViewController ]: viewDidLoad() ");
    [super viewDidLoad];

    OAZView *_pView = (OAZView *) self.view;

    id <MTLDevice> device = MTLCreateSystemDefaultDevice();
    _pView.metalLayer.device = device;
    _pView.oazViewDelegate = self;
    _pView.metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm_sRGB;

    // create provided layer
    _aaplRenderer = [[AAPLRenderer alloc] initWithMetalDevice:device
                                          drawablePixelFormat:_pView.metalLayer.pixelFormat];

}

- (void)initWithFrame:(CGRect)frame {
    NSLog(@"[ OAZViewController ] : initWithFrame() ");
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