#import <Foundation/Foundation.h>

typedef BOOL (^EXBoolBlock)();
typedef NSString *(^EXStringBlock)();

@interface EXExpect : NSObject {
  id _actual;
  id _testCase;
  int _lineNumber;
  char *_fileName;
  BOOL _negative;

  EXBoolBlock _matchBlock;
  EXStringBlock _failureMessageForToBlock;
  EXStringBlock _failureMessageForNotToBlock;

  void (^match)(EXBoolBlock block);
  void (^failureMessageForTo)(EXStringBlock block);
  void (^failureMessageForNotTo)(EXStringBlock block);
}

@property(nonatomic, assign) id actual;
@property(nonatomic, assign) id testCase;
@property(nonatomic) int lineNumber;
@property(nonatomic) char *fileName;
@property(nonatomic) BOOL negative;

@property(nonatomic, readonly) EXExpect *Not;

- (id)initWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;
+ (EXExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;

- (void)applyMatcher;

@end
