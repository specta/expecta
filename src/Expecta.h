#import "EXExpect.h"
#import "EXExpect+BeNil.h"

#define expect(actual) [EXExpect expectWithActual:(actual) testCase:self lineNumber:__LINE__ fileName:__FILE__]

#define ExpectaException @"Expecta Error"
