#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/Expecta.h>
#else
#import "Expecta.h"
#endif

EXPMatcherInterface(_contain, (id expected));
EXPMatcherInterface(contain, (id expected)); // to aid code completion
#define contain(expected) _contain(EXPObjectify((expected)))
