//
//  EXPRuntimeMatcher.m
//  Expecta
//
//  Created by Luke Redpath on 26/03/2012.
//  Copyright (c) 2012 Peter Jihoon Kim. All rights reserved.
//

#import "EXPBlockDefinedMatcher.h"

@implementation EXPBlockDefinedMatcher

- (void)dealloc
{
    self.prerequisiteBlock = nil;
    self.matchBlock = nil;
    self.failureMessageForToBlock = nil;
    self.failureMessageForNotToBlock = nil;
    
    [super dealloc];
}

@synthesize prerequisiteBlock;
@synthesize matchBlock;
@synthesize failureMessageForToBlock;
@synthesize failureMessageForNotToBlock;

- (BOOL)meetsPrerequesiteFor:(id)actual
{
  if (self.prerequisiteBlock) {
    return self.prerequisiteBlock(actual);
  }
  return YES;
}

- (BOOL)matches:(id)actual
{
  if (self.matchBlock) {
    return self.matchBlock(actual);
  }
  return YES;
}

- (NSString *)failureMessageForTo:(id)actual
{
  if (self.failureMessageForToBlock) {
    return self.failureMessageForToBlock(actual);
  }
  return nil;
}

- (NSString *)failureMessageForNotTo:(id)actual
{
  if (self.failureMessageForNotToBlock) {
    return self.failureMessageForNotToBlock(actual);
  }
  return nil;
}

@end
