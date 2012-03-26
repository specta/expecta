//
//  EXPRuntimeMatcher.h
//  Expecta
//
//  Created by Luke Redpath on 26/03/2012.
//  Copyright (c) 2012 Peter Jihoon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXPMatcher.h"
#import "EXPDefines.h"

@interface EXPRuntimeMatcher : NSObject <EXPMatcher>

@property(nonatomic, copy) EXPBoolBlock prerequisiteBlock;
@property(nonatomic, copy) EXPBoolBlock matchBlock;
@property(nonatomic, copy) EXPStringBlock failureMessageForToBlock;
@property(nonatomic, copy) EXPStringBlock failureMessageForNotToBlock;

@end
