#import "EXTestCase.h"

@implementation EXTestCase

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

@end
