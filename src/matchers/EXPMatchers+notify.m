//
//  EXPMatchers+notify.m
//  Pods
//
//  Created by Ron Lisle on 11/10/13.
//
//

#import "EXPMatchers+notify.h"

EXPMatcherImplementationBegin(notify, (id expectedNotification)){
    
    match(^BOOL{
        __block BOOL expectedNotificationOccurred = NO;
        NSString *name;
        BOOL isNotification = [expectedNotification isKindOfClass:[NSNotification class]];
        BOOL isName = [expectedNotification isKindOfClass:[NSString class]];
        if (isNotification) {
            name = [expectedNotification name];
        }else if(isName) {
            name = expectedNotification;
        }else {
            return NO;
        }
            
        id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification *note){
            if (isNotification) {
                expectedNotificationOccurred = [expectedNotification isEqual:note];
            }else{
                expectedNotificationOccurred = YES;
            }
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
