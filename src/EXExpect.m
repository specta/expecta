#import "EXExpect.h"
#import "Expecta.h"
#import "NSObject+TestCaseHack.h"

@implementation EXExpect

@synthesize actual=_actual, testCase=_testCase, negative=_negative, lineNumber=_lineNumber, fileName=_fileName;
@dynamic to, notTo;

- (id)initWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  self = [super init];
  if(self) {
    self.actual = actual;
    self.testCase = testCase;
    self.lineNumber = lineNumber;
    self.fileName = fileName;
  }
  return self;
}

+ (EXExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  return [[[EXExpect alloc] initWithActual:actual testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

- (void)dealloc {
  [super dealloc];
}

- (id)to {
  return self;
}

- (id)notTo {
  self.negative = YES;
  return self;
}

- (NSException *)failureExceptionWithDescription:(NSString *)description {
  NSString *reason = [NSString stringWithFormat:@"%s:%d expected: %@%@, got: %@",
                                                self.fileName,
                                                self.lineNumber,
                                                (self.negative ? @"not " : @""),
                                                description,
                                                EXDescribeObject(self.actual)];
  return [NSException exceptionWithName:ExpectaException reason:reason userInfo:nil];
}

- (void)match:(BOOL(^)())predicate description:(NSString *)description {
  BOOL result = predicate();
  result = self.negative ? !result : result;
  if(!result) {
    [self.testCase failWithException:[self failureExceptionWithDescription:description]];
  }
}

@end
