#import "EXMatcherHelpers.h"

BOOL EXIsValuePointer(NSValue *value) {
  return [value objCType][0] == @encode(void *)[0];
}

BOOL EXIsNumberFloat(NSNumber *number) {
  return strcmp([number objCType], @encode(float)) == 0;
}
