//
//  UserInfoModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/1.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"bank_card_user_name":@"data.user_info.bank_card_user_name",
             @"bank_name":@"data.user_info.bank_name",
             @"bank_name_sub":@"data.user_info.bank_name_sub",
             @"birthday":@"data.user_info.birthday",
             @"face_uri":@"data.user_info.face_uri",
             @"id_str":@"data.user_info.id_str",
             @"job":@"data.user_info.job",
             @"mobile":@"data.user_info.mobile",
             @"sex":@"data.user_info.sex",
             @"sum_push_money":@"data.user_info.sum_push_money",
             @"sum_push_money_enabled":@"data.user_info.sum_push_money_enabled",
             @"token":@"data.user_info.token",
             @"use_bank":@"data.user_info.use_bank",
             @"user_name":@"data.user_info.user_name",
             @"user_id":@"data.user_info.user_id",
             @"has_join":@"data.has_join",
             @"product_join_money":@"data.product_join_money",
             @"product_join_money_msg":@"data.product_join_money_msg"};
}
-(void)setBirthday:(NSString *)birthday
{
    _birthday=birthday;
    NSInteger  year=[[birthday substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSDateComponents  *components=[[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger todayYear=[components year];
    self.age=[NSString stringWithFormat:@"%ld",todayYear-year+1];
}
@end
