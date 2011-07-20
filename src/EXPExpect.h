// Expecta - EXPExpect.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

typedef BOOL (^EXPBoolBlock)();
typedef NSString *(^EXPStringBlock)();

@interface EXPExpect : NSObject {
  id _actual;
  id _testCase;
  int _lineNumber;
  char *_fileName;
  BOOL _negative;

  EXPBoolBlock _prerequisiteBlock;
  EXPBoolBlock _matchBlock;
  EXPStringBlock _failureMessageForToBlock;
  EXPStringBlock _failureMessageForNotToBlock;
}

@property(nonatomic, assign) id actual;
@property(nonatomic, assign) id testCase;
@property(nonatomic) int lineNumber;
@property(nonatomic) char *fileName;
@property(nonatomic) BOOL negative;

@property(nonatomic, readonly) EXPExpect *Not;

- (id)initWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;
+ (EXPExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;

- (void)applyMatcher;

- (void)setPrerequisite:(EXPBoolBlock)block;
- (void)setMatch:(EXPBoolBlock)block;
- (void)setFailureMessageForTo:(EXPStringBlock)block;
- (void)setFailureMessageForNotTo:(EXPStringBlock)block;

@end
