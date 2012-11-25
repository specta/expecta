#import "EXPMatchers+haveCountOf.h"

EXPMatcherImplementationBegin(haveCountOf, (NSUInteger expected)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSString class]] ||
    [actual isKindOfClass:[NSArray class]] ||
	[actual isKindOfClass:[NSSet class]] ||
	[actual isKindOfClass:[NSDictionary class]];

  prerequisite(^BOOL{
    return actualIsCompatible;
  });

  NSUInteger (^count)(id) = ^(id actual) {
    if([actual isKindOfClass:[NSString class]]) {
      return [actual length];
	} else {
      return [actual count];
    }
  };

  match(^BOOL{
    if(actualIsCompatible) {
      return count(actual) == expected;
    }
    return NO;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString, NSArray, NSSet, or NSDictionary", EXPDescribeObject(actual)];
    return [NSString stringWithFormat:@"expected %@ to have a count of %ld but got %ld", EXPDescribeObject(actual), (long) expected, (long) count(actual)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSString, NSArray, NSSet, or NSDictionary", EXPDescribeObject(actual)];
    return [NSString stringWithFormat:@"expected %@ not to have a count of %ld", EXPDescribeObject(actual), (long) expected];
  });
}
EXPMatcherImplementationEnd
