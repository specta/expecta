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
  assertFail(test_expect(nil).toBeInstanceOf([Foo class]), @"the actual value is nil/null");
  assertFail(test_expect(foo).toBeInstanceOf(nil), @"the expected value is nil/null");
  assertFail(test_expect(foo).toBeInstanceOf([Bar class]), @"expected: an instance of Bar, got: an instance of Foo");
  assertFail(test_expect(bar).toBeInstanceOf([Foo class]), @"expected: an instance of Foo, got: an instance of Bar");
}

- (void)test_Not_toBeInstanceOf {
  assertPass(test_expect(foo).Not.toBeInstanceOf([Bar class]));
  assertPass(test_expect(bar).Not.toBeInstanceOf([Foo class]));
  assertFail(test_expect(nil).Not.toBeInstanceOf([Foo class]), @"the actual value is nil/null");
  assertFail(test_expect(foo).Not.toBeInstanceOf(nil), @"the expected value is nil/null");
  assertFail(test_expect(foo).Not.toBeInstanceOf([Foo class]), @"expected: not an instance of Foo, got: an instance of Foo");
  assertFail(test_expect(bar).Not.toBeInstanceOf([Bar class]), @"expected: not an instance of Bar, got: an instance of Bar");
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
