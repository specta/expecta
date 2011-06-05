#import "TestHelper.h"

@interface ExpectationTest : SenTestCase {
  NSNumber *n;
  NSValue *v;
}
@end

@implementation ExpectationTest

- (void)testExpect {
  EXExpect *x = expect(@"foo");
  assertEquals(x.lineNumber, (__LINE__ - 1));
  assertTrue(strcmp(x.fileName, __FILE__) == 0);
  assertEquals(x.testCase, self);
}

- (void)testExpectNil {
  assertNil(expect(nil).actual);
}

- (void)testExpectObject {
  assertEquals(expectObject(@"foo").actual, @"foo");
  assertEquals(expect(@"foo").actual, @"foo");
}

- (void)testExpectSelector {
  v = [NSValue valueWithPointer:@selector(foo)];
  assertEqualObjects(expectSelector(@selector(foo)).actual, v);
  assertEqualObjects(expect(@selector(foo)).actual, v);
}

- (void)testExpectClass {
  v = [NSValue valueWithPointer:[EXExpect class]];
  assertEqualObjects(expectClass([EXExpect class]).actual, v);
  assertEqualObjects(expect([EXExpect class]).actual, v);
}

- (void)testExpectPointer {
  char *foo = "foo";
  v = [NSValue valueWithPointer:foo];
  assertEqualObjects(expectPointer(foo).actual, v);
  assertEqualObjects(expect(foo).actual, v);

  int bar[] = {1,2,3};
  v = [NSValue valueWithPointer:bar];
  assertEqualObjects(expectPointer(bar).actual, v);
  assertEqualObjects(expect(bar).actual, v);
}

- (void)testExpectChar {
  char a = 127;
  n = [NSNumber numberWithChar:a];
  assertEqualObjects(expectChar(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectDouble {
  double a = 3.141592653589793;
  n = [NSNumber numberWithDouble:a];
  assertEqualObjects(expectDouble(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectFloat {
  float a = 3.141592f;
  n = [NSNumber numberWithFloat:a];
  assertEqualObjects(expectFloat(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectInt {
  int a = 2147483647;
  n = [NSNumber numberWithInt:a];
  assertEqualObjects(expectInt(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectLong {
#ifdef __LP64__
  long a = 9223372036854775807;
#else
  long a = 2147483647;
#endif
  n = [NSNumber numberWithLong:a];
  assertEqualObjects(expectLong(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectLongLong {
  long long a = 9223372036854775807;
  n = [NSNumber numberWithLongLong:a];
  assertEqualObjects(expectLongLong(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectShort {
  short a = 32767;
  n = [NSNumber numberWithShort:a];
  assertEqualObjects(expectShort(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectInteger {
#ifdef __LP64__
  NSInteger a = 9223372036854775807;
#else
  NSInteger a = 2147483647;
#endif
  n = [NSNumber numberWithInteger:a];
  assertEqualObjects(expectInteger(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedChar {
  unsigned char a = 255;
  n = [NSNumber numberWithUnsignedChar:a];
  assertEqualObjects(expectUnsignedChar(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedInt {
  unsigned int a = 4294967295;
  n = [NSNumber numberWithUnsignedInt:a];
  assertEqualObjects(expectUnsignedInt(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedLong {
#ifdef __LP64__
  unsigned long a = 18446744073709551615u;
#else
  unsigned long a = 4294967295;
#endif
  n = [NSNumber numberWithUnsignedLong:a];
  assertEqualObjects(expectUnsignedLong(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedLongLong {
  unsigned long long a = 18446744073709551615u;
  n = [NSNumber numberWithUnsignedLongLong:a];
  assertEqualObjects(expectUnsignedLongLong(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedShort {
  unsigned short a = 65535;
  n = [NSNumber numberWithUnsignedShort:a];
  assertEqualObjects(expectUnsignedShort(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsignedInteger {
#ifdef __LP64__
  NSInteger a = 18446744073709551615u;
#else
  NSInteger a = 4294967295;
#endif
  n = [NSNumber numberWithInteger:a];
  assertEqualObjects(expectInteger(a).actual, n);
  assertEqualObjects(expect(a).actual, n);
}

- (void)testExpectUnsupportedType {
  FakeTestCase *f = [[FakeTestCase new] autorelease];
  union u {
    int a;
    float b;
  } u;
  assertFail(EXExpectVariadic(f, 123, "foo.m", @encode(union u), u), @"foo.m:123 expecting a union instance is not supported");
  struct s {
    int a;
    float b;
  } s;
  assertFail(EXExpectVariadic(f, 123, "foo.m", @encode(struct s), s), @"foo.m:123 expecting a struct instance is not supported");
}

@end
