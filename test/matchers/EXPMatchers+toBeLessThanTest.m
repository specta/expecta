// Expecta - EXPMatchers+toContainTest.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface EXPMatchers_toBeLessThanTest : SenTestCase
@end

@implementation EXPMatchers_toBeLessThanTest

- (void)test_toBeLessThan {
    assertPass(test_expect(2).toBeLessThan(3));
    assertPass(test_expect(2.3).toBeLessThan(2.8));
    assertPass(test_expect([NSNumber numberWithInt:2]).toBeLessThan([NSNumber numberWithInt:3]));
    
    assertFail(test_expect(3).toBeLessThan(3), @"foo.m:123 expected: 3 to be less than 3");
    assertFail(test_expect(3.5).toBeLessThan(3.5), @"foo.m:123 expected: 3.5 to be less than 3.5");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeLessThan([NSNumber numberWithInt:3]), @"foo.m:123 expected: 3 to be less than 3");
    
    assertFail(test_expect(3).toBeLessThan(2), @"foo.m:123 expected: 3 to be less than 2");
    assertFail(test_expect(3.8).toBeLessThan(3.2), @"foo.m:123 expected: 3.8 to be less than 3.2");
    assertFail(test_expect([NSNumber numberWithInt:3]).toBeLessThan([NSNumber numberWithInt:2]), @"foo.m:123 expected: 3 to be less than 2");
}

- (void)test_Not_toBeLessThan {
    assertPass(test_expect(3).Not.toBeLessThan(2));
    assertPass(test_expect(3.8).Not.toBeLessThan(3.2));
    assertPass(test_expect([NSNumber numberWithInt:3]).Not.toBeLessThan([NSNumber numberWithInt:2]));
    
    assertFail(test_expect(2).Not.toBeLessThan(3), @"foo.m:123 expected: 2 not to be less than 3");
    assertFail(test_expect(3.2).Not.toBeLessThan(3.8), @"foo.m:123 expected: 3.2 not to be less than 3.8");
    assertFail(test_expect([NSNumber numberWithInt:2]).Not.toBeLessThan([NSNumber numberWithInt:3]), @"foo.m:123 expected: 2 not to be less than 3");
}

@end
