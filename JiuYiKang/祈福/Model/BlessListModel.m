//
//  BlessListModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessListModel.h"

@implementation BlessListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bless_type_list":@"data.bless_type_list",
             @"my_bless_list":@"data.my_bless_list",
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bless_type_list":[BlessTypeListModel class],
             @"my_bless_list":[BlessSmallModel class],
             };
}
@end

@implementation BlessTypeListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"typeListModelID":@"id",
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bless_list":[BlessSmallModel class],
             };
}
@end

@implementation BlessSmallModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"smallID":@"id",
             };
}
@end
