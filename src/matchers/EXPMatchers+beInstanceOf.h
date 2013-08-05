#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(beInstanceOf, (Class expected));

#define beAnInstanceOf beInstanceOf
#define beMemberOf beInstanceOf
#define beAMemberOf beInstanceOf
