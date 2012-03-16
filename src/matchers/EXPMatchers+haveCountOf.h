#import "Expecta.h"

EXPMatcherInterface(haveCountOf, (NSUInteger expected));

#define haveCount haveCountOf
#define beEmpty() haveCountOf(0)
