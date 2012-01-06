// Expecta - EXPMatchers+toBeTruthyTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeTruthyTest : SenTestCase {
  int *nullPointer;
}
@end

@implementation EXPMatchers_toBeTruthyTest

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
  assertFail(test_expect(NO).toBeTruthy(), @"expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(FALSE).toBeTruthy(), @"expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(0).toBeTruthy(), @"expected: a truthy value, got: 0, which is falsy");
  assertFail(test_expect(nil).toBeTruthy(), @"expected: a truthy value, got: nil/null, which is falsy");
  assertFail(test_expect(nullPointer).toBeTruthy(), @"expected: a truthy value, got: nil/null, which is falsy");
}

- (void)test_Not_toBeTruthy {
  assertPass(test_expect(NO).Not.toBeTruthy());
  assertPass(test_expect(FALSE).Not.toBeTruthy());
  assertPass(test_expect(0).Not.toBeTruthy());
  assertPass(test_expect(nil).Not.toBeTruthy());
  assertPass(test_expect(nullPointer).Not.toBeTruthy());
  assertFail(test_expect(YES).Not.toBeTruthy(), @"expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(TRUE).Not.toBeTruthy(), @"expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(1).Not.toBeTruthy(), @"expected: a non-truthy value, got: 1, which is truthy");
  assertFail(test_expect(123).Not.toBeTruthy(), @"expected: a non-truthy value, got: 123, which is truthy");
  assertFail(test_expect(-123).Not.toBeTruthy(), @"expected: a non-truthy value, got: -123, which is truthy");
  assertFail(test_expect(0.1).Not.toBeTruthy(), @"expected: a non-truthy value, got: 0.1, which is truthy");
  assertFail(test_expect(@"hello").Not.toBeTruthy(), @"expected: a non-truthy value, got: hello, which is truthy");
}

@end
