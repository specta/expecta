// Expecta - AsynchronousTestingTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface AsynchronousTestingTest : SenTestCase
@end

@implementation AsynchronousTestingTest

- (void)performBlock:(void(^)())block {
  block();
}

- (void)test_isGoing {
  __block NSString *foo = @"";
  [self performSelector:@selector(performBlock:) withObject:[[^{
    foo = @"foo";
  } copy] autorelease] afterDelay:0.1];
  assertPass(test_expect(foo).isGoing.toEqual(@"foo"));
  assertFail(test_expect(foo).isGoing.toEqual(@"bar"), @"foo.m:123 expected: bar, got: foo");
}

- (void)test_isNotGoing {
  __block NSString *foo = @"";
  [self performSelector:@selector(performBlock:) withObject:[[^{
    foo = @"foo";
  } copy] autorelease] afterDelay:0.1];
  assertPass(test_expect(foo).isNotGoing.toEqual(@"bar"));
  assertFail(test_expect(foo).isNotGoing.toEqual(@"foo"), @"foo.m:123 expected: not foo, got: foo");
}

- (void)test_Expecta_setAsynchronousTestTimeout {
  assertEquals([Expecta asynchronousTestTimeout], 1.0);
  [Expecta setAsynchronousTestTimeout: 10.0];
  assertEquals([Expecta asynchronousTestTimeout], 10.0);
  [Expecta setAsynchronousTestTimeout: 1.0];
  assertEquals([Expecta asynchronousTestTimeout], 1.0);
}

@end
