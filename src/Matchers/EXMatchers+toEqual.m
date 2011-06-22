#import "EXMatchers+toEqual.h"
#import "EXMatcherHelpers.h"

EXMatcherImplementationBegin(_toEqual, (id expected)) {
  match(^BOOL{
    if((actual == expected) || [actual isEqual:expected]) {
      return YES;
    } else if([actual isKindOfClass:[NSNumber class]] && [expected isKindOfClass:[NSNumber class]]) {
      if(EXIsNumberFloat((NSNumber *)actual) || EXIsNumberFloat((NSNumber *)expected)) {
        return [(NSNumber *)actual floatValue] == [(NSNumber *)expected floatValue];
      }
    }
    return NO;
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not %@, got: %@", EXDescribeObject(expected), EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
