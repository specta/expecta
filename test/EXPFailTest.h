// Test case class without failWithException: method
@interface TestCaseClassWithoutFailMethod : NSObject
- (void)fail;


@end

// Test case class with failWithException: method
@interface TestCaseClassWithFailMethod : TestCaseClassWithoutFailMethod {
  NSException *_exception;
}

@property (nonatomic, strong) NSException *exception;
- (void)failWithException:(NSException *)exception;

@end

// Test case class with failWithException: method
@interface TestCaseClassWithRecordFailureMethod : TestCaseClassWithoutFailMethod {
  NSString *_description;
  NSString *_fileName;
  NSUInteger _lineNumber;
  BOOL _expected;
}

@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *fileName;
@property (assign) NSUInteger lineNumber;
@property (assign) BOOL expected;

- (void)recordFailureWithDescription:(NSString *)description inFile:(NSString *)filename atLine:(NSUInteger)lineNumber expected:(BOOL)expected;

@end