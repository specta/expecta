#import "NSValue+Expecta.h"
#import <objc/runtime.h>
#import "Expecta.h"

EXFixCategoriesBug(NSValue_Expecta);

@implementation NSValue (Expecta)

static char _EX_typeKey;

- (const char *)_EX_objCType {
  return [(NSString *)objc_getAssociatedObject(self, &_EX_typeKey) cStringUsingEncoding:NSASCIIStringEncoding];
}

- (void)set_EX_objCType:(const char *)_EX_objCType {
  objc_setAssociatedObject(self, &_EX_typeKey,
                           [NSString stringWithCString:_EX_objCType encoding:NSASCIIStringEncoding],
                           OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
