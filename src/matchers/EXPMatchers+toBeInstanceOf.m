// Expecta - EXPMatchers+toBeInstanceOf.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatchers+toBeInstanceOf.h"

EXPMatcherImplementationBegin(toBeInstanceOf, (Class expected)) {
  match(^BOOL{
    return [actual isMemberOfClass:expected];
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });
}
EXPMatcherImplementationEnd
