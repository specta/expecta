#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(raiseWithReason, (NSString *expectedExceptionName, NSString *expectedReason));
