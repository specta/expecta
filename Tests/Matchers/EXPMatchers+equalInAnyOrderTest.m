#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface EXPMatchers_equalInAnyOrderTest : XCTestCase {
  NSArray *array;
  NSArray *outOfOrderArray;
}

@end

@implementation EXPMatchers_equalInAnyOrderTest

- (void) setUp {
  array = @[ @"foo", @"bar", @"baz" ];
  outOfOrderArray = @[ @"bar", @"foo", @"baz" ];
}

- (void)test_equal_nil {
  assertFail(test_expect(nil).equalInAnyOrder([NSArray array]), @"nil/null is not an instance of NSArray");
  assertFail(test_expect(array).equalInAnyOrder(nil), @"the expected value is nil/null");
}

- (void)test_toNot_equal_nil {
  assertFail(test_expect(nil).notTo.equalInAnyOrder([NSArray array]), @"nil/null is not an instance of NSArray");
  assertFail(test_expect(array).notTo.equalInAnyOrder(nil), @"the expected value is nil/null");
}

- (void)test_equal_object {
  assertPass(test_expect(array).equalInAnyOrder(outOfOrderArray));
  assertFail(test_expect(array).equalInAnyOrder(@[@"foo"]), (@"expected (foo, bar, baz) to be equal in any order to (foo)"));
}

- (void)test_toNot_equal_object {
  assertPass(test_expect(array).notTo.equalInAnyOrder(@[@"foo"]));
  assertFail(test_expect(array).notTo.equalInAnyOrder(outOfOrderArray), (@"expected (foo, bar, baz) to not be equal in any order to (bar, foo, baz)"));
}
@end
