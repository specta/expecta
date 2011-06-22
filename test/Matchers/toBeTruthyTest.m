#import "TestHelper.h"

@interface toBeTruthyTest : SenTestCase {
  int *nullPointer;
}
@end

@implementation toBeTruthyTest

- (void)setUp {
  nullPointer = NULL;
}

- (void)test_toBeTruthy {
  assertPass(test_expect(YES).toBeTruthy());
  assertPass(test_expect(TRUE).toBeTruthy());
  assertPass(test_expect(1).toBeTruthy());
  assertPass(test_expect(123).toBeTruthy());
  assertPass(test_expect(-123).toBeTruthy());
  assertPass(test_expect(0.1).toBeTruthy());
  assertPass(test_expect(@"hello").toBeTruthy());
  assertFail(test_expect(NO).toBeTruthy(), @"foo.m:123 expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(FALSE).toBeTruthy(), @"foo.m:123 expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(0).toBeTruthy(), @"foo.m:123 expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(nil).toBeTruthy(), @"foo.m:123 expected: a truthy value, got: nil, which is falsy");
  assertFail(test_expect(nullPointer).toBeTruthy(), @"foo.m:123 expected: a truthy value, got: NULL, which is falsy");
}

- (void)test_Not_toBeTruthy {
  assertPass(test_expect(NO).Not.toBeTruthy());
  assertPass(test_expect(FALSE).Not.toBeTruthy());
  assertPass(test_expect(0).Not.toBeTruthy());
  assertPass(test_expect(nil).Not.toBeTruthy());
  assertPass(test_expect(nullPointer).Not.toBeTruthy());
  assertFail(test_expect(YES).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(TRUE).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(1).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(123).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: 123, which is truthy");
  assertFail(test_expect(-123).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: -123, which is truthy");
  assertFail(test_expect(0.1).Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: 0.1, which is truthy");
  assertFail(test_expect(@"hello").Not.toBeTruthy(), @"foo.m:123 expected: a non-truthy value, got: hello, which is truthy");
}

@end
