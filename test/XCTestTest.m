//
//  XCTestTest.m
//  Expecta
//
//  Created by Christopher Pickslay on 10/4/13.
//  Copyright (c) 2013 Peter Jihoon Kim. All rights reserved.
//

#import "TestHelper.h"

#ifdef __IPHONE_7_0
#import <XCTest/XCTest.h>
@interface XCTestTest : XCTestCase
#else
@interface XCTestTest : SenTestCase
#endif

@end

@implementation XCTestTest

- (void)testFailuresShouldReportLineNumberInXcode {
    BOOL failureIsAnOption = NO;
    expect(failureIsAnOption).to.beTruthy();
}

@end
