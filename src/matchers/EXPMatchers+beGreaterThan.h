#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beGreaterThan, (id expected));
EXPMatcherInterface(beGreaterThan, (id expected));

#define beGreaterThan(expected) _beGreaterThan(EXPObjectify((expected)))