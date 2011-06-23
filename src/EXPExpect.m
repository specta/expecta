// Expecta - EXPExpect.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPExpect.h"
#import "NSObject+Expecta.h"

@interface EXPExpect (PrivateMethods)

- (void)initializeMatcherFunctions;
- (void)failWithMessage:(NSString *)message;

@end

@implementation EXPExpect

@synthesize
  actual=_actual,
  testCase=_testCase,
  negative=_negative,
  lineNumber=_lineNumber,
  fileName=_fileName;

- (id)initWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  self = [super init];
  if(self) {
    self.actual = actual;
    self.testCase = testCase;
    self.lineNumber = lineNumber;
    self.fileName = fileName;
    [self initializeMatcherFunctions];
  }
  return self;
}

+ (EXPExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  return [[[EXPExpect alloc] initWithActual:actual testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

- (void)dealloc {
  [_matchBlock release];
  [_failureMessageForToBlock release];
  [_failureMessageForNotToBlock release];
  [match release];
  [failureMessageForTo release];
  [failureMessageForNotTo release];
  [super dealloc];
}

#pragma mark -

- (EXPExpect *)Not {
  self.negative = !self.negative;
  return self;
}

#pragma mark -

- (void)initializeMatcherFunctions {
  match = [^(EXPBoolBlock block) {
    [_matchBlock release];
    _matchBlock = [block copy];
  } copy];
  failureMessageForTo = [^(EXPStringBlock block) {
    [_failureMessageForToBlock release];
    _failureMessageForToBlock = [block copy];
  } copy];
  failureMessageForNotTo = [^(EXPStringBlock block) {
    [_failureMessageForNotToBlock release];
    _failureMessageForNotToBlock = [block copy];
  } copy];
}

- (void)failWithMessage:(NSString *)message {
  NSString *reason = [NSString stringWithFormat:@"%s:%d %@", self.fileName, self.lineNumber, message];
  [self.testCase failWithException:[NSException exceptionWithName:@"Match Failed" reason:reason userInfo:nil]];
}

- (void)applyMatcher {
  if(_matchBlock) {
    BOOL matchResult = _matchBlock();
    BOOL failed = self.negative ? matchResult : !matchResult;
    if(failed) {
      NSString *message = @"Match Failed.";
      if(self.negative) {
        if(_failureMessageForNotToBlock) {
          message = _failureMessageForNotToBlock();
        }
      } else {
        if(_failureMessageForToBlock) {
          message = _failureMessageForToBlock();
        }
      }
      [self failWithMessage:message];
    }
  }
  self.negative = NO;
}

@end
