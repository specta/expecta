#import "EXPMatchers+beKindOf.h"

EXPMatcherImplementationBegin(beKindOf, (Class expected)) {
  BOOL (^actualIsNil)(id actual) = ^BOOL(id actual) { return (actual == nil); };
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL(id actual){
    return !(actualIsNil(actual) || expectedIsNil);
  });

  match(^BOOL(id actual){
    return [actual isKindOfClass:expected];
  });

  failureMessageForTo(^NSString *(id actual){
    if(actualIsNil(actual)) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: a kind of %@, got: an instance of %@, which is not a kind of %@", [expected class], [actual class], [expected class]];
  });

  failureMessageForNotTo(^NSString *(id actual){
    if(actualIsNil(actual)) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: not a kind of %@, got: an instance of %@, which is a kind of %@", [expected class], [actual class], [expected class]];
  });
}
EXPMatcherImplementationEnd
