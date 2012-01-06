#import "TestHelper.h"

@interface EXPMatchers_toBeInTheRangeOfTest : SenTestCase
@end

@implementation EXPMatchers_toBeInTheRangeOfTest

- (void)test_toBeInTheRangeOf {
    assertPass(test_expect(1).toBeInTheRangeOf(1,10));
    assertPass(test_expect(10).toBeInTheRangeOf(1,10));
    assertPass(test_expect(5).toBeInTheRangeOf(1,10));

    assertPass(test_expect(1.0).toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(10.0).toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(5.0).toBeInTheRangeOf(1.0,10.0));

    assertPass(test_expect(1).toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(10).toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(5).toBeInTheRangeOf(1.0,10.0));

    assertPass(test_expect(1.0).toBeInTheRangeOf(1,10));
    assertPass(test_expect(10.0).toBeInTheRangeOf(1,10));
    assertPass(test_expect(5.0).toBeInTheRangeOf(1,10));

    assertPass(test_expect([NSNumber numberWithInt:1]).toBeInTheRangeOf(1, 10));
    assertPass(test_expect([NSNumber numberWithInt:10]).toBeInTheRangeOf(1, 10));
    assertPass(test_expect([NSNumber numberWithInt:5]).toBeInTheRangeOf(1, 10));
    assertPass(test_expect([NSNumber numberWithInt:1]).toBeInTheRangeOf(1.0, 10.0));
    assertPass(test_expect([NSNumber numberWithInt:10]).toBeInTheRangeOf(1.0, 10.0));
    assertPass(test_expect([NSNumber numberWithInt:5]).toBeInTheRangeOf(1.0, 10.0));
}

- (void)test_Not_toBeInTheRangeOf {
    assertPass(test_expect(0).Not.toBeInTheRangeOf(1,10));
    assertPass(test_expect(11).Not.toBeInTheRangeOf(1,10));

    assertPass(test_expect(0.0).Not.toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(11.0).Not.toBeInTheRangeOf(1.0,10.0));

    assertPass(test_expect(0).Not.toBeInTheRangeOf(1.0,10.0));
    assertPass(test_expect(11).Not.toBeInTheRangeOf(1.0,10.0));

    assertPass(test_expect(0.0).Not.toBeInTheRangeOf(1,10));
    assertPass(test_expect(11.0).Not.toBeInTheRangeOf(1,10));

    assertPass(test_expect([NSNumber numberWithInt:0]).Not.toBeInTheRangeOf(1, 10));
    assertPass(test_expect([NSNumber numberWithInt:11]).Not.toBeInTheRangeOf(1, 10));

    assertPass(test_expect([NSNumber numberWithInt:0]).Not.toBeInTheRangeOf(1.0, 10.0));
    assertPass(test_expect([NSNumber numberWithInt:11]).Not.toBeInTheRangeOf(1.0, 10.0));
}

@end
