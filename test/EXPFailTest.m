#import "TestHelper.h"

// Test case class without failWithException: method
@interface TestCaseClassWithoutFailMethod : NSObject
- (void)fail;
@end

@implementation TestCaseClassWithoutFailMethod
- (void)fail {
  EXPFail(self, 777, "test.m", @"epic fail");
}
@end

// Test case class with failWithException: method
@interface TestCaseClassWithFailMethod : TestCaseClassWithoutFailMethod {
  NSException *_exception;
}
@property(nonatomic, retain) NSException *exception;
- (void)failWithException:(NSException *)exception;
@end

@implementation TestCaseClassWithFailMethod
@synthesize exception=_exception;

- (void)dealloc {
  self.exception = nil;
  [super dealloc];
}

- (void)failWithException:(NSException *)exception {
  self.exception = exception;
}

@end

// Test case class with failWithException: method
@interface TestCaseClassWithRecordFailureMethod : TestCaseClassWithoutFailMethod
@property(strong)NSString *description;
@property(strong)NSString *fileName;
@property(assign)NSUInteger lineNumber;
@property(assign)BOOL expected;

- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected;
@end

@implementation TestCaseClassWithRecordFailureMethod

- (void)recordFailureWithDescription:(NSString *)description
                              inFile:(NSString *)filename
                              atLine:(NSUInteger)lineNumber
                            expected:(BOOL)expected {
    self.description = description;
    self.fileName = filename;
    self.lineNumber = lineNumber;
    self.expected = expected;
}

@end
    
@interface EXPFailTest : TEST_SUPERCLASS
@end

@implementation EXPFailTest

- (void)test_EXPFailWithTestCaseClassThatDoesNotHaveFailureMethod {
  // it throws the exception directly
  TestCaseClassWithoutFailMethod *testCase = [TestCaseClassWithoutFailMethod new];
  @try {
    [testCase fail];
  } @catch(NSException *exception) {
    assertEqualObjects([exception name], @"Expecta Error");
    assertEqualObjects([exception reason], @"test.m:777 epic fail");
  }
  [testCase release];
}

#ifdef USE_XCTEST
- (void)test_EXPFailWithTestCaseClassThatHasFailureMethod {
    // it calls recordFailureWithDescription:inFile:atLine:expected: method
    TestCaseClassWithRecordFailureMethod *testCase = [TestCaseClassWithRecordFailureMethod new];
    assertNil(testCase.description);
    assertNil(testCase.fileName);
    [testCase fail];
    assertEqualObjects(testCase.description, @"epic fail");
    assertEqualObjects(testCase.fileName, @"test.m");
    assertEqualObjects(@(testCase.lineNumber), @777);
    assertEquals(testCase.expected, NO);
    [testCase release];
}
#else
- (void)test_EXPFailWithTestCaseClassThatHasFailureMethod {
  // it calls failWithException: method
  TestCaseClassWithFailMethod *testCase = [TestCaseClassWithFailMethod new];
  assertNil(testCase.exception);
  [testCase fail];
  NSException *exception = testCase.exception;
  assertEqualObjects([exception name], SenTestFailureException);
  assertEqualObjects([exception reason], @"epic fail");
  NSDictionary *exceptionUserInfo = [exception userInfo];
  assertEqualObjects([exceptionUserInfo objectForKey:SenTestDescriptionKey], @"epic fail");
  assertEqualObjects([exceptionUserInfo objectForKey:SenTestFilenameKey], @"test.m");
  assertEqualObjects([exceptionUserInfo objectForKey:SenTestLineNumberKey], [NSNumber numberWithInt:777]);
  [testCase release];
}
#endif

@end
