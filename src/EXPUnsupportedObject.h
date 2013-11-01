#import <Foundation/Foundation.h>

@interface EXPUnsupportedObject : NSObject {
  NSString *_type;
}

@property (nonatomic, strong) NSString *type;

- (id)initWithType:(NSString *)type;

@end
