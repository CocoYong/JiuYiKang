//
//  JoinFormModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/27.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JoinFormModel.h"

@implementation JoinFormModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"productList":[ProductListModel class],
             @"relationList":[RelationListModel class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productList":@"data.product_vip_list",
             @"relationList":@"data.relation_list"};
}

@end
@implementation ProductListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productID":@"id"};
}

@end

@implementation RelationListModel



@end
