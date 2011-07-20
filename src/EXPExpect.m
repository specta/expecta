// Expecta - EXPExpect.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPExpect.h"
#import "NSObject+Expecta.h"
#import "ExpectaSupport.h"

@interface EXPExpect (PrivateMethods)

- (void)initializeMatcherFunctions;

@end

@implementation EXPExpect

@dynamic
Not;

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
        _prerequisiteBlock = nil;
        _matchBlock = nil;
        _failureMessageForToBlock = nil;
        _failureMessageForNotToBlock = nil;
    }
    return self;
}

+ (EXPExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName {
    return [[[EXPExpect alloc] initWithActual:actual testCase:(id)testCase lineNumber:lineNumber fileName:fileName] autorelease];
}

- (void)dealloc {
    [_prerequisiteBlock release];
    [_matchBlock release];
    [_failureMessageForToBlock release];
    [_failureMessageForNotToBlock release];
    [super dealloc];
}

#pragma mark -

- (EXPExpect *)Not {
    self.negative = !self.negative;
    return self;
}

#pragma mark -
- (void)setPrerequisite:(EXPBoolBlock)block {
    [_prerequisiteBlock release];
    _prerequisiteBlock = [block copy];
}

- (void)setMatch:(EXPBoolBlock)block {
    [_matchBlock release];
    _matchBlock = [block copy];
}

- (void)setFailureMessageForTo:(EXPStringBlock)block {
    [_failureMessageForToBlock release];
    _failureMessageForToBlock = [block copy];
}

- (void)setFailureMessageForNotTo:(EXPStringBlock)block {
    [_failureMessageForNotToBlock release];
    _failureMessageForNotToBlock = [block copy];
}

- (void)applyMatcher {
    if(_matchBlock) {
        BOOL failed;
        if(_prerequisiteBlock && !_prerequisiteBlock()) {
            failed = YES;
        } else {
            BOOL matchResult = _matchBlock();
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
