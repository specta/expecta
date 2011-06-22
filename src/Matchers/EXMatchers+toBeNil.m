#import "EXMatchers+toBeNil.h"

EXMatcherImplementationBegin(toBeNil, (void)) {
  match(^BOOL{
    return actual == nil;
  });

  failureMessageForTo(^{
    return [NSString stringWithFormat:@"expected: nil/null, got: %@", EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^{
    return [NSString stringWithFormat:@"expected: not nil/null, got: %@", EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
