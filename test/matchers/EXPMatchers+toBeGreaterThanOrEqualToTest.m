#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface EXPMatchers_toBeGreaterThanOrEqualToTest : SenTestCase
@end

@implementation EXPMatchers_toBeGreaterThanOrEqualToTest

- (void)test_toBeGreaterThanOrEqualTo {
    assertPass(test_expect(3).toBeGreaterThanOrEqualTo(2));
    assertPass(test_expect(2).toBeGreaterThanOrEqualTo(2));
    assertPass(test_expect(2.1).toBeGreaterThanOrEqualTo(2));
    assertPass(test_expect(3.14).toBeGreaterThanOrEqualTo(3.14));

    assertPass(test_expect([NSNumber numberWithInt:3]).toBeGreaterThanOrEqualTo([NSNumber numberWithInt:2]));
    assertPass(test_expect([NSNumber numberWithFloat:2.7f]).toBeGreaterThanOrEqualTo([NSNumber numberWithInt:2]));

    assertFail(test_expect(2).toBeGreaterThanOrEqualTo(3), @"expected: 2 to be greater than or equal to 3");
    assertFail(test_expect(3.2).toBeGreaterThanOrEqualTo(3.5), @"expected: 3.2 to be greater than or equal to 3.5");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeGreaterThanOrEqualTo([NSNumber numberWithInt:4]), @"expected: 3 to be greater than or equal to 4");
}

- (void)test_Not_toBeGreaterThanOrEqualTo {
    assertPass(test_expect(3).Not.toBeGreaterThanOrEqualTo(5));
    assertPass(test_expect(3.8).Not.toBeGreaterThanOrEqualTo(3.9));
    assertPass(test_expect([NSNumber numberWithInt:3]).Not.toBeGreaterThanOrEqualTo([NSNumber numberWithInt:4]));

    assertFail(test_expect(3).Not.toBeGreaterThanOrEqualTo(2), @"expected: 3 not to be greater than or equal to 2");
    assertFail(test_expect(3.2).Not.toBeGreaterThanOrEqualTo(3.14), @"expected: 3.2 not to be greater than or equal to 3.14");
    assertFail(test_expect([NSNumber numberWithInt:3]).Not.toBeGreaterThanOrEqualTo([NSNumber numberWithInt:3]), @"expected: 3 not to be greater than or equal to 3");
}

@end
