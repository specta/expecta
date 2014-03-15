#import "EXPMatchers+raise.h"
#import "EXPDefines.h"

EXPMatcherImplementationBegin(raise, (NSString *expectedExceptionName)) {
  __block NSException *exceptionCaught = nil;

  match(^BOOL(id actual){
    BOOL expectedExceptionCaught = NO;
    @try {
      ((EXPBasicBlock)actual)();
    } @catch(NSException *e) {
      exceptionCaught = e;
      expectedExceptionCaught = (expectedExceptionName == nil) || [[exceptionCaught name] isEqualToString:expectedExceptionName];
    }
    return expectedExceptionCaught;
  });

  failureMessageForTo(^NSString *(id actual){
    return [NSString stringWithFormat:@"expected: %@, got: %@",
            expectedExceptionName ? expectedExceptionName : @"any exception",
            exceptionCaught ? [exceptionCaught name] : @"no exception"];
  });

  failureMessageForNotTo(^NSString *(id actual){
    return [NSString stringWithFormat:@"expected: %@, got: %@",
            expectedExceptionName ? [NSString stringWithFormat:@"not %@", expectedExceptionName] : @"no exception",
            exceptionCaught ? [exceptionCaught name] : @"no exception"];
  });
}
EXPMatcherImplementationEnd
