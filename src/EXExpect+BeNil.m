#import "EXExpect+BeNil.h"

@implementation EXExpect (BeNil)

- (void)beNil {
  [self match:^BOOL{ return self.actual == nil; }
        description:@"nil"];
}

@end
