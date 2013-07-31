#import <Foundation/Foundation.h>

@interface NSObject (Expecta)
- (void)failWithException:(NSException *)exception;
- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected;
@end
