#import "EXPMatchers+conformTo.h"
#import "NSValue+Expecta.h"
#import <objc/runtime.h>

EXPMatcherImplementationBegin(conformTo, (Protocol *expected)) {
    match(^BOOL{
        return [actual conformsToProtocol:expected];
    });

    NSString *name = [NSString stringWithUTF8String:protocol_getName(expected)];

    failureMessageForTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ to conform to %@", actual, name];
    });

    failureMessageForNotTo(^NSString *{
        return [NSString stringWithFormat:@"expected: %@ not to conform to %@", actual, name];
    });
}
EXPMatcherImplementationEnd
