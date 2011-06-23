// Expecta - Expecta.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

#define EXPFixCategoriesBug(name) \
@interface EXPFixCategoriesBug##name; @end \
@implementation EXPFixCategoriesBug##name; @end

#import "EXPExpect.h"
#define EXPMatchers EXPExpect

#import "EXPUnsupportedObject.h"

id _EXObjectify(char *type, ...);
#define EXPObjectify(value) _EXObjectify(@encode(__typeof__((value))), (value))

EXPExpect *_EX_expect(id testCase, int lineNumber, char *fileName, id actual);
#define expect(actual) _EX_expect(self, __LINE__, __FILE__, EXPObjectify((actual)))

#define EXPMatcherInterface(matcherName, matcherArguments) \
@interface EXPExpect (matcherName##Matcher) \
@property (nonatomic, readonly) void(^ matcherName) matcherArguments; \
@end

#define EXPMatcherImplementationBegin(matcherName, matcherArguments) \
EXPFixCategoriesBug(EXPMatcher##matcherName##Matcher); \
\
@implementation EXPExpect (matcherName##Matcher) \
- (void(^) matcherArguments) matcherName { \
  NSObject *actual = self.actual; \
  void (^matcherBlock) matcherArguments = ^ matcherArguments { \

#define EXPMatcherImplementationEnd \
    [self applyMatcher]; \
  }; \
  return [[matcherBlock copy] autorelease]; \
} \
@end

NSString *EXPDescribeObject(id obj);

#import "EXPMatchers.h"
