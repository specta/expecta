#import "EXExpect+Test.h"
#import "FakeTestCase.h"

@implementation EXExpect (Test)

- (EXExpect *)test {
  self.testCase = [[FakeTestCase new] autorelease];
  self.lineNumber = 123;
  self.fileName = "foo.m";
  return self;
}

@end
