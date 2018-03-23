//
//  InvitedListModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "InvitedListModel.h"

@implementation InvitedListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"pushListArray":@"data.my_push_list",
             @"pushCount":@"data.my_push_count",
             @"share_title":@"data.share_title",
             @"share_img":@"data.share_img",
             @"share_desc":@"data.share_desc",
             @"sum_push_money":@"data.sum_push_money"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pushListArray":[PushListModel class]};
}
@end

@implementation PushListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"firendID":@"id"};
}
@end
