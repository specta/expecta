// Expecta - EXPMatchers+toBeIdenticalTo.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatchers+toEqual.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(toBeIdenticalTo, (void *expected)) {
  match(^BOOL{
    if(actual == expected) {
      return YES;
    } else if([actual isKindOfClass:[NSValue class]] && EXPIsValuePointer((NSValue *)actual)) {
      if([(NSValue *)actual pointerValue] == expected) {
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
