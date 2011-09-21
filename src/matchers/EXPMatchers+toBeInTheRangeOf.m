#import "EXPMatchers+toBeInTheRangeOf.h"
#import "EXPMatcherHelpers.h"

EXPMatcherImplementationBegin(_toBeInTheRangeOf, (id expectedLowerBound, id expectedUpperBound)) {
    match(^BOOL{
        if ([actual respondsToSelector:@selector(compare:)]) {
            NSComparisonResult compareLowerBound = [expectedLowerBound compare: actual]; 
            NSComparisonResult compareUpperBound = [expectedUpperBound compare: actual];
            if (compareLowerBound == NSOrderedSame) {
                return YES;
            }
            if (compareUpperBound == NSOrderedSame) {
                return YES;
            }
            if ((compareLowerBound == NSOrderedAscending) && (compareUpperBound == NSOrderedDescending)) {
                return YES;
            }
        }
        return NO;
    });
    
    failureMessageForTo(^NSString *{
        return @"fail";
//        return [NSString stringWithFormat:@"expected: %@ to be greater than %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
    });
     
    failureMessageForNotTo(^NSString *{
        return @"fail";
//        return [NSString stringWithFormat:@"expected: %@ not to be greater than %@", EXPDescribeObject(actual), EXPDescribeObject(expected)];
    });
}
EXPMatcherImplementationEnd