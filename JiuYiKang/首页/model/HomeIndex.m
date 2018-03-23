//
//  HomeIndex.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "HomeIndex.h"

@implementation HomeIndex
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"banners":@"data.banners",
             @"product_list":@"data.product_list",
             @"count_join":@"data.count_join"
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"banners":[Bannsers class],
             @"product_list":[ProductList class]
             };
}
@end

@implementation Bannsers



@end
@implementation ProductList
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"productID":@"id",
             };
}
@end


