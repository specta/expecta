#import "EXPMatchers+equal.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(beIdenticalTo, (id expected)) {
  match(^BOOL{
    if(actual == expected) {
      return YES;
    } else if([actual isKindOfClass:[NSValue class]] && EXPIsValuePointer((NSValue *)actual)) {
      if([(NSValue *)actual pointerValue] == (__bridge void *)expected) {
        return YES;
      }
    }
    return NO;
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: <%p>, got: <%p>", expected, actual];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not <%p>, got: <%p>", expected, actual];
  });
}
EXPMatcherImplementationEnd
