#import "FakeTestCase.h"
#import <objc/runtime.h>

@implementation FakeTestCase

#ifdef USE_XCTEST
- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected {
    [NSException raise:description format:nil];
}
#else
- (void)failWithException:(NSException *)exception {
  NSException *e = [NSException exceptionWithName:[exception reason] reason:[exception reason] userInfo:nil];
  [e raise];
}
#endif


@end
