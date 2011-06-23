#import "Expecta.h"

EXMatcherInterface(toBeInstanceOf, (Class expected));

#define toBeAnInstanceOf toBeInstanceOf
#define toBeMemberOf toBeInstanceOf
#define toBeAMemberOf toBeInstanceOf
