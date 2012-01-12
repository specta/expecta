#import "TestHelper.h"

@interface EXPMatchers_toBeKindOfTest : SenTestCase {
  Foo *foo;
  Bar *bar;
  Baz *baz;
  id qux;
}
@end

@implementation EXPMatchers_toBeKindOfTest

- (void)setUp {
  foo = [[Foo new] autorelease];
  bar = [[Bar new] autorelease];
  baz = [[Baz new] autorelease];
  qux = foo;
}

- (void)test_toBeKindOf {
  assertPass(test_expect(foo).toBeKindOf([Foo class]));
  assertPass(test_expect(bar).toBeKindOf([Bar class]));
  assertPass(test_expect(bar).toBeKindOf([Foo class]));
  assertFail(test_expect(nil).toBeKindOf([Foo class]), @"the actual value is nil/null");
  assertFail(test_expect(foo).toBeKindOf(nil), @"the expected value is nil/null");
  assertFail(test_expect(foo).toBeKindOf([Bar class]), @"expected: a kind of Bar, got: an instance of Foo, which is not a kind of Bar");
  assertFail(test_expect(bar).toBeKindOf([Baz class]), @"expected: a kind of Baz, got: an instance of Bar, which is not a kind of Baz");
  assertPass(test_expect(qux).toBeKindOf([Foo class]));
}

- (void)test_Not_toBeKindOf {
  assertPass(test_expect(foo).Not.toBeKindOf([Bar class]));
  assertPass(test_expect(bar).Not.toBeKindOf([Baz class]));
  assertPass(test_expect(baz).Not.toBeKindOf([Foo class]));
  assertFail(test_expect(nil).Not.toBeKindOf([Foo class]), @"the actual value is nil/null");
  assertFail(test_expect(foo).Not.toBeKindOf(nil), @"the expected value is nil/null");
  assertFail(test_expect(foo).Not.toBeKindOf([Foo class]), @"expected: not a kind of Foo, got: an instance of Foo, which is a kind of Foo");
  assertFail(test_expect(bar).Not.toBeKindOf([Foo class]), @"expected: not a kind of Foo, got: an instance of Bar, which is a kind of Foo");
  assertPass(test_expect(qux).Not.toBeKindOf([Bar class]));
}

- (void)test_toBeAKindOf {
  assertPass(test_expect(foo).toBeAKindOf([Foo class]));
}

@end
