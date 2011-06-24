// Expecta - EXPMatchers+toBeIdenticalToTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeIdenticalToTest : SenTestCase {
  NSMutableString *foo;
  NSMutableString *foo2;
  id foo3;
}
@end

@implementation EXPMatchers_toBeIdenticalToTest

- (void)setUp {
  foo  = [NSMutableString stringWithString:@"foo"];
  foo2 = [NSMutableString stringWithString:@"foo"];
  foo3 = foo;
}

- (void)test_toBe {
  assertPass(test_expect(nil).toBeIdenticalTo(nil));
  assertPass(test_expect(foo).toBeIdenticalTo(foo));
  assertPass(test_expect(foo).toBeIdenticalTo(foo3));
  assertFail(test_expect(foo).toBeIdenticalTo(foo2), ([NSString stringWithFormat:@"foo.m:123 expected: <%p>, got: <%p>", foo2, foo]));
  assertFail(test_expect(nil).toBeIdenticalTo(foo), ([NSString stringWithFormat:@"foo.m:123 expected: <%p>, got: <0x0>", foo]));
}

- (void)test_Not_toBe {
  assertPass(test_expect(foo).Not.toBeIdenticalTo(foo2));
  assertPass(test_expect(nil).Not.toBeIdenticalTo(foo));
  assertFail(test_expect(nil).Not.toBeIdenticalTo(nil), @"foo.m:123 expected: not <0x0>, got: <0x0>");
  assertFail(test_expect(foo).Not.toBeIdenticalTo(foo), ([NSString stringWithFormat:@"foo.m:123 expected: not <%p>, got: <%p>", foo, foo]));
  assertFail(test_expect(foo).Not.toBeIdenticalTo(foo3), ([NSString stringWithFormat:@"foo.m:123 expected: not <%p>, got: <%p>", foo, foo]));
}

@end
