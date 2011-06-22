#import "TestHelper.h"

@interface toBeNilTest : SenTestCase {
  NSObject *nilObject;
  int *nullPointer;
}
@end

@implementation toBeNilTest

- (void)setUp {
  nilObject = nil;
  nullPointer = NULL;
}

- (void)test_toBeNil {
  assertPass(test_expect(nil).toBeNil());
  assertPass(test_expect(nilObject).toBeNil());
  assertFail(test_expect(@"foo").toBeNil(), @"foo.m:123 expected: nil/null, got: foo");
}

- (void)test_Not_toBeNil {
  assertPass(test_expect(@"foo").Not.toBeNil());
  assertFail(test_expect(nil).Not.toBeNil(), @"foo.m:123 expected: not nil/null, got: nil/null");
  assertFail(test_expect(nilObject).Not.toBeNil(), @"foo.m:123 expected: not nil/null, got: nil/null");
}

- (void)test_toBeNull {
  assertPass(test_expect(NULL).toBeNull());
  assertPass(test_expect(nullPointer).toBeNull());
}

- (void)test_Not_toBeNull {
  assertFail(test_expect(NULL).Not.toBeNull(), @"foo.m:123 expected: not nil/null, got: nil/null");
  assertFail(test_expect(nullPointer).Not.toBeNull(), @"foo.m:123 expected: not nil/null, got: nil/null");
}

@end
