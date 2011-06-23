// Expecta - EXPMatchers+toBeKindOfTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeKindOfTest : SenTestCase {
  Foo *foo;
  Bar *bar;
  Baz *baz;
}
@end

@implementation EXPMatchers_toBeKindOfTest

- (void)setUp {
  foo = [[Foo new] autorelease];
  bar = [[Bar new] autorelease];
  baz = [[Baz new] autorelease];
}

- (void)test_toBeKindOf {
  assertPass(test_expect(foo).toBeKindOf([Foo class]));
  assertPass(test_expect(bar).toBeKindOf([Bar class]));
  assertPass(test_expect(bar).toBeKindOf([Foo class]));
  assertFail(test_expect(foo).toBeKindOf([Bar class]), @"foo.m:123 expected: a kind of Bar, got: an instance of Foo, which is not a kind of Bar");
  assertFail(test_expect(bar).toBeKindOf([Baz class]), @"foo.m:123 expected: a kind of Baz, got: an instance of Bar, which is not a kind of Baz");
}

- (void)test_Not_toBeKindOf {
  assertPass(test_expect(foo).Not.toBeKindOf([Bar class]));
  assertPass(test_expect(bar).Not.toBeKindOf([Baz class]));
  assertPass(test_expect(baz).Not.toBeKindOf([Foo class]));
  assertFail(test_expect(foo).Not.toBeKindOf([Foo class]), @"foo.m:123 expected: not a kind of Foo, got: an instance of Foo, which is a kind of Foo");
  assertFail(test_expect(bar).Not.toBeKindOf([Foo class]), @"foo.m:123 expected: not a kind of Foo, got: an instance of Bar, which is a kind of Foo");
}

- (void)test_toBeAKindOf {
  assertPass(test_expect(foo).toBeAKindOf([Foo class]));
}

@end
