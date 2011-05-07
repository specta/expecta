#import <Foundation/Foundation.h>

@interface EXExpect : NSObject {
  id _actual;
  id _testCase;
  int _lineNumber;
  char *_fileName;
  BOOL _negative;
}

@property(nonatomic, assign) id actual;
@property(nonatomic, assign) id testCase;
@property(nonatomic) int lineNumber;
@property(nonatomic) char *fileName;
@property(nonatomic) BOOL negative;

@property(nonatomic, readonly) id to;
@property(nonatomic, readonly) id notTo;

- (id)initWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;
+ (EXExpect *)expectWithActual:(id)actual testCase:(id)testCase lineNumber:(int)lineNumber fileName:(char *)fileName;

- (id)to;
- (id)notTo;

- (NSException *)failureExceptionWithDescription:(NSString *)description;
- (void)match:(BOOL(^)())predicate description:(NSString *)description;

@end
