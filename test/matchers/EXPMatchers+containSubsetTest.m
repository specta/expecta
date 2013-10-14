#import "TestHelper.h"

@interface EXPMatchers_containSubsetTest : TEST_SUPERCLASS {
  NSArray *array;
  NSSet *set;
  NSOrderedSet *orderedSet;
  NSDictionary *dictionary;
  NSObject* object;
}
@end

@implementation EXPMatchers_containSubsetTest

- (void)setUp {
  array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
  set = [NSSet setWithObjects:@"foo", @"bar", nil];
  orderedSet = [NSOrderedSet orderedSetWithArray:array];
  dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"foo", @2, @"bar", nil];
  object = [[NSObject alloc] init];
}

- (void)test_containSubset {
  assertPass(test_expect(array).containSubset([NSArray arrayWithObject:@"foo"]));
  assertPass(test_expect(set).containSubset([NSSet setWithObject:@"bar"]));
  assertPass(test_expect(orderedSet).containSubset([NSOrderedSet orderedSetWithObject:@"baz"]));
  assertPass(test_expect(dictionary).containSubset([NSDictionary dictionaryWithObject:@2 forKey:@"bar"]));

  assertPass(test_expect(array).containSubset(array));
  assertPass(test_expect(set).containSubset(set));
  assertPass(test_expect(orderedSet).containSubset(orderedSet));
  assertPass(test_expect(dictionary).containSubset(dictionary));

  assertPass(test_expect(array).containSubset([NSArray array]));
  assertPass(test_expect(set).containSubset([NSSet set]));
  assertPass(test_expect(orderedSet).containSubset([NSOrderedSet orderedSet]));
  assertPass(test_expect(dictionary).containSubset([NSDictionary dictionary]));

  assertFail(test_expect(array).containSubset([NSArray arrayWithObject:@"xyz"]), @"expected (foo, bar, baz) to be a superset of (xyz)");
  assertFail(test_expect(set).containSubset([NSSet setWithObject:@"xyz"]), @"expected {(foo, bar)} to be a superset of {(xyz)}");
  assertFail(test_expect(orderedSet).containSubset([NSOrderedSet orderedSetWithObject:@"xyz"]), @"expected {(foo, bar, baz)} to be a superset of {(xyz)}");
  assertFail(test_expect(dictionary).containSubset([NSDictionary dictionaryWithObject:@2 forKey:@"xyz"]), @"expected {foo = 1; bar = 2;} to be a superset of {xyz = 2;}");

  assertFail(test_expect(nil).containSubset([NSArray array]), @"nil/null is not an instance of NSDictionary or implements -containsObject:");
  assertFail(test_expect(array).containSubset(nil), @"the expected value is nil/null");
  assertFail(test_expect(array).containSubset(set), @"{(foo, bar)} does not match the class of (foo, bar, baz)");
}

- (void)test_toNot_containSubset {
  assertFail(test_expect(array).notTo.containSubset([NSArray arrayWithObject:@"foo"]), @"expected (foo, bar, baz) not to be a superset of (foo)");
  assertFail(test_expect(set).notTo.containSubset([NSSet setWithObject:@"bar"]), @"expected {(foo, bar)} not to be a superset of {(bar)}");
  assertFail(test_expect(orderedSet).notTo.containSubset([NSOrderedSet orderedSetWithObject:@"baz"]), @"expected {(foo, bar, baz)} not to be a superset of {(baz)}");
  assertFail(test_expect(dictionary).notTo.containSubset([NSDictionary dictionaryWithObject:@2 forKey:@"bar"]), @"expected {foo = 1; bar = 2;} not to be a superset of {bar = 2;}");

  assertFail(test_expect(array).notTo.containSubset(array), @"expected (foo, bar, baz) not to be a superset of (foo, bar, baz)");
  assertFail(test_expect(set).notTo.containSubset(set), @"expected {(foo, bar)} not to be a superset of {(foo, bar)}");
  assertFail(test_expect(orderedSet).notTo.containSubset(orderedSet), @"expected {(foo, bar, baz)} not to be a superset of {(foo, bar, baz)}");
  assertFail(test_expect(dictionary).notTo.containSubset(dictionary), @"expected {foo = 1; bar = 2;} not to be a superset of {foo = 1; bar = 2;}");

  assertFail(test_expect(array).notTo.containSubset([NSArray array]), @"expected (foo, bar, baz) not to be a superset of ()");
  assertFail(test_expect(set).notTo.containSubset([NSSet set]), @"expected {(foo, bar)} not to be a superset of {()}");
  assertFail(test_expect(orderedSet).notTo.containSubset([NSOrderedSet orderedSet]), @"expected {(foo, bar, baz)} not to be a superset of {()}");
  assertFail(test_expect(dictionary).notTo.containSubset([NSDictionary dictionary]), @"expected {foo = 1; bar = 2;} not to be a superset of {}");

  assertPass(test_expect(array).notTo.containSubset([NSArray arrayWithObject:@"xyz"]));
  assertPass(test_expect(set).notTo.containSubset([NSSet setWithObject:@"xyz"]));
  assertPass(test_expect(orderedSet).notTo.containSubset([NSOrderedSet orderedSetWithObject:@"xyz"]));
  assertPass(test_expect(dictionary).notTo.containSubset([NSDictionary dictionaryWithObject:@2 forKey:@"xyz"]));

  assertFail(test_expect(nil).notTo.containSubset([NSArray array]), @"nil/null is not an instance of NSDictionary or implements -containsObject:");
  assertFail(test_expect(array).notTo.containSubset(nil), @"the expected value is nil/null");
  assertFail(test_expect(array).notTo.containSubset(set), @"{(foo, bar)} does not match the class of (foo, bar, baz)");
}

@end
