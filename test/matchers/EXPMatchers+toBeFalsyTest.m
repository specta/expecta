#import "TestHelper.h"

@interface EXPMatchers_toBeFalsyTest : SenTestCase {
  int *nullPointer;
}
@end

@implementation EXPMatchers_toBeFalsyTest

- (void)setUp {
  nullPointer = NULL;
}

- (void)test_toBeFalsy {
  assertPass(test_expect(NO).toBeFalsy());
  assertPass(test_expect(FALSE).toBeFalsy());
  assertPass(test_expect(0).toBeFalsy());
  assertPass(test_expect(nil).toBeFalsy());
  assertPass(test_expect(nullPointer).toBeFalsy());
  assertFail(test_expect(YES).toBeFalsy(), @"expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(TRUE).toBeFalsy(), @"expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(1).toBeFalsy(), @"expected: a falsy value, got: 1, which is truthy");
  assertFail(test_expect(123).toBeFalsy(), @"expected: a falsy value, got: 123, which is truthy");
  assertFail(test_expect(-123).toBeFalsy(), @"expected: a falsy value, got: -123, which is truthy");
  assertFail(test_expect(0.1).toBeFalsy(), @"expected: a falsy value, got: 0.1, which is truthy");
  assertFail(test_expect(@"hello").toBeFalsy(), @"expected: a falsy value, got: hello, which is truthy");
}

- (void)test_Not_toBeFalsy {
  assertPass(test_expect(YES).Not.toBeFalsy());
  assertPass(test_expect(TRUE).Not.toBeFalsy());
  assertPass(test_expect(1).Not.toBeFalsy());
  assertPass(test_expect(123).Not.toBeFalsy());
  assertPass(test_expect(-123).Not.toBeFalsy());
  assertPass(test_expect(0.1).Not.toBeFalsy());
  assertPass(test_expect(@"hello").Not.toBeFalsy());
  assertFail(test_expect(NO).Not.toBeFalsy(), @"expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(FALSE).Not.toBeFalsy(), @"expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(0).Not.toBeFalsy(), @"expected: a non-falsy value, got: 0, which is falsy");
  assertFail(test_expect(nil).Not.toBeFalsy(), @"expected: a non-falsy value, got: nil/null, which is falsy");
  assertFail(test_expect(nullPointer).Not.toBeFalsy(), @"expected: a non-falsy value, got: nil/null, which is falsy");
}

@end
