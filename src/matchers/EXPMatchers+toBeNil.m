#import "EXPMatchers+toBeNil.h"

EXPMatcherImplementationBegin(toBeNil, (void)) {
  match(^BOOL{
    return actual == nil;
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: nil/null, got: %@", EXPDescribeObject(actual)];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not nil/null, got: %@", EXPDescribeObject(actual)];
  });
}
EXPMatcherImplementationEnd
