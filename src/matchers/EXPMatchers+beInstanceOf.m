#import "EXPMatchers+beInstanceOf.h"

EXPMatcherImplementationBegin(beInstanceOf, (Class expected)) {
  BOOL (^actualIsNil)(id actual) = ^BOOL(id actual){ return (actual == nil); };
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL(id actual){
    return !(actualIsNil(actual) || expectedIsNil);
  });

  match(^BOOL(id actual){
    return [actual isMemberOfClass:expected];
  });

  failureMessageForTo(^NSString *(id actual){
    if(actualIsNil(actual)) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if(actualIsNil(actual)) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: not an instance of %@, got: an instance of %@", [expected class], [actual class]];
  });
}
EXPMatcherImplementationEnd
