#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beLessThanOrEqualTo, (id expected));
EXPMatcherInterface(beLessThanOrEqualTo, (id expected));

#define beLessThanOrEqualTo(expected) _beLessThanOrEqualTo(EXPObjectify((expected)))