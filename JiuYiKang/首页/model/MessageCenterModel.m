//
//  MessageCenterModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/6.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MessageCenterModel.h"

@implementation MessageCenterModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"messageListArray":@"data.msg_list",
             @"offset":@"data.offset",
             @"per_page":@"data.per_page",
             @"msg_count":@"data.msg_count"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"messageListArray":[MessageListModel class]};
}
@end

@implementation MessageListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"messageID":@"id"};
}


@end
