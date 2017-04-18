#import "EXPMatchers+beSubclassOf.h"
#import "NSValue+Expecta.h"
#import <objc/runtime.h>

EXPMatcherImplementationBegin(beSubclassOf, (Class expected)) {
  __block BOOL actualIsClass = YES;

  prerequisite(^BOOL(id actual){
    actualIsClass = class_isMetaClass(object_getClass(actual));
    return actualIsClass;
  });

  match(^BOOL(id actual){
    return [actual isSubclassOfClass:expected];
  });

  failureMessageForTo(^NSString *(id actual){
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: a subclass of %@, got: a class %@, which is not a subclass of %@", [expected class], actual, [expected class]];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: not a subclass of %@, got: a class %@, which is a subclass of %@", [expected class], actual, [expected class]];
  });
}
EXPMatcherImplementationEnd
