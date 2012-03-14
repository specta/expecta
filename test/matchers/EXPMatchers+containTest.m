#import "TestHelper.h"

@interface EXPMatchers_containTest : SenTestCase {
  NSArray *array, *array2;
  NSString *string;
}
@end

@implementation EXPMatchers_containTest

- (void)setUp {
  array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
  array2 = [NSArray arrayWithObjects:[NSString class], [NSDictionary class], nil];
  string = @"foo|bar,baz";
}

- (void)test_contain {
  assertPass(test_expect(array).contain(@"foo"));
  assertPass(test_expect(array).contain(@"bar"));
  assertPass(test_expect(array).contain(@"baz"));
  assertPass(test_expect(string).contain(@"foo"));
  assertPass(test_expect(string).contain(@"bar"));
  assertPass(test_expect(string).contain(@"baz"));
  assertFail(test_expect(array).contain(@"qux"), @"expected (foo, bar, baz) to contain qux");
  assertFail(test_expect(string).contain(@"qux"), @"expected foo|bar,baz to contain qux");
  assertFail(test_expect(string).contain(nil), @"the expected value is nil/null");
  assertFail(test_expect([NSDictionary dictionary]).contain(@"foo"), @"{} is not an instance of NSString or NSArray");
  assertPass(test_expect(array2).contain([NSString class]));
}

- (void)test_toNot_contain {
  assertPass(test_expect(array).toNot.contain(@"qux"));
  assertPass(test_expect(array).toNot.contain(@"quux"));
  assertPass(test_expect(string).toNot.contain(@"qux"));
  assertPass(test_expect(string).toNot.contain(@"quux"));
  assertFail(test_expect(array).toNot.contain(@"foo"), @"expected (foo, bar, baz) not to contain foo");
  assertFail(test_expect(string).toNot.contain(@"baz"), @"expected foo|bar,baz not to contain baz");
  assertFail(test_expect(string).toNot.contain(nil), @"the expected value is nil/null");
  assertFail(test_expect([NSDictionary dictionary]).toNot.contain(@"foo"), @"{} is not an instance of NSString or NSArray");
  assertPass(test_expect(array2).toNot.contain([NSSet class]));
}

@end
