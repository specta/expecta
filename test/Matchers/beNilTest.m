#import "TestHelper.h"
#import "EXTestCase.h"

@interface beNilTest : EXTestCase; @end
@implementation beNilTest

- (void)test_to_beNil {
  obj.actual = nil;
  assertPass([obj.to beNil]);
  obj.actual = @"foo";
  assertFail([obj.to beNil], @"foo.m:123 expected: nil, got: @\"foo\"");
}

- (void)test_notTo_beNil {
  obj.actual = @"foo";
  assertPass([obj.notTo beNil]);
  obj.actual = nil;
  assertFail([obj.notTo beNil], @"foo.m:123 expected: not nil, got: nil");
}

@end
