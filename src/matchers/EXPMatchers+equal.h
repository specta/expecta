#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_equal, (id expected));
EXPMatcherInterface(equal, (id expected)); // to aid code completion
#define equal(expected) _equal(EXPObjectify((expected)))
