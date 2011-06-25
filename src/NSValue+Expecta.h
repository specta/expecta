// Expecta - NSValue+Expecta.h
// Copyright (c) 2011 Peter Jihoon Kim
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

@interface NSValue (Expecta)

- (const char *)_EXP_objCType;
- (void)set_EXP_objCType:(const char *)_EXP_objCType;

@end
