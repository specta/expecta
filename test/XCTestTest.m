//
//  XCTestTest.m
//  Expecta
//
//  Created by Christopher Pickslay on 10/4/13.
//  Copyright (c) 2013 Peter Jihoon Kim. All rights reserved.
//

#import "TestHelper.h"

@interface XCTestTest : TEST_SUPERCLASS

@end

@implementation XCTestTest

- (void)testFailuresShouldReportLineNumberInXcode {
    BOOL failureIsAnOption = NO;
    expect(failureIsAnOption).to.beTruthy();
}

@end
