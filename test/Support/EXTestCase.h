#import "TestHelper.h"

@class FakeTestCase;

@interface EXTestCase : SenTestCase {
  EXExpect *obj;
  FakeTestCase *fakeTestCase;
}

@end
