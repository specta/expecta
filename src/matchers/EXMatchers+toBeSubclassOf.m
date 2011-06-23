#import "EXMatchers+toBeSubclassOf.h"

EXMatcherImplementationBegin(toBeSubclassOf, (Class expected)) {
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
EXMatcherImplementationEnd
