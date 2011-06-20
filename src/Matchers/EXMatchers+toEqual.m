#import "EXMatchers+toEqual.h"

EXMatcherImplementationBegin(_toEqual, (id expected)) {
  match(^BOOL{
    return (actual == expected) || [actual isEqual:expected];
  });

  failureMessageForTo(^{
    return [NSString stringWithFormat:@"expected: %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^{
    return [NSString stringWithFormat:@"expected: not %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
