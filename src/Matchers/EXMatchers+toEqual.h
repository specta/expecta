#import "Expecta.h"
#define toEqual(expected) _toEqual(EXObjectify((expected)))

EXMatcherInterface(_toEqual, (id expected));
