//
//  EXPMatcher.h
//  Expecta
//
//  Created by Luke Redpath on 26/03/2012.
//  Copyright (c) 2012 Peter Jihoon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EXPMatcher <NSObject>

- (BOOL)meetsPrerequesiteFor:(id)actual;
- (BOOL)matches:(id)actual;
- (NSString *)failureMessageForTo:(id)actual;
- (NSString *)failureMessageForNotTo:(id)actual;

@end
