#import "TestHelper.h"
#import "NSValue+Expecta.h"

@interface ExpectationTest : SenTestCase {
  EXPExpect *x;
  NSNumber *n;
  NSValue *v;
}
@end

@implementation ExpectationTest

- (void)test_expect {
  x = expect(@"foo");
  assertEquals(x.lineNumber, (__LINE__ - 1));
  assertTrue(strcmp(x.fileName, __FILE__) == 0);
  assertEquals(x.testCase, self);
}

- (void)test_expect_nil {
  assertNil(expect(nil).actual);
}

- (void)test_expect_object {
  assertEqualObjects(expect(@"foo").actual, @"foo");
}

- (void)test_expect_SEL {
  v = [NSValue valueWithPointer:@selector(foo)];
  x = expect(@selector(foo));
  assertEqualObjects(x.actual, v);
  assertTrue(strcmp([(NSValue *)x.actual _EXP_objCType], @encode(SEL)) == 0);
}

- (void)test_expect_Class {
  v = [NSValue valueWithPointer:[EXPExpect class]];
  assertEqualObjects(expect([EXPExpect class]).actual, v);
}

- (void)test_expect_CString {
  char *foo = "foo";
  v = [NSValue valueWithPointer:foo];
  assertEqualObjects(expect(foo).actual, v);
}

- (void)test_expect_char {
  char a = 127;
  n = [NSNumber numberWithChar:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_double {
  double a = 3.141592653589793;
  n = [NSNumber numberWithDouble:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_float {
  float a = 3.141592f;
  n = [NSNumber numberWithFloat:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_int {
  int a = 2147483647;
  n = [NSNumber numberWithInt:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_long {
#ifdef __LP64__
  long a = 9223372036854775807;
#else
  long a = 2147483647;
#endif
  n = [NSNumber numberWithLong:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_long_long {
  long long a = 9223372036854775807;
  n = [NSNumber numberWithLongLong:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_short {
  short a = 32767;
  n = [NSNumber numberWithShort:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_NSInteger {
#ifdef __LP64__
  NSInteger a = 9223372036854775807;
#else
  NSInteger a = 2147483647;
#endif
  n = [NSNumber numberWithInteger:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_unsigned_char {
  unsigned char a = 255;
  n = [NSNumber numberWithUnsignedChar:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_unsigned_int {
  unsigned int a = 4294967295;
  n = [NSNumber numberWithUnsignedInt:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_unsigned_long {
#ifdef __LP64__
  unsigned long a = 18446744073709551615u;
#else
  unsigned long a = 4294967295;
#endif
  n = [NSNumber numberWithUnsignedLong:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_unsigned_long_long {
  unsigned long long a = 18446744073709551615u;
  n = [NSNumber numberWithUnsignedLongLong:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_unsigned_short {
  unsigned short a = 65535;
  n = [NSNumber numberWithUnsignedShort:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_NSUInteger {
#ifdef __LP64__
  NSUInteger a = 18446744073709551615u;
#else
  NSUInteger a = 4294967295;
#endif
  n = [NSNumber numberWithUnsignedInteger:a];
  assertEqualObjects(expect(a).actual, n);
}

- (void)test_expect_union {
  FakeTestCase *f = [FakeTestCase new];
  union u {
    int a;
    float b;
  } u;
  assertFail(test_expect(u).toBeNil(), @"expecting a union is not supported");
  [f release];
}

- (void)test_expect_struct {
  FakeTestCase *f = [FakeTestCase new];
  struct s {
    int a;
    float b;
  } s;
  assertFail(test_expect(s).toBeNil(), @"expecting a struct is not supported");
  [f release];
}

- (void)test_expect_block {
  FakeTestCase *f = [FakeTestCase new];
  assertFail(test_expect(^BOOL { return NO; }).toBeNil(), @"expecting a block is not supported");
  [f release];
}

@end
