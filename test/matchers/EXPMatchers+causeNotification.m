#import "TestHelper.h"

@interface EXPMatchers_causeNotificationTest : TEST_SUPERCLASS
@end

@implementation EXPMatchers_causeNotificationTest

- (void)test_causeNotification {
  assertPass(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).to.causeNotification(@"testNotification1"));

  assertFail(test_expect(^{
    // not raising...
  }).to.causeNotification(@"testNotification2"),
             @"expected: no notification, got: textExpectaNotification2");

  assertFail(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
  }).to.causeNotification(@"testExpectaNotification2"),
             @"expected: no notification, got: textExpectaNotification2");
}

- (void)test_toNot_causeNotification {
  assertPass(test_expect(^{
      // not causing anything
  }).notTo.causeNotification(@"testExpectaNotification1"));

  assertFail(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
  }).notTo.causeNotification(@"testExpectaNotification1"),
             @"expected: no notification, got: testExpectaNotification1");

    assertPass(test_expect(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
    }).notTo.causeNotification(@"testExpectaNotification2"));
}

@end
