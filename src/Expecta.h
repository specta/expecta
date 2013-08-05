#import <Foundation/Foundation.h>
#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/ExpectaSupport.h>
#else
#import "ExpectaSupport.h"
#endif

#define EXPObjectify(value) _EXPObjectify(@encode(__typeof__((value))), (value))

#define EXP_expect(actual) _EXP_expect(self, __LINE__, __FILE__, ^id{ return EXPObjectify((actual)); })

#define EXPMatcherInterface(matcherName, matcherArguments) _EXPMatcherInterface(matcherName, matcherArguments)
#define EXPMatcherImplementationBegin(matcherName, matcherArguments) _EXPMatcherImplementationBegin(matcherName, matcherArguments)
#define EXPMatcherImplementationEnd _EXPMatcherImplementationEnd

#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/EXPMatchers.h>
#else
#import "EXPMatchers.h"
#endif

#ifdef EXP_SHORTHAND
#  define expect(actual) EXP_expect((actual))
#endif

#ifdef EXP_OLD_SYNTAX
#  import "EXPBackwardCompatibility.h"
#endif

@interface Expecta : NSObject

+ (NSTimeInterval)asynchronousTestTimeout;
+ (void)setAsynchronousTestTimeout:(NSTimeInterval)timeout;

@end
