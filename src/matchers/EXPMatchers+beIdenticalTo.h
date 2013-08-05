#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beIdenticalTo, (void *expected));

#if __has_feature(objc_arc)
#define beIdenticalTo(expected) _beIdenticalTo((__bridge void*)expected)
#else
#define beIdenticalTo _beIdenticalTo
#endif
