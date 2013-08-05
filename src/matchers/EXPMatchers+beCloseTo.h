#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beCloseToWithin, (id expected, id within));
EXPMatcherInterface(beCloseToWithin, (id expected, id within));

#define beCloseTo(expected) _beCloseToWithin(EXPObjectify((expected)), nil)
#define beCloseToWithin(expected, range) _beCloseToWithin(EXPObjectify((expected)), EXPObjectify((range)))