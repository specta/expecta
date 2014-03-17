#import "Expecta.h"

EXPMatcherInterface(_beNil, (void));

#define beNull beNil
#define beNil() _beNil()
