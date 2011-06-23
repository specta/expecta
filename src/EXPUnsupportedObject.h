// Expecta - EXPUnsupportedObject.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

@interface EXPUnsupportedObject : NSObject {
  NSString *_type;
}

@property (nonatomic, retain) NSString *type;

- (id)initWithType:(NSString *)type;

@end
