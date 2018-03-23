//
//  ProjectDescriptionModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/21.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ProjectDescriptionModel.h"

@implementation ProjectDescriptionModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"articleModel":@"data.article_join",
             @"joinItemList":@"data.join_item_list",
             @"modelID":@"data.id",
             @"with_footer_nav":@"data.with_footer_nav"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"joinItemList":[JoinItemModel class]};
}
@end

@implementation JoinItemModel


@end

@implementation ArticleJoinModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"articleID":@"id"};
}
@end
