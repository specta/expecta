#import "Expecta.h"

EXPMatcherInterface(_beCloseToWithin, (id expected, id within));
EXPMatcherInterface(beCloseToWithin, (id expected, id within));

#define beCloseTo(expected) _beCloseToWithin(EXPObjectify((expected)), EXPObjectify(0.1))
#define beCloseToWithin(expected, range) _beCloseToWithin(EXPObjectify((expected)), EXPObjectify((range)))