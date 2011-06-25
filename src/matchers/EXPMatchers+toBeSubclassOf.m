// Expecta - EXPMatchers+toBeSubclassOf.m
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import "EXPMatchers+toBeSubclassOf.h"
#import "NSValue+Expecta.h"

EXPMatcherImplementationBegin(toBeSubclassOf, (Class expected)) {
  BOOL actualIsClass = [actual isKindOfClass:[NSValue class]] && (strcmp([actual _EXP_objCType], @encode(Class)) == 0);
  Class actualClass = actualIsClass ? (Class)[(NSValue *)actual pointerValue] : NULL;

  prerequisite(^BOOL {
    return actualIsClass;
  });

  match(^BOOL{
    return [actualClass isSubclassOfClass:expected];
  });

  failureMessageForTo(^NSString *{
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: a subclass of %@, got: a class %@, which is not a subclass of %@", [expected class], actualClass, [expected class]];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: not a subclass of %@, got: a class %@, which is a subclass of %@", [expected class], actualClass, [expected class]];
  });
}
EXPMatcherImplementationEnd
