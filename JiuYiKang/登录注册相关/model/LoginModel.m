//
//  LoginModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/16.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"loginData":@"data"};
}

@end
@implementation LoginData
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"face_uri":@"user_info.face_uri",
             @"mobile":@"user_info.mobile",
             @"token":@"user_info.token",
             @"user_name":@"user_info.user_name",
             };
}
@end

