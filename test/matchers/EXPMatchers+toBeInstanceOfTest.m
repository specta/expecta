// Expecta - EXPMatchers+toBeInstanceOfTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeInstanceOfTest : SenTestCase {
  Foo *foo;
  Bar *bar;
}
@end

@implementation EXPMatchers_toBeInstanceOfTest

- (void)setUp {
  foo = [[Foo new] autorelease];
  bar = [[Bar new] autorelease];
}

- (void)test_toBeInstanceOf {
  assertPass(test_expect(foo).toBeInstanceOf([Foo class]));
  assertPass(test_expect(bar).toBeInstanceOf([Bar class]));
  assertFail(test_expect(foo).toBeInstanceOf([Bar class]), @"foo.m:123 expected: an instance of Bar, got: an instance of Foo");
  assertFail(test_expect(bar).toBeInstanceOf([Foo class]), @"foo.m:123 expected: an instance of Foo, got: an instance of Bar");
}

- (void)test_Not_toBeInstanceOf {
  assertPass(test_expect(foo).Not.toBeInstanceOf([Bar class]));
  assertPass(test_expect(bar).Not.toBeInstanceOf([Foo class]));
  assertFail(test_expect(foo).Not.toBeInstanceOf([Foo class]), @"foo.m:123 expected: not an instance of Foo, got: an instance of Foo");
  assertFail(test_expect(bar).Not.toBeInstanceOf([Bar class]), @"foo.m:123 expected: not an instance of Bar, got: an instance of Bar");
}

- (void)test_toBeAnInstanceOf {
  assertPass(test_expect(foo).toBeAnInstanceOf([Foo class]));
}

- (void)test_toBeMemberOf {
  assertPass(test_expect(foo).toBeMemberOf([Foo class]));
}

- (void)test_toBeAMemberOf {
  assertPass(test_expect(foo).toBeAMemberOf([Foo class]));
}

@end
