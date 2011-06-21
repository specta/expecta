#import "EXMatchers+toBeInstanceOf.h"

EXMatcherImplementationBegin(toBeInstanceOf, (Class expected)) {
  match(^BOOL{
    return [actual isMemberOfClass:expected];
  });

  failureMessageForTo(^{
    return [NSString stringWithFormat:@"expected: an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });

  failureMessageForNotTo(^{
    return [NSString stringWithFormat:@"expected: not an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });
}
EXMatcherImplementationEnd
