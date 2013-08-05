#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(haveCountOf, (NSUInteger expected));

#define haveCount     haveCountOf
#define haveACountOf  haveCountOf
#define haveLength    haveCountOf
#define haveLengthOf  haveCountOf
#define haveALengthOf haveCountOf
#define beEmpty()     haveCountOf(0)
