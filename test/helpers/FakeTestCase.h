#import "TestHelper.h"

@interface FakeTestCase : NSObject

#ifdef USE_XCTEST
- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected;
#else
- (void)failWithException:(NSException *)exception;
#endif

@end
