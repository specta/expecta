#import "TestHelper.h"

@interface AsynchronousTestingTest : TEST_SUPERCLASS

@property(nonatomic, retain) NSArray *collection;

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
  
  assertPass(test_expect(foo).will.equal(@"foo"));
  assertFail(test_expect(foo).will.equal(@"bar"), @"expected: bar, got: foo");
}

- (void)test_isGoing_elements {
  [self performSelector:@selector(performBlock:) withObject:[[^{
    self.collection = @[ @1, @1 ];
  } copy] autorelease] afterDelay:0.1];
  
  assertPass(test_expect(self.collection).elements.will.equal(1));
  assertFail(test_expect(self.collection).elements.will.equal(2), @"(0)=> expected: 2, got: 1, (1)=> expected: 2, got: 1");
}

- (void)test_isNotGoing {
  __block NSString *foo = @"bar";
  [self performSelector:@selector(performBlock:) withObject:[[^{
    foo = @"foo";
  } copy] autorelease] afterDelay:0.1];
  assertPass(test_expect(foo).willNot.equal(@"bar"));
  assertFail(test_expect(foo).willNot.equal(@"foo"), @"expected: not foo, got: foo");
}

- (void)test_Expecta_setAsynchronousTestTimeout {
  assertEquals([Expecta asynchronousTestTimeout], 1.0);
  [Expecta setAsynchronousTestTimeout: 10.0];
  assertEquals([Expecta asynchronousTestTimeout], 10.0);
  [Expecta setAsynchronousTestTimeout: 1.0];
  assertEquals([Expecta asynchronousTestTimeout], 1.0);
}

@end
