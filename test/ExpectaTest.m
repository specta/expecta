#import "ExpectaTest.h"
#import "FakeTestCase.h"
#import "Expecta.h"

#define assertPass(expr) \
STAssertNoThrowSpecific((expr), NSException, @"")

#define assertFail(expr, message) \
STAssertThrowsSpecificNamed((expr), NSException, (message), @"")

@implementation ExpectaTest

- (void)setUp {
  [super setUp];
  fakeTestCase = [FakeTestCase new];
  obj = [[EXExpect alloc] initWithActual:nil testCase:fakeTestCase lineNumber:123 fileName:"foo.m"];
}

- (void)tearDown {
  [obj release];
  [fakeTestCase release];
  [super tearDown];
}

- (void)test_to_beNil {
  obj.actual = nil;
  assertPass([obj.to beNil]);
  obj.actual = @"foo";
  assertFail([obj.to beNil], @"foo.m:123 expected: nil, got: foo");
}

- (void)test_notTo_beNil {
  obj.actual = @"foo";
  assertPass([obj.notTo beNil]);
  obj.actual = nil;
  assertFail([obj.notTo beNil], @"foo.m:123 expected: not nil, got: nil");
}

@end
