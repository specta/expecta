#import "EXPExpect.h"
#import "NSObject+Expecta.h"
#import "Expecta.h"
#import "EXPUnsupportedObject.h"
#import "EXPRuntimeMatcher.h"

@implementation EXPExpect

@dynamic
  actual,
  to,
  toNot,
  will,
  willNot;

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
  }
  return self;
}

+ (EXPExpect *)expectWithActualBlock:(id)actualBlock testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
  return [[[EXPExpect alloc] initWithActualBlock:actualBlock testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

#pragma mark -

- (EXPExpect *)to {
  return self;
}

- (EXPExpect *)toNot {
  self.negative = !self.negative;
  return self;
}

- (EXPExpect *)will {
  self.asynchronous = YES;
  return self;
}

- (EXPExpect *)willNot {
  return self.will.toNot;
}

#pragma mark -

- (id)actual {
  if(self.actualBlock) {
    return self.actualBlock();
  }
  return nil;
}

- (void)applyMatcher:(id<EXPMatcher>)matcher to:(NSObject **)actual {
  // temporarily cast to runtime matcher, just to get things working
  EXPRuntimeMatcher *_matcher = (EXPRuntimeMatcher *)matcher;
  
  if([*actual isKindOfClass:[EXPUnsupportedObject class]]) {
    EXPFail(self.testCase, self.lineNumber, self.fileName,
            [NSString stringWithFormat:@"expecting a %@ is not supported", ((EXPUnsupportedObject *)*actual).type]);
  } else if(_matcher.matchBlock) {   
    BOOL failed;
    if(_matcher.prerequisiteBlock && !_matcher.prerequisiteBlock()) {
      failed = YES;
    } else {
      BOOL matchResult;
      if(self.asynchronous) {
        NSTimeInterval timeOut = [Expecta asynchronousTestTimeout];
        NSDate *expiryDate = [NSDate dateWithTimeIntervalSinceNow:timeOut];
        while(1) {
          matchResult = _matcher.matchBlock();
          failed = self.negative ? matchResult : !matchResult;
          if(!failed || ([(NSDate *)[NSDate date] compare:expiryDate] == NSOrderedDescending)) {
            break;
          }
          [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
          *actual = self.actual;
        }
      } else {
        matchResult = _matcher.matchBlock();
      }
      failed = self.negative ? matchResult : !matchResult;
    }
    if(failed) {
      NSString *message = @"Match Failed.";
      if(self.negative) {
        if(_matcher.failureMessageForNotToBlock) {
          message = _matcher.failureMessageForNotToBlock();
        }
      } else {
        if(_matcher.failureMessageForToBlock) {
          message = _matcher.failureMessageForToBlock();
        }
      }
      EXPFail(self.testCase, self.lineNumber, self.fileName, message);
    }
  }
  self.negative = NO;
}

@end
