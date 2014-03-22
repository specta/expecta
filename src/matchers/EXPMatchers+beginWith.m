#import "EXPMatchers+beginWith.h"

EXPMatcherImplementationBegin(beginWith, (id expected)) {
  BOOL (^actualIsNil)(id actual) = ^BOOL(id actual){ return (actual == nil); };
  BOOL expectedIsNil = (expected == nil);
  //This condition allows the comparison of an immutable string or ordered collection to the mutable type of the same
  BOOL (^actualAndExpectedAreCompatible)(id actual) = ^BOOL(id actual){
    return (([actual isKindOfClass:[NSString class]] && [expected isKindOfClass:[NSString class]])
            || ([actual isKindOfClass:[NSArray class]] && [expected isKindOfClass:[NSArray class]])
            || ([actual isKindOfClass:[NSOrderedSet class]] && [expected isKindOfClass:[NSOrderedSet class]]));
  };
  
  prerequisite(^BOOL(id actual){
    return actualAndExpectedAreCompatible(actual);
  });
  
  match(^BOOL(id actual){
    if ([actual isKindOfClass:[NSString class]]) {
      return [actual hasPrefix:expected];
    } else if ([actual isKindOfClass:[NSArray class]]) {
      if ([expected count] > [actual count] || [expected count] == 0) {
        return NO;
      }
      NSArray *subArray = [actual subarrayWithRange:NSMakeRange(0, [expected count])];
      return [subArray isEqualToArray:expected];
    } else {
      if ([expected count] > [actual count] || [expected count] == 0) {
        return NO;
      }
      
      NSOrderedSet *subset = [NSOrderedSet orderedSetWithOrderedSet:actual range:NSMakeRange(0, [expected count]) copyItems:NO];
      return [subset isEqualToOrderedSet:expected];
    }
  });
  
  failureMessageForTo(^NSString *(id actual){
    if (actualIsNil(actual)) return @"the object is nil/null";
    if (expectedIsNil) return @"the expected value is nil/null";
    if (!actualAndExpectedAreCompatible(actual)) return [NSString stringWithFormat:@"%@ and %@ are not instances of one of %@, %@, or %@", EXPDescribeObject(actual), EXPDescribeObject(expected), [NSString class], [NSArray class], [NSOrderedSet class]];
    return [NSString stringWithFormat:@"expected: %@ to begin with %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
  
  failureMessageForNotTo(^NSString *(id actual){
    if (actualIsNil(actual)) return @"the object is nil/null";
    if (expectedIsNil) return @"the expected value is nil/null";
    if (!actualAndExpectedAreCompatible(actual)) return [NSString stringWithFormat:@"%@ and %@ are not instances of one of %@, %@, or %@", EXPDescribeObject(actual), EXPDescribeObject(expected), [NSString class], [NSArray class], [NSOrderedSet class]];
    
    return [NSString stringWithFormat:@"expected: %@ not to begin with %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
}
EXPMatcherImplementationEnd
