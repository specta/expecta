// Expecta - EXPMatchers+toContainTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toContainTest : SenTestCase {
  NSArray *array;
  NSString *string;
}
@end

@implementation EXPMatchers_toContainTest

- (void)setUp {
  array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
  string = @"foo|bar,baz";
}

- (void)test_toContain {
  assertPass(test_expect(array).toContain(@"foo"));
  assertPass(test_expect(array).toContain(@"bar"));
  assertPass(test_expect(array).toContain(@"baz"));
  assertPass(test_expect(string).toContain(@"foo"));
  assertPass(test_expect(string).toContain(@"bar"));
  assertPass(test_expect(string).toContain(@"baz"));
  assertFail(test_expect(array).toContain(@"qux"), ([NSString stringWithFormat:@"foo.m:123 expected %@ to contain qux", array]));
  assertFail(test_expect(string).toContain(@"qux"), @"foo.m:123 expected foo|bar,baz to contain qux");
  assertFail(test_expect(string).toContain(nil), @"foo.m:123 the expected value is nil/null");
  assertFail(test_expect([NSDictionary dictionary]).toContain(@"foo"), @"foo.m:123 {\n} is not an instance of NSString or NSArray");
}

- (void)test_Not_toContain {
  assertPass(test_expect(array).Not.toContain(@"qux"));
  assertPass(test_expect(array).Not.toContain(@"quux"));
  assertPass(test_expect(string).Not.toContain(@"qux"));
  assertPass(test_expect(string).Not.toContain(@"quux"));
  assertFail(test_expect(array).Not.toContain(@"foo"), ([NSString stringWithFormat:@"foo.m:123 expected %@ not to contain foo", array]));
  assertFail(test_expect(string).Not.toContain(@"baz"), @"foo.m:123 expected foo|bar,baz not to contain baz");
  assertFail(test_expect(string).Not.toContain(nil), @"foo.m:123 the expected value is nil/null");
  assertFail(test_expect([NSDictionary dictionary]).Not.toContain(@"foo"), @"foo.m:123 {\n} is not an instance of NSString or NSArray");
}

@end
