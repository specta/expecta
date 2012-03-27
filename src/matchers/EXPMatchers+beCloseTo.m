#import "EXPMatchers+beCloseTo.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(_beCloseToWithin, (id expected, id within)) {
    prerequisite(^BOOL{
        return [actual isKindOfClass:[NSNumber class]] &&
		[expected isKindOfClass:[NSNumber class]] &&
		[within isKindOfClass:[NSNumber class]];
    });

    match(^BOOL{
        double actualValue = [actual doubleValue];
        double expectedValue = [expected doubleValue];
        double withinValue = [within doubleValue];
        double lowerBound = expectedValue - withinValue;
        double upperBound = expectedValue + withinValue;
        return (actualValue > lowerBound) && (actualValue < upperBound);
    });

    failureMessageForTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ to be close to %@ within %@", EXPDescribeObject(actual), EXPDescribeObject(expected), EXPDescribeObject(within)];
    });

    failureMessageForNotTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ to be close to %@ within %@", EXPDescribeObject(actual), EXPDescribeObject(expected), EXPDescribeObject(within)];
    });
}
EXPMatcherImplementationEnd