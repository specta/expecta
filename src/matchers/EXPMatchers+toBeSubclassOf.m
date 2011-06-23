// Expecta - EXPMatchers+toBeSubclassOf.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatchers+toBeSubclassOf.h"

EXPMatcherImplementationBegin(toBeSubclassOf, (Class expected)) {
  Class actualClass = (Class)[(NSValue *)actual pointerValue];

  match(^BOOL{
    return [actualClass isSubclassOfClass:expected];
  });

  failureMessageForTo(^NSString *{
    return [NSString stringWithFormat:@"expected: a subclass of %@, got: a class %@, which is not a subclass of %@", [expected class], actualClass, [expected class]];
  });

  failureMessageForNotTo(^NSString *{
    return [NSString stringWithFormat:@"expected: not a subclass of %@, got: a class %@, which is a subclass of %@", [expected class], actualClass, [expected class]];
  });
}
EXPMatcherImplementationEnd
