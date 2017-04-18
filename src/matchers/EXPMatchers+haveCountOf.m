#import "EXPMatchers+haveCountOf.h"

EXPMatcherImplementationBegin(haveCountOf, (NSUInteger expected)) {
  BOOL (^actualIsStringy)(id actual) = ^BOOL(id actual){ return [actual isKindOfClass:[NSString class]] || [actual isKindOfClass:[NSAttributedString class]]; };
  BOOL (^actualIsCompatible)(id actual) = ^BOOL(id actual){  return actualIsStringy(actual) || [actual respondsToSelector:@selector(count)]; };

  prerequisite(^BOOL(id actual){
    return actualIsCompatible(actual);
  });

  NSUInteger (^count)(id) = ^(id actual) {
    if(actualIsStringy(actual)) {
      return [actual length];
  } else {
      return [actual count];
    }
  };

  match(^BOOL(id actual){
    if(actualIsCompatible(actual)) {
      return count(actual) == expected;
    }
    return NO;
  });

  failureMessageForTo(^NSString *(id actual){
    if(!actualIsCompatible(actual)) return [NSString stringWithFormat:@"%@ is not an instance of NSString, NSAttributedString, NSArray, NSSet, NSOrderedSet, or NSDictionary", EXPDescribeObject(actual)];
    return [NSString stringWithFormat:@"expected %@ to have a count of %zi but got %zi", EXPDescribeObject(actual), expected, count(actual)];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if(!actualIsCompatible(actual)) return [NSString stringWithFormat:@"%@ is not an instance of NSString, NSAttributedString, NSArray, NSSet, NSOrderedSet, or NSDictionary", EXPDescribeObject(actual)];
    return [NSString stringWithFormat:@"expected %@ not to have a count of %zi", EXPDescribeObject(actual), expected];
  });
}
EXPMatcherImplementationEnd
