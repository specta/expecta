#import "EXPMatchers+conformTo.h"
#import "NSValue+Expecta.h"
#import <objc/runtime.h>

EXPMatcherImplementationBegin(conformTo, (Protocol *expected)) {
  BOOL (^actualIsNil)(id actual) = ^BOOL(id actual){ return (actual == nil); };
    BOOL expectedIsNil = (expected == nil);

    prerequisite(^BOOL(id actual){
        return !(actualIsNil(actual) || expectedIsNil);
    });

    match(^BOOL(id actual){
        return [actual conformsToProtocol:expected];
    });

    failureMessageForTo(^NSString *(id actual){
        if(actualIsNil(actual)) return @"the object is nil/null";
        if(expectedIsNil) return @"the protocol is nil/null";

        NSString *name = NSStringFromProtocol(expected);
        return [NSString stringWithFormat:@"expected: %@ to conform to %@", actual, name];
    });

    failureMessageForNotTo(^NSString *(id actual){
        if(actualIsNil(actual)) return @"the object is nil/null";
        if(expectedIsNil) return @"the protocol is nil/null";

        NSString *name = NSStringFromProtocol(expected);
        return [NSString stringWithFormat:@"expected: %@ not to conform to %@", actual, name];
    });
}
EXPMatcherImplementationEnd
