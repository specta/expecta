#import "TestHelper.h"

@interface EXPMatchers_notifyTest : TEST_SUPERCLASS
@end

@implementation EXPMatchers_notifyTest

- (void)test_notify {
  assertPass(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).to.notify(@"testNotification1"));

    
  NSNotification *n = [[NSNotification alloc] initWithName:@"testNotification2" object:self userInfo:nil];
  assertPass(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotification:n];
  }).to.notify(n));
    
    
  assertFail(test_expect(^{
    // not raising...
  }).to.notify(@"testNotification2"),
             @"expected: notification");

  assertFail(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
  }).to.notify(@"testExpectaNotification2"),
             @"expected: notification");
}

- (void)test_toNot_notify {
  assertPass(test_expect(^{
      // not causing anything
  }).notTo.notify(@"testExpectaNotification1"));

  assertFail(test_expect(^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
  }).toNot.notify(@"testExpectaNotification1"),
             @"expected: no notification");

    assertPass(test_expect(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testExpectaNotification1" object:nil];
    }).notTo.notify(@"testExpectaNotification2"));
    
    NSNotification *n1 = [[NSNotification alloc] initWithName:@"testNotification4" object:self userInfo:nil];
    NSNotification *n2 = [[NSNotification alloc] initWithName:@"testNotification4" object:nil userInfo:nil];
    assertPass(test_expect(^{
        [[NSNotificationCenter defaultCenter] postNotification:n1];
    }).toNot.notify(n2));
    
}

@end
