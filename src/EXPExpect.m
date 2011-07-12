// Expecta - EXPExpect.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPExpect.h"
#import "NSObject+Expecta.h"
#import "Expecta.h"
#import "EXPUnsupportedObject.h"

@interface EXPExpect (PrivateMethods)

- (void)initializeMatcherFunctions;

@end

@implementation EXPExpect

@dynamic
  actual,
  Not,
  isGoing,
  isNotGoing;

@synthesize
  actualBlock=_actualBlock,
  testCase=_testCase,
  negative=_negative,
  asynchronous=_asynchronous,
  lineNumber=_lineNumber,
  fileName=_fileName;

- (id)initWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  self = [super init];
  if(self) {
    self.actualBlock = actualBlock;
    self.testCase = testCase;
    self.negative = NO;
    self.asynchronous = NO;
    self.lineNumber = lineNumber;
    self.fileName = fileName;
    _prerequisiteBlock = nil;
    _matchBlock = nil;
    _failureMessageForToBlock = nil;
    _failureMessageForNotToBlock = nil;
    [self initializeMatcherFunctions];
  }
  return self;
}

+ (EXPExpect *)expectWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  return [[[EXPExpect alloc] initWithActualBlock:actualBlock testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

- (void)dealloc {
  [_actualBlock release];
  [_prerequisiteBlock release];
  [_matchBlock release];
  [_failureMessageForToBlock release];
  [_failureMessageForNotToBlock release];
  [prerequisite release];
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

- (EXPExpect *)isGoing {
  self.asynchronous = YES;
  return self;
}

- (EXPExpect *)isNotGoing {
  return self.isGoing.Not;
}

#pragma mark -

- (id)actual {
  if(self.actualBlock) {
    return self.actualBlock();
  }
  return nil;
}

- (void)initializeMatcherFunctions {
  prerequisite = [^(EXPBoolBlock block) {
    [_prerequisiteBlock release];
    _prerequisiteBlock = [block copy];
  } copy];
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

- (void)applyMatcher:(NSObject **)actual {
  if([*actual isKindOfClass:[EXPUnsupportedObject class]]) {
    EXPFail(self.testCase, self.lineNumber, self.fileName,
            [NSString stringWithFormat:@"expecting a %@ is not supported", ((EXPUnsupportedObject *)*actual).type]);
  } else if(_matchBlock) {
    BOOL failed;
    if(_prerequisiteBlock && !_prerequisiteBlock()) {
      failed = YES;
    } else {
      BOOL matchResult;
      if(self.asynchronous) {
        NSTimeInterval timeOut = [Expecta asynchronousTestTimeout];
        NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:timeOut];
        while(1) {
          matchResult = _matchBlock();
          if(matchResult || ([(NSDate *)[NSDate date] compare:expiryDate] == NSOrderedDescending)) {
            break;
          }
          [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
          *actual = self.actual;
        }
      } else {
        matchResult = _matchBlock();
      }
      failed = self.negative ? matchResult : !matchResult;
    }
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
      EXPFail(self.testCase, self.lineNumber, self.fileName, message);
    }
  }
  self.negative = NO;
}

@end
