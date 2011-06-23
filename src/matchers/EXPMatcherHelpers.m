// Expecta - EXPMatcherHelpers.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatcherHelpers.h"

BOOL EXPIsValuePointer(NSValue *value) {
  return [value objCType][0] == @encode(void *)[0];
}

BOOL EXPIsNumberFloat(NSNumber *number) {
  return strcmp([number objCType], @encode(float)) == 0;
}
