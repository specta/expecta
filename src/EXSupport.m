#import "EXSupport.h"
#import "Expecta.h"

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

