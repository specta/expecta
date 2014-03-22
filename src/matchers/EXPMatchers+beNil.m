#import "EXPMatchers+beNil.h"

EXPMatcherImplementationBegin(beNil, (void)) {
  match(^BOOL(id actual){
    return actual == nil;
  });

  failureMessageForTo(^NSString *(id actual){
    return [NSString stringWithFormat:@"expected: nil/null, got: %@", EXPDescribeObject(actual)];
  });

  failureMessageForNotTo(^NSString *(id actual){
    return [NSString stringWithFormat:@"expected: not nil/null, got: %@", EXPDescribeObject(actual)];
  });
}
EXPMatcherImplementationEnd
