//
//  BeginBlessModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BeginBlessModel.h"

@implementation BeginBlessModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bless_type_image_list":@"data.bless_type_image_list",
             @"bless_user_relation_list":@"data.bless_user_relation_list",
             @"bless_days":@"data.bless_days",
             @"bless_type":@"data.bless_type",
             @"bless_type_chengnuo":@"data.bless_type_chengnuo",
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bless_type_image_list":[BlessTypeImageModel class],
             @"bless_user_relation_list":[BlessTypeRelationModel class]
             };
}
@end

@implementation BlessTypeRelationModel

@end
@implementation BlessTypeImageModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"imageID":@"id"
             };
}
@end
@implementation BeginBlessTypeModel

@end
