#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "Expecta.h"
#import "FakeTestCase.h"
#import "EXExpect+Test.h"

#define assertPass(expr) \
STAssertNoThrow((expr), nil)

#define assertFail(expr, message) \
STAssertThrowsSpecificNamed((expr), NSException, (message), nil)

#define assertEquals(a, b) STAssertEquals((a), (b), nil)
#define assertEqualObjects(a, b) STAssertEqualObjects((a), (b), nil)
#define assertTrue(a) STAssertTrue((a), nil)
#define assertNil(a) STAssertNil((a), nil)

#define test_expect(a) expect(a).test
