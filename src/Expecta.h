#import <Foundation/Foundation.h>

#import "EXExpect.h"
#define EXMatchers EXExpect

#import "EXUnsupportedObject.h"

id _EXObjectify(char *type, ...);
#define EXObjectify(value) _EXObjectify(@encode(__typeof__(value)), (value))

EXExpect *_EX_expect(id testCase, int lineNumber, char *fileName, id actual);
#define expect(actual) _EX_expect(self, __LINE__, __FILE__, EXObjectify(actual))

#define EXMatcherInterface(matcherName, matcherArguments) \
@interface EXExpect (matcherName##Matcher) \
@property (nonatomic, readonly) void(^ matcherName) matcherArguments; \
@end

#define EXMatcherImplementationBegin(matcherName, matcherArguments) \
@implementation EXExpect (matcherName##Matcher) \
- (void(^) matcherArguments) matcherName { \
  NSObject *actual = self.actual; \
  void (^matcherBlock) matcherArguments = ^ matcherArguments { \

#define EXMatcherImplementationEnd \
    [self applyMatcher]; \
  }; \
  return [[matcherBlock copy] autorelease]; \
} \
@end

NSString *EXDescribeObject(id obj);

#import "EXMatchers.h"
