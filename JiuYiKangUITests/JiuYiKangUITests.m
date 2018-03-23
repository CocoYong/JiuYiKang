//
//  JiuYiKangUITests.m
//  JiuYiKangUITests
//
//  Created by MrZhang on 2017/10/28.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BaseViewController.h"
@interface JiuYiKangUITests : XCTestCase

@end

@implementation JiuYiKangUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}
- (void)tearDown {
    [super tearDown];
}

-(void)testloginButtonAction:(UIButton *)sender
{
    
}

@end
