#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface EXPMatchers_toBeGreaterThanTest : SenTestCase
@end

@implementation EXPMatchers_toBeGreaterThanTest

- (void)test_toBeGreaterThan {
    assertPass(test_expect(3).toBeGreaterThan(2));
    assertPass(test_expect(3.1).toBeGreaterThan(3));
    assertPass(test_expect(2.9).toBeGreaterThan(2.8));
    assertPass(test_expect([NSNumber numberWithInt:4]).toBeGreaterThan([NSNumber numberWithInt:3]));
    
    assertFail(test_expect(3).toBeGreaterThan(3), @"foo.m:123 expected: 3 to be greater than 3");
    assertFail(test_expect(3.5).toBeGreaterThan(3.5), @"foo.m:123 expected: 3.5 to be greater than 3.5");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeGreaterThan([NSNumber numberWithInt:3]), @"foo.m:123 expected: 3 to be greater than 3");
    
    assertFail(test_expect(2).toBeGreaterThan(3), @"foo.m:123 expected: 2 to be greater than 3");
    assertFail(test_expect(3.1).toBeGreaterThan(3.2), @"foo.m:123 expected: 3.1 to be greater than 3.2");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeGreaterThan([NSNumber numberWithInt:4]), @"foo.m:123 expected: 3 to be greater than 4");
}

- (void)test_Not_toBeGreaterThan {
    assertPass(test_expect(2).Not.toBeGreaterThan(3));
    assertPass(test_expect(3.8).Not.toBeGreaterThan(3.9));
    assertPass(test_expect([NSNumber numberWithInt:3]).Not.toBeGreaterThan([NSNumber numberWithInt:4]));
    
    assertFail(test_expect(2).Not.toBeGreaterThan(1), @"foo.m:123 expected: 2 not to be greater than 1");
    assertFail(test_expect(3.9).Not.toBeGreaterThan(3.8), @"foo.m:123 expected: 3.9 not to be greater than 3.8");
    assertFail(test_expect([NSNumber numberWithInt:4]).Not.toBeGreaterThan([NSNumber numberWithInt:3]), @"foo.m:123 expected: 4 not to be greater than 3");
}

@end
