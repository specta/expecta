#import "EXPMatchers+contain.h"

EXPMatcherImplementationBegin(beSupersetOf, (id subset)) {
  BOOL (^actualIsCompatible)(id actual) = ^BOOL(id actual){ return [actual isKindOfClass:[NSDictionary class]] || [actual respondsToSelector:@selector(containsObject:)]; };
  BOOL subsetIsNil = (subset == nil);
  BOOL (^classMatches)(id actual) = ^BOOL(id actual){ return [subset isKindOfClass:[actual class]]; };

  prerequisite(^BOOL(id actual){
    return actualIsCompatible(actual) && !subsetIsNil && classMatches(actual);
  });

  match(^BOOL(id actual){
    if(!actualIsCompatible(actual)) return NO;

    if([actual isKindOfClass:[NSDictionary class]]) {
      for (id key in subset) {
        id actualValue = [actual valueForKey:key];
        id subsetValue = [subset valueForKey:key];

        if (![subsetValue isEqual:actualValue]) return NO;
      }
    } else {
      for (id object in subset) {
        if (![actual containsObject:object]) return NO;
      }
    }

    return YES;
  });

  failureMessageForTo(^NSString *(id actual){
    if(!actualIsCompatible(actual)) return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary and does not implement -containsObject:", EXPDescribeObject(actual)];

    if(subsetIsNil) return @"the expected value is nil/null";

    if(!classMatches(actual)) return [NSString stringWithFormat:@"%@ does not match the class of %@", EXPDescribeObject(subset), EXPDescribeObject(actual)];

    return [NSString stringWithFormat:@"expected %@ to be a superset of %@", EXPDescribeObject(actual), EXPDescribeObject(subset)];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if(!actualIsCompatible(actual)) return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary and does not implement -containsObject:", EXPDescribeObject(actual)];

    if(subsetIsNil) return @"the expected value is nil/null";

    if(!classMatches(actual)) return [NSString stringWithFormat:@"%@ does not match the class of %@", EXPDescribeObject(subset), EXPDescribeObject(actual)];

    return [NSString stringWithFormat:@"expected %@ not to be a superset of %@", EXPDescribeObject(actual), EXPDescribeObject(subset)];
  });
}
EXPMatcherImplementationEnd
