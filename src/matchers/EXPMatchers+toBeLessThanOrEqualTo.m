#import "EXPMatchers+toBeLessThanOrEqualTo.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(_toBeLessThanOrEqualTo, (id expected)) {
    match(^BOOL{
        if ([actual respondsToSelector:@selector(compare:)]) {
            return [actual compare:expected] != NSOrderedDescending;
        }
        return NO;
    });

    failureMessageForTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ to be less than or equal to %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
    });

    failureMessageForNotTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ not to be less than or equal to %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
    });
}
EXPMatcherImplementationEnd