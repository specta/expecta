#import "TestHelper.h"

@interface EXPMatchers_containTest : SenTestCase {
  NSArray *array, *array2;
  NSSet* set;
  NSString *string;
  NSDictionary *dictionary;
  NSDictionary *same;
  NSDictionary *sameKey;
  NSDictionary *sameValue;
  NSDictionary *different;
  NSObject* object;
}
@end

@implementation EXPMatchers_containTest

- (void)setUp {
  array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
  array2 = [NSArray arrayWithObjects:[NSString class], [NSDictionary class], nil];
  set = [NSSet setWithObjects:@"foo", @"bar", nil];
  string = @"foo|bar,baz";
  object = [NSObject new];
  dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"foo", @"bar", nil];
  same = [NSDictionary dictionaryWithObjectsAndKeys:@"foo", @"bar", nil];
  sameKey = [NSDictionary dictionaryWithObjectsAndKeys:@"qux", @"bar", nil];
  sameValue = [NSDictionary dictionaryWithObjectsAndKeys:@"foo", @"qux", nil];
  different = [NSDictionary dictionaryWithObjectsAndKeys:@"qux", @"qux", nil];
}

- (void)test_contain {
  assertPass(test_expect(array).contain(@"foo"));
  assertPass(test_expect(array).contain(@"bar"));
  assertPass(test_expect(array).contain(@"baz"));
  assertPass(test_expect(set).contain(@"foo"));
  assertPass(test_expect(set).contain(@"bar"));
  assertPass(test_expect(string).contain(@"foo"));
  assertPass(test_expect(string).contain(@"bar"));
  assertPass(test_expect(string).contain(@"baz"));
  assertPass(test_expect(dictionary).contain(same));
  assertFail(test_expect(dictionary).contain(sameKey), @"expected {bar = foo;} to contain {bar = qux;}");
  assertFail(test_expect(dictionary).contain(sameValue), @"expected {bar = foo;} to contain {qux = foo;}");
  assertFail(test_expect(dictionary).contain(different), @"expected {bar = foo;} to contain {qux = qux;}");
  assertFail(test_expect(array).contain(@"qux"), @"expected (foo, bar, baz) to contain qux");
  assertFail(test_expect(string).contain(@"qux"), @"expected foo|bar,baz to contain qux");
  assertFail(test_expect(string).contain(nil), @"the expected value is nil/null");
  assertFail(test_expect(dictionary).contain(@"qux"), @"qux is not an instance of NSDictionary");
  assertFail(test_expect(@"qux").contain(dictionary), @"qux is not an instance of NSDictionary");
  NSString* errorMessage = [NSString stringWithFormat:@"%@ is not an instance of NSString or NSFastEnumeration", object];
  assertFail(test_expect(object).contain(@"foo"), errorMessage);
  assertPass(test_expect(array2).contain([NSString class]));
}

- (void)test_toNot_contain {
  assertPass(test_expect(array).toNot.contain(@"qux"));
  assertPass(test_expect(array).toNot.contain(@"quux"));
  assertPass(test_expect(string).toNot.contain(@"qux"));
  assertPass(test_expect(string).toNot.contain(@"quux"));
  assertPass(test_expect(set).toNot.contain(@"qux"));
  assertPass(test_expect(set).toNot.contain(@"quux"));
  assertPass(test_expect(dictionary).toNot.contain(sameKey));
  assertPass(test_expect(dictionary).toNot.contain(sameValue));
  assertPass(test_expect(dictionary).toNot.contain(different));
  assertFail(test_expect(array).toNot.contain(@"foo"), @"expected (foo, bar, baz) not to contain foo");
  assertFail(test_expect(dictionary).toNot.contain(same), @"expected {bar = foo;} not to contain {bar = foo;}");
  assertFail(test_expect(string).toNot.contain(@"baz"), @"expected foo|bar,baz not to contain baz");
  assertFail(test_expect(string).toNot.contain(nil), @"the expected value is nil/null");
  assertFail(test_expect(dictionary).contain(@"qux"), @"qux is not an instance of NSDictionary");
  assertFail(test_expect(@"qux").contain(dictionary), @"qux is not an instance of NSDictionary");
  NSString* errorMessage = [NSString stringWithFormat:@"%@ is not an instance of NSString or NSFastEnumeration", object];
  assertFail(test_expect(object).toNot.contain(@"foo"), errorMessage);
  assertPass(test_expect(array2).toNot.contain([NSSet class]));
}

@end
