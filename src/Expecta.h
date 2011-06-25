// Expecta - Expecta.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import <Foundation/Foundation.h>
#import "ExpectaSupport.h"

#define EXPObjectify(value) _EXPObjectify(@encode(__typeof__((value))), (value))

#define EXP_expect(actual) _EXP_expect(self, __LINE__, __FILE__, EXPObjectify((actual)))

#define EXPMatcherInterface(matcherName, matcherArguments) _EXPMatcherInterface(matcherName, matcherArguments)
#define EXPMatcherImplementationBegin(matcherName, matcherArguments) _EXPMatcherImplementationBegin(matcherName, matcherArguments)
#define EXPMatcherImplementationEnd _EXPMatcherImplementationEnd

#import "EXPMatchers.h"

#ifdef EXP_SHORTHAND
#  define expect(actual) EXP_expect((actual))
#endif
