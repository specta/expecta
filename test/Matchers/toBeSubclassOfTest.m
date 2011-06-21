#import "TestHelper.h"

@interface toBeSubclassOfTest : SenTestCase
@end

@implementation toBeSubclassOfTest

- (void)test_toBeSubclassOf {
  assertPass(test_expect([Foo class]).toBeSubclassOf([Foo class]));
  assertPass(test_expect([Bar class]).toBeSubclassOf([Bar class]));
  assertPass(test_expect([Bar class]).toBeSubclassOf([Foo class]));
  assertFail(test_expect([Foo class]).toBeSubclassOf([Bar class]), @"foo.m:123 expected: a subclass of Bar, got: a class Foo, which is not a subclass of Bar");
  assertFail(test_expect([Bar class]).toBeSubclassOf([Baz class]), @"foo.m:123 expected: a subclass of Baz, got: a class Bar, which is not a subclass of Baz");
}

- (void)test_Not_toBeSubclassOf {
  assertPass(test_expect([Foo class]).Not.toBeSubclassOf([Bar class]));
  assertPass(test_expect([Bar class]).Not.toBeSubclassOf([Baz class]));
  assertPass(test_expect([Baz class]).Not.toBeSubclassOf([Foo class]));
  assertFail(test_expect([Foo class]).Not.toBeSubclassOf([Foo class]), @"foo.m:123 expected: not a subclass of Foo, got: a class Foo, which is a subclass of Foo");
  assertFail(test_expect([Bar class]).Not.toBeSubclassOf([Foo class]), @"foo.m:123 expected: not a subclass of Foo, got: a class Bar, which is a subclass of Foo");
}

- (void)test_toBeASubclassOf {
  assertPass(test_expect([Bar class]).toBeASubclassOf([Foo class]));
}

@end
