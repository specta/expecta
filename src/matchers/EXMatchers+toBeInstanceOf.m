#import "EXMatchers+toBeInstanceOf.h"

EXMatcherImplementationBegin(toBeInstanceOf, (Class expected)) {
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
EXMatcherImplementationEnd
