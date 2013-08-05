//
//  EXPRuntimeMatcher.h
//  Expecta
//
//  Created by Luke Redpath on 26/03/2012.
//  Copyright (c) 2012 Peter Jihoon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef EXP_FRAMEWORK_HEADERS
#import <Expecta/EXPMatcher.h>
#import <Expecta/EXPDefines.h>
#else
#import "EXPMatcher.h"
#import "EXPDefines.h"
#endif

@interface EXPBlockDefinedMatcher : NSObject <EXPMatcher> {
  EXPBoolBlock prerequisiteBlock;
  EXPBoolBlock matchBlock;
  EXPStringBlock failureMessageForToBlock;
  EXPStringBlock failureMessageForNotToBlock;
}

@property(nonatomic, copy) EXPBoolBlock prerequisiteBlock;
@property(nonatomic, copy) EXPBoolBlock matchBlock;
@property(nonatomic, copy) EXPStringBlock failureMessageForToBlock;
@property(nonatomic, copy) EXPStringBlock failureMessageForNotToBlock;

@end
