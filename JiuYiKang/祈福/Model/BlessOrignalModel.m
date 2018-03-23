//
//  BlessOrignalModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/20.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessOrignalModel.h"

@implementation BlessOrignalModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bless_type_list":@"data.bless_type_list",
             @"bless_desc":@"data.bless_desc",
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bless_type_list":[BlessTypeModel class],
             };
}
@end

@implementation BlessTypeModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"typeID":@"id",
             };
}
@end
