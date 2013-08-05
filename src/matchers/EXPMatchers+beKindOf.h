#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(beKindOf, (Class expected));

#define beAKindOf beKindOf
