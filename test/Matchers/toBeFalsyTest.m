#import "TestHelper.h"

@interface toBeFalsyTest : SenTestCase {
  int *nullPointer;
}
@end

@implementation toBeFalsyTest

- (void)setUp {
  nullPointer = NULL;
}

- (void)test_toBeFalsy {
  assertPass(test_expect(NO).toBeFalsy());
  assertPass(test_expect(FALSE).toBeFalsy());
  assertPass(test_expect(0).toBeFalsy());
  assertPass(test_expect(nil).toBeFalsy());
  assertPass(test_expect(nullPointer).toBeFalsy());
  assertFail(test_expect(YES).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(TRUE).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(1).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(123).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: 123, which is truthy");
  assertFail(test_expect(-123).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: -123, which is truthy");
  assertFail(test_expect(0.1).toBeFalsy(), @"foo.m:123 expected: a falsy value, got: 0.1, which is truthy");
  assertFail(test_expect(@"hello").toBeFalsy(), @"foo.m:123 expected: a falsy value, got: hello, which is truthy");
}

- (void)test_Not_toBeFalsy {
  assertPass(test_expect(YES).Not.toBeFalsy());
  assertPass(test_expect(TRUE).Not.toBeFalsy());
  assertPass(test_expect(1).Not.toBeFalsy());
  assertPass(test_expect(123).Not.toBeFalsy());
  assertPass(test_expect(-123).Not.toBeFalsy());
  assertPass(test_expect(0.1).Not.toBeFalsy());
  assertPass(test_expect(@"hello").Not.toBeFalsy());
  assertFail(test_expect(NO).Not.toBeFalsy(), @"foo.m:123 expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(FALSE).Not.toBeFalsy(), @"foo.m:123 expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(0).Not.toBeFalsy(), @"foo.m:123 expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(nil).Not.toBeFalsy(), @"foo.m:123 expected: a non-falsy value, got: nil/null, which is falsy");
  assertFail(test_expect(nullPointer).Not.toBeFalsy(), @"foo.m:123 expected: a non-falsy value, got: nil/null, which is falsy");
}

@end
