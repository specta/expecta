//
//  EXPMatchers+notify.m
//  Pods
//
//  Created by Ron Lisle on 11/10/13.
//
//

#import "EXPMatchers+notify.h"

EXPMatcherImplementationBegin(notify, (NSString *expectedNotificationName)){
    
    match(^BOOL{
        __block BOOL expectedNotificationOccurred = NO;
        
        id observer = [[NSNotificationCenter defaultCenter] addObserverForName:expectedNotificationName object:nil queue:nil usingBlock:^(NSNotification *note){
            expectedNotificationOccurred = YES;
        }];

        ((EXPBasicBlock)actual)();
        
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        
        return expectedNotificationOccurred;
    });
    
    failureMessageForTo(^NSString *{
        return @"expected notification did not occur";
    });
    
    failureMessageForNotTo(^NSString *{
        return @"expected notification not to occur but it did";
    });
}

EXPMatcherImplementationEnd
