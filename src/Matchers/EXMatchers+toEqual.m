#import "EXMatchers+toEqual.h"

static BOOL EXIsNumberFloat(NSNumber *number) {
  return strcmp([number objCType], @encode(float)) == 0;
}

EXMatcherImplementationBegin(_toEqual, (id expected)) {
  match(^BOOL{
    return (actual == expected) || [actual isEqual:expected] ||
           ([actual isKindOfClass:[NSNumber class]] && [expected isKindOfClass:[NSNumber class]] &&
            (EXIsNumberFloat((NSNumber *)actual) || EXIsNumberFloat((NSNumber *)expected)) &&
            ([(NSNumber *)actual floatValue] == [(NSNumber *)expected floatValue]));
  });

  failureMessageForTo(^{
    return [NSString stringWithFormat:@"expected: %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^{
    return [NSString stringWithFormat:@"expected: not %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
