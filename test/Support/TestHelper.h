#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "Expecta.h"
#import "FakeTestCase.h"

#define assertPass(expr) \
STAssertNoThrowSpecific((expr), NSException, nil)

#define assertFail(expr, message) \
STAssertThrowsSpecificNamed((expr), NSException, (message), nil)

#define assertEquals(a, b) STAssertEquals((a), (b), nil)
#define assertEqualObjects(a, b) STAssertEqualObjects((a), (b), nil)
#define assertTrue(a) STAssertTrue((a), nil)
