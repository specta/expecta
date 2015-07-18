#import "EXPMatchers+equalsInAnyOrder.h"

EXPMatcherImplementationBegin(equalInAnyOrder, (id expected)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSArray class]];
  BOOL expectedIsCompatible = [expected isKindOfClass:[NSArray class]];
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL{
    return actualIsCompatible && !expectedIsNil && expectedIsCompatible;
  });

  match(^BOOL{
    if(!actualIsCompatible) return NO;
    if(!expectedIsCompatible) return NO;

    NSSet *actualSet = [NSSet setWithArray:actual];
    NSSet *expectedSet = [NSSet setWithArray:actual];

    if (![actualSet isEqualToSet:expectedSet]) return NO;

    return YES;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(actual)];
    if(!expectedIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(expected)];

    if(expectedIsNil) return @"the expected value is nil/null";


    return [NSString stringWithFormat:@"expected %@ to be a equal any order of %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(actual)];
    if(!expectedIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSArray", EXPDescribeObject(expected)];

    if(expectedIsNil) return @"the expected value is nil/null";


    return [NSString stringWithFormat:@"expected %@ to not be equal in any order of %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
  });
}
EXPMatcherImplementationEnd
