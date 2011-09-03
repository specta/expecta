#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface EXPMatchers_toBeLessThanOrEqualToTest : SenTestCase
@end

@implementation EXPMatchers_toBeLessThanOrEqualToTest

- (void)test_toBeLessThanOrEqualTo {
    assertPass(test_expect(2).toBeLessThanOrEqualTo(3));
    assertPass(test_expect(2).toBeLessThanOrEqualTo(2));
    assertPass(test_expect(2).toBeLessThanOrEqualTo(2.1));
    assertPass(test_expect(3.14).toBeLessThanOrEqualTo(3.14));

    assertPass(test_expect([NSNumber numberWithInt:2]).toBeLessThanOrEqualTo([NSNumber numberWithInt:3]));
    assertPass(test_expect([NSNumber numberWithInt:2]).toBeLessThanOrEqualTo([NSNumber numberWithFloat:2.4f]));

    assertFail(test_expect(3).toBeLessThanOrEqualTo(2), @"foo.m:123 expected: 3 to be less than or equal to 2");
    assertFail(test_expect(3.8).toBeLessThanOrEqualTo(3.2), @"foo.m:123 expected: 3.8 to be less than or equal to 3.2");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeLessThanOrEqualTo([NSNumber numberWithInt:2]), @"foo.m:123 expected: 3 to be less than or equal to 2");
}

- (void)test_Not_toBeLessThanOrEqualTo {
    assertPass(test_expect(3).Not.toBeLessThanOrEqualTo(2));
    assertPass(test_expect(3.8).Not.toBeLessThanOrEqualTo(3.2));
    assertPass(test_expect([NSNumber numberWithInt:3]).Not.toBeLessThanOrEqualTo([NSNumber numberWithInt:2]));

    assertFail(test_expect(2).Not.toBeLessThanOrEqualTo(3), @"foo.m:123 expected: 2 not to be less than or equal to 3");
    assertFail(test_expect(3.2).Not.toBeLessThanOrEqualTo(3.8), @"foo.m:123 expected: 3.2 not to be less than or equal to 3.8");
    assertFail(test_expect([NSNumber numberWithInt:2]).Not.toBeLessThanOrEqualTo([NSNumber numberWithInt:3]), @"foo.m:123 expected: 2 not to be less than or equal to 3");
}

@end
