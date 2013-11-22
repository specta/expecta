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
  
  assertPass(test_expect(^{
    NSNotification *notification = [NSNotification
              notificationWithName:@"NotificationName" object:nil];
    
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostWhenIdle
     coalesceMask:NSNotificationCoalescingOnName
     forModes:nil];
    
  }).will.notify(@"NotificationName"));
  
  assertFail(test_expect(^{
    // no notification
  }).to.notify(@"testNotification2"),
             @"expected: testNotification2, got: none");
  
  assertFail(test_expect(nil).to.notify(@"testNotification"),
             @"the actual value is nil/null");
  
  assertFail(test_expect(^{
    // no notification
  }).to.notify(nil),
             @"the expected value is nil/null");
  
  assertFail(test_expect(^{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).to.notify(@"testNotification2"),
             @"expected: testNotification2, got: testNotification1");
  
  assertFail(test_expect(^{
    // not doing anything
  }).to.notify([[NSObject alloc] init]), @"the actual value is not a notification or string");
}

- (void)test_toNot_notify {
  assertPass(test_expect(^{
    // no notification
  }).notTo.notify(@"testExpectaNotification1"));
  
  assertFail(test_expect(^{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).toNot.notify(@"testNotification1"),
             @"expected: none, got: testNotification1");
  
  assertPass(test_expect(^{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification1" object:nil];
  }).notTo.notify(@"testNotification2"));
  
  NSNotification *n1 = [[NSNotification alloc] initWithName:@"testNotification4" object:self userInfo:nil];
  NSNotification *n2 = [[NSNotification alloc] initWithName:@"testNotification4" object:nil userInfo:nil];
  assertPass(test_expect(^{
    [[NSNotificationCenter defaultCenter] postNotification:n1];
  }).toNot.notify(n2));
  
  assertPass(test_expect(^{
    // no notification
  }).willNot.notify(@"NotificationName"));
  
  
  assertFail(test_expect(nil).toNot.notify(@"testNotification"),
             @"the actual value is nil/null");
  
  assertFail(test_expect(^{
    // no notification
  }).toNot.notify(nil),
             @"the expected value is nil/null");
  
  assertFail(test_expect(^{
    // no notification
  }).toNot.notify([[NSObject alloc] init]), @"the actual value is not a notification or string");
  
}

@end