// Expecta - FakeTestCase.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "FakeTestCase.h"

@implementation FakeTestCase

- (void)failWithException:(NSException *)exception {
  NSException *e = [NSException exceptionWithName:[exception reason] reason:[exception reason] userInfo:nil];
  [e raise];
}

@end
