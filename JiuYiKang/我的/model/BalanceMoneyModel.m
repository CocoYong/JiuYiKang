//
//  BalanceMoneyModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BalanceMoneyModel.h"

@implementation BalanceMoneyModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"share_img":@"data.share_img",
             @"share_desc":@"data.share_desc",
             @"share_title":@"data.share_title",
             @"detailListArray":@"data.detail_list",
             @"productModel":@"data.product_join"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"detailListArray":[DetailListModel class]};
}
@end
@implementation DetailListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"detailID":@"id"};
}
@end
@implementation ProductJoinModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"productID":@"id"};
}


@end
