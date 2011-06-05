#import <Foundation/Foundation.h>

#import "EXExpect.h"
#define EXMatchers EXExpect

#define expectObject(actual) ([EXExpect expectWithActual:(actual) testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectPointer(actual) ([EXExpect expectWithActual:[NSValue valueWithPointer:(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectSelector expectPointer
#define expectClass expectPointer
#define expectChar(actual) ([EXExpect expectWithActual:[NSNumber numberWithChar:(char)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectDouble(actual) ([EXExpect expectWithActual:[NSNumber numberWithDouble:(double)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectFloat(actual) ([EXExpect expectWithActual:[NSNumber numberWithFloat:(float)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectInt(actual) ([EXExpect expectWithActual:[NSNumber numberWithInt:(int)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectLong(actual) ([EXExpect expectWithActual:[NSNumber numberWithLong:(long)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectLongLong(actual) ([EXExpect expectWithActual:[NSNumber numberWithLongLong:(long long)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectShort(actual) ([EXExpect expectWithActual:[NSNumber numberWithShort:(short)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectInteger(actual) ([EXExpect expectWithActual:[NSNumber numberWithInteger:(NSInteger)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedChar(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedChar:(unsigned char)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedInt(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedInt:(unsigned int)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedLong(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedLong:(unsigned long)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedLongLong(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedLongLong:(unsigned long long)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedShort(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedShort:(unsigned short)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])
#define expectUnsignedInteger(actual) ([EXExpect expectWithActual:[NSNumber numberWithUnsignedInteger:(NSUInteger)(actual)] testCase:self lineNumber:__LINE__ fileName:__FILE__])

EXExpect *EXExpectVariadic(id testCase, int lineNumber, char *fileName, const char *type, ...);

#define expect(actual) EXExpectVariadic(self, __LINE__, __FILE__, @encode(__typeof__(actual)), (actual))

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
