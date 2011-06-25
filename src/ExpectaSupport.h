// Expecta - ExpectaSupport.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPExpect.h"

id _EXPObjectify(char *type, ...);
EXPExpect *_EXP_expect(id testCase, int lineNumber, char *fileName, id actual);

void EXPFail(id testCase, int lineNumber, char *fileName, NSString *message);
NSString *EXPDescribeObject(id obj);

// workaround for the categories bug: http://developer.apple.com/library/mac/#qa/qa1490/_index.html
#define EXPFixCategoriesBug(name) \
@interface EXPFixCategoriesBug##name; @end \
@implementation EXPFixCategoriesBug##name; @end

#define _EXPMatcherInterface(matcherName, matcherArguments) \
@interface EXPExpect (matcherName##Matcher) \
@property (nonatomic, readonly) void(^ matcherName) matcherArguments; \
@end

#define _EXPMatcherImplementationBegin(matcherName, matcherArguments) \
EXPFixCategoriesBug(EXPMatcher##matcherName##Matcher); \
@implementation EXPExpect (matcherName##Matcher) \
@dynamic matcherName;\
- (void(^) matcherArguments) matcherName { \
  id actual = self.actual; \
  void (^matcherBlock) matcherArguments = ^ matcherArguments { \
    {

#define _EXPMatcherImplementationEnd \
    } \
    [self applyMatcher]; \
  }; \
  return [[matcherBlock copy] autorelease]; \
} \
@end
