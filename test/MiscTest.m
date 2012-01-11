#import "TestHelper.h"
#import "ExpectaSupport.h"

@interface MiscTest : SenTestCase
@end

@implementation MiscTest

- (void)test_StrippingOfLineBreaksInObjectDescription {
  NSArray *arr = [NSArray arrayWithObjects:@"foo", @"bar", nil];
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"bar", @"foo", nil];
  expect(EXPDescribeObject(@"\n")).Not.toContain(@"\n");
  expect(EXPDescribeObject(@"\n")).toEqual(@"\\n");
  expect(EXPDescribeObject(arr)).Not.toContain(@"\n");
  expect(EXPDescribeObject(arr)).toEqual(@"(foo, bar)");
  expect(EXPDescribeObject(dict)).Not.toContain(@"\n");
  expect(EXPDescribeObject(dict)).toEqual(@"{foo = bar;}");
}

@end
