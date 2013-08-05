#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beLessThan, (id expected));
EXPMatcherInterface(beLessThan, (id expected));

#define beLessThan(expected) _beLessThan(EXPObjectify((expected)))