// Expecta - EXPMatchers+toBeNilTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"

@interface EXPMatchers_toBeNilTest : SenTestCase {
  NSObject *nilObject;
  int *nullPointer;
}
@end

@implementation EXPMatchers_toBeNilTest

- (void)setUp {
  nilObject = nil;
  nullPointer = NULL;
}

- (void)test_toBeNil {
  assertPass(test_expect(nil).toBeNil());
  assertPass(test_expect(nilObject).toBeNil());
  assertFail(test_expect(@"foo").toBeNil(), @"expected: nil/null, got: foo");
}

- (void)test_Not_toBeNil {
  assertPass(test_expect(@"foo").Not.toBeNil());
  assertFail(test_expect(nil).Not.toBeNil(), @"expected: not nil/null, got: nil/null");
  assertFail(test_expect(nilObject).Not.toBeNil(), @"expected: not nil/null, got: nil/null");
}

- (void)test_toBeNull {
  assertPass(test_expect(NULL).toBeNull());
  assertPass(test_expect(nullPointer).toBeNull());
}

- (void)test_Not_toBeNull {
  assertFail(test_expect(NULL).Not.toBeNull(), @"expected: not nil/null, got: nil/null");
  assertFail(test_expect(nullPointer).Not.toBeNull(), @"expected: not nil/null, got: nil/null");
}

@end
