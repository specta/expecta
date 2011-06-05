#import "TestHelper.h"

@interface toBeNilTest : SenTestCase
@end

@implementation toBeNilTest

- (void)test_to_beNil {
  assertPass(test_expect(nil).toBeNil());
  assertFail(test_expect(@"foo").toBeNil(), @"foo.m:123 expected: nil, got: @\"foo\"");
}

- (void)test_Not_toBeNil {
  assertPass(test_expect(@"foo").Not.toBeNil());
  assertFail(test_expect(nil).Not.toBeNil(), @"foo.m:123 expected: not nil, got: nil");
}

@end
