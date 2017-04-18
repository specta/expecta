#import "EXPMatchers+respondTo.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(respondTo, (SEL expected)) {
  BOOL (^actualIsNil)(id actual) = ^BOOL(id actual){ return (actual == nil); };
  BOOL expectedIsNull = (expected == NULL);

  prerequisite (^BOOL(id actual){
    return !(actualIsNil(actual) || expectedIsNull);
  });

  match(^BOOL(id actual){
    return [actual respondsToSelector:expected];
  });

  failureMessageForTo(^NSString *(id actual){
    if (actualIsNil(actual)) return @"the object is nil/null";
    if (expectedIsNull) return @"the selector is null";
    return [NSString stringWithFormat:@"expected: %@ to respond to %@", EXPDescribeObject(actual), NSStringFromSelector(expected)];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if (actualIsNil(actual)) return @"the object is nil/null";
    if (expectedIsNull) return @"the selector is null";
    return [NSString stringWithFormat:@"expected: %@ not to respond to %@", EXPDescribeObject(actual), NSStringFromSelector(expected)];
  });
}
EXPMatcherImplementationEnd
