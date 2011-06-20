#import <Foundation/Foundation.h>

@interface EXUnsupportedObject : NSObject {
  NSString *_type;
}

@property (nonatomic, retain) NSString *type;

- (id)initWithType:(NSString *)type;

@end
