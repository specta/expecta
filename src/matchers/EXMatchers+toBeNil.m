#import "EXMatchers+toBeNil.h"

EXMatcherImplementationBegin(toBeNil, (void)) {
  match(^BOOL{
    return actual == nil;
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: nil/null, got: %@", EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not nil/null, got: %@", EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
