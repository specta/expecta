#import "EXPMatchers+toContain.h"

EXPMatcherImplementationBegin(_toContain, (id expected)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSString class]] || [actual isKindOfClass:[NSArray class]];
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL{
    return actualIsCompatible && !expectedIsNil;
  });

  match(^BOOL{
    if(actualIsCompatible) {
      if([actual isKindOfClass:[NSString class]]) {
        return [(NSString *)actual rangeOfString:[expected description]].location != NSNotFound;
      } else if([actual isKindOfClass:[NSArray class]]) {
        return [actual indexOfObject:expected] != NSNotFound;
      }
    }
    return NO;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString or NSArray", EXPDescribeObject(actual)];
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected %@ to contain %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString or NSArray", EXPDescribeObject(actual)];
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected %@ not to contain %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
}
EXPMatcherImplementationEnd
