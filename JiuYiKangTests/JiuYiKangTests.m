//
//  JiuYiKangTests.m
//  JiuYiKangTests
//
//  Created by MrZhang on 2017/10/28.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"
#import "ZYDataRequest.h"
@interface JiuYiKangTests : XCTestCase

@end

@implementation JiuYiKangTests

- (void)setUp {
    [super setUp];
    [self testLogin];
    
    
}

- (void)tearDown {
    [super tearDown];
}

-(void)testLogin
 {
     NSDictionary *paramsDic=@{@"mobile":@"18307210261",@"password":@"222222"};
     [ZYDataRequest requestWithURL:@"AppApi/Account/login" params:paramsDic block:^(NSObject *result)
      {
          NSDictionary *dic=(NSDictionary*)result;
          if ([[dic objectForKey:@"code"] isEqualToString:@"0"]) {
          
          }
      } errorBlock:^(NSError *error) {
      } noNetWorking:^(NSString *noNetWorking) {
      }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
