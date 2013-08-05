#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_beInTheRangeOf, (id expectedLowerBound, id expectedUpperBound));
EXPMatcherInterface(beInTheRangeOf, (id expectedLowerBound, id expectedUpperBound));

#define beInTheRangeOf(expectedLowerBound, expectedUpperBound) _beInTheRangeOf(EXPObjectify((expectedLowerBound)), EXPObjectify((expectedUpperBound)))