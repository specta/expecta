#import "Expecta.h"
#import "NSObject+EXTestCase.h"

EXExpect *EXExpectVariadic(id testCase, int lineNumber, char *fileName, const char *type, ...) {
  va_list v;
  va_start(v, type);
  EXExpect *exExpect;
  if(strcmp(type, @encode(char)) == 0) {
    char actual = (char)va_arg(v, int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithChar:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(double)) == 0) {
    double actual = (double)va_arg(v, double);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithDouble:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(float)) == 0) {
    float actual = (float)va_arg(v, double);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithFloat:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(int)) == 0) {
    int actual = (int)va_arg(v, int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithInt:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(long)) == 0) {
    long actual = (long)va_arg(v, long);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithLong:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(long long)) == 0) {
    long long actual = (long long)va_arg(v, long long);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithLongLong:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(short)) == 0) {
    short actual = (short)va_arg(v, int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithShort:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(unsigned char)) == 0) {
    unsigned char actual = (unsigned char)va_arg(v, unsigned int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithUnsignedChar:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(unsigned int)) == 0) {
    unsigned int actual = (int)va_arg(v, unsigned int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithUnsignedInt:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(unsigned long)) == 0) {
    unsigned long actual = (unsigned long)va_arg(v, unsigned long);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithUnsignedLong:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(unsigned long long)) == 0) {
    unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithUnsignedLongLong:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(unsigned short)) == 0) {
    unsigned short actual = (unsigned short)va_arg(v, unsigned int);
    exExpect = [EXExpect expectWithActual:[NSNumber numberWithUnsignedShort:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(id)) == 0) {
    id actual = va_arg(v, id);
    exExpect = [EXExpect expectWithActual:actual testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(strcmp(type, @encode(__typeof__(nil))) == 0) {
    exExpect = [EXExpect expectWithActual:nil testCase:testCase lineNumber:lineNumber fileName:fileName];
  } else if(type[0] == '{' || type[0] == '(') {
    NSString *reason = [NSString stringWithFormat:@"%s:%d expecting a %@ instance is not supported", fileName, lineNumber, type[0] == '{' ? @"struct" : @"union"];
    [testCase failWithException:[NSException exceptionWithName:@"Expecta Error" reason:reason userInfo:nil]];
  } else {
    void *actual = va_arg(v, void *);
    exExpect = [EXExpect expectWithActual:[NSValue valueWithPointer:actual] testCase:testCase lineNumber:lineNumber fileName:fileName];
  }
  va_end(v);
  return exExpect;
}

NSString *EXDescribeObject(id obj) {
  if(obj == nil) {
    return @"nil";
  } else if([obj isKindOfClass:[NSString class]]) {
    return [NSString stringWithFormat:@"@\"%@\"", obj];
  } else if([obj isKindOfClass:[NSNumber class]]) {
    const char *type = [obj objCType];
    if(strcmp(type, @encode(BOOL)) == 0) {
      return [obj boolValue] ? @"YES" : @"NO";
    } else if(strcmp(type, @encode(char)) == 0) {
      return [NSString stringWithFormat:@"(char) %d", [obj charValue]];
    }
  }
  return [NSString stringWithFormat:@"%@", obj];
}
