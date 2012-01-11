#import "EXPMatchers+toBeSubclassOf.h"
#import "NSValue+Expecta.h"
#import <objc/runtime.h>

EXPMatcherImplementationBegin(toBeSubclassOf, (Class expected)) {
  __block BOOL actualIsClass = YES;
  __block BOOL isSubclass = NO;

  prerequisite(^BOOL {
    @try {
      isSubclass = [actual isSubclassOfClass:expected];
    } @catch (NSException *exception) {
      actualIsClass = NO;
    }
    return actualIsClass;
  });

  match(^BOOL{
    return isSubclass;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: a subclass of %@, got: a class %@, which is not a subclass of %@", [expected class], actual, [expected class]];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsClass) return @"the actual value is not a Class";
    return [NSString stringWithFormat:@"expected: not a subclass of %@, got: a class %@, which is a subclass of %@", [expected class], actual, [expected class]];
  });
}
EXPMatcherImplementationEnd
