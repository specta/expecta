// Expecta - EXPMatchers+toBeKindOf.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatchers+toBeKindOf.h"

EXPMatcherImplementationBegin(toBeKindOf, (Class expected)) {
  match(^BOOL{
    return [actual isKindOfClass:expected];
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: a kind of %@, got: an instance of %@, which is not a kind of %@", [expected class], [actual class], [expected class]];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not a kind of %@, got: an instance of %@, which is a kind of %@", [expected class], [actual class], [expected class]];
  });
}
EXPMatcherImplementationEnd
