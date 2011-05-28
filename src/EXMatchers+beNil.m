#import "EXMatchers+beNil.h"

@implementation EXMatchers (beNil)

- (void)beNil {
  [self match:^BOOL{ return self.actual == nil; }
        description:@"nil"];
}

@end
