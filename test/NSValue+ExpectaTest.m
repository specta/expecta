#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface NSValue_ExpectaTest : SenTestCase
@end

@implementation NSValue_ExpectaTest

- (void)test_EX_objcType {
  int *a;
  char *b;
  NSValue *foo = [NSValue valueWithPointer:&a];
  NSValue *bar = [NSValue valueWithPointer:&b];
  [foo set_EX_objCType:@encode(int)];
  [bar set_EX_objCType:@encode(char)];
  assertTrue(strcmp([foo _EX_objCType], @encode(int)) == 0);
  assertTrue(strcmp([bar _EX_objCType], @encode(char)) == 0);
}

@end
