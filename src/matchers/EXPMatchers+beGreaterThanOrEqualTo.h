#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beGreaterThanOrEqualTo, (id expected));
EXPMatcherInterface(beGreaterThanOrEqualTo, (id expected));

#define beGreaterThanOrEqualTo(expected) _beGreaterThanOrEqualTo(EXPObjectify((expected)))