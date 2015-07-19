#import "EXPMatchers+equalsInAnyOrder.h"

EXPMatcherImplementationBegin(equalInAnyOrder, (id expected)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSArray class]];
  BOOL expectedIsNil = (expected == nil);

  BOOL sameClass = [expected isKindOfClass:[actual class]];
  prerequisite(^BOOL{
    return actualIsCompatible && !expectedIsNil;
  });

  match(^BOOL{
    if(!actualIsCompatible) return NO;

    NSSet *actualSet = [NSSet setWithArray:actual];
    NSSet *expectedSet = [NSSet setWithArray:expected];

    if (![actualSet isEqualToSet:expectedSet]) return NO;

    return YES;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(actual)];

    if(expectedIsNil) return @"the expected value is nil/null";


    return [NSString stringWithFormat:@"expected %@ to be equal in any order to %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(actual)];

    if(expectedIsNil) return @"the expected value is nil/null";


    return [NSString stringWithFormat:@"expected %@ to not be equal in any order to %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
}
EXPMatcherImplementationEnd
