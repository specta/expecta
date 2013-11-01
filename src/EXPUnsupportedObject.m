#import "EXPUnsupportedObject.h"

@implementation EXPUnsupportedObject

@synthesize type=_type;

- (id)initWithType:(NSString *)type {
  self = [super init];
  if(self) {
    self.type = type;
  }
  return self;
}

@end
