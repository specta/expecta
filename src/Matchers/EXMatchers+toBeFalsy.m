#import "EXMatchers+toBeFalsy.h"
#import "EXMatcherHelpers.h"

EXMatcherImplementationBegin(toBeFalsy, (void)) {
  match(^BOOL{
    if([actual isKindOfClass:[NSNumber class]]) {
      return ![(NSNumber *)actual boolValue];
    } else if([actual isKindOfClass:[NSValue class]]) {
      if(EXIsValuePointer((NSValue *)actual)) {
        return ![(NSValue *)actual pointerValue];
      }
    }
    return !actual;
  });

  failureMessageForTo(^{
    return [NSString stringWithFormat:@"expected: a falsy value, got: %@, which is truthy", EXDescribeObject(actual)];
  });

  failureMessageForNotTo(^{
    return [NSString stringWithFormat:@"expected: a non-falsy value, got: %@, which is falsy", EXDescribeObject(actual)];
  });
}
EXMatcherImplementationEnd
