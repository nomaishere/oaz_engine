#import <Cocoa/Cocoa.h>
#import "../TickManager/TickManager.h"
#import "dlfcn.h"

//#include "level/oaz_level_adopter.h"

@interface OazApp: NSObject

@property TickManager *tickManager;

//@property LevelForObjc *_pLevel;

- (void)test;

- (void)loadLevel;

@end
