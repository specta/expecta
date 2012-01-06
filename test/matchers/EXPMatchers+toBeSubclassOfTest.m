// Expecta - EXPMatchers+toBeSubclassOfTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeSubclassOfTest : SenTestCase
@end

@implementation EXPMatchers_toBeSubclassOfTest

- (void)test_toBeSubclassOf {
  assertPass(test_expect([Foo class]).toBeSubclassOf([Foo class]));
  assertPass(test_expect([Bar class]).toBeSubclassOf([Bar class]));
  assertPass(test_expect([Bar class]).toBeSubclassOf([Foo class]));
  assertFail(test_expect([Foo class]).toBeSubclassOf([Bar class]), @"expected: a subclass of Bar, got: a class Foo, which is not a subclass of Bar");
  assertFail(test_expect([Bar class]).toBeSubclassOf([Baz class]), @"expected: a subclass of Baz, got: a class Bar, which is not a subclass of Baz");
  assertFail(test_expect(@"foo").toBeSubclassOf([Baz class]), @"the actual value is not a Class");
}

- (void)test_Not_toBeSubclassOf {
  assertPass(test_expect([Foo class]).Not.toBeSubclassOf([Bar class]));
  assertPass(test_expect([Bar class]).Not.toBeSubclassOf([Baz class]));
  assertPass(test_expect([Baz class]).Not.toBeSubclassOf([Foo class]));
  assertFail(test_expect([Foo class]).Not.toBeSubclassOf([Foo class]), @"expected: not a subclass of Foo, got: a class Foo, which is a subclass of Foo");
  assertFail(test_expect([Bar class]).Not.toBeSubclassOf([Foo class]), @"expected: not a subclass of Foo, got: a class Bar, which is a subclass of Foo");
  assertFail(test_expect(@"foo").Not.toBeSubclassOf([Baz class]), @"the actual value is not a Class");
}

- (void)test_toBeASubclassOf {
  assertPass(test_expect([Bar class]).toBeASubclassOf([Foo class]));
}

@end
