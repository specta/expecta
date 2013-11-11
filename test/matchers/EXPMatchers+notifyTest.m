#import "TestHelper.h"

@interface EXPMatchers_notifyTest : TEST_SUPERCLASS
@end

@implementation EXPMatchers_notifyTest

- (void)test_notify {
  assertPass(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).to.notify(@"testNotification1"));

//  assertFail(test_expect(^{
//    // not raising...
//  }).to.notify(@"testNotification2"),
//             @"expected: no notification, got: textExpectaNotification2");

//  assertFail(test_expect(^{
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
//  }).to.notify(@"testExpectaNotification2"),
//             @"expected: no notification, got: testExpectaNotification2");
}

- (void)test_toNot_notify {
  assertPass(test_expect(^{
      // not causing anything
  }).notTo.notify(@"testExpectaNotification1"));

//  assertFail(test_expect(^{
//      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
//  }).notTo.notify(@"testExpectaNotification1"),
//             @"expected: no notification, got: testExpectaNotification1");

    assertPass(test_expect(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
    }).notTo.notify(@"testExpectaNotification2"));
}

@end
