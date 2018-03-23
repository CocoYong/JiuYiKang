//
//  MyHelpOtherModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/1.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MyHelpOtherModel.h"

@implementation MyHelpOtherModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"share_img":@"data.share_img",
             @"share_desc":@"data.share_desc",
             @"share_title":@"data.share_title",
             @"joinListArray":@"data.join_list",
             @"joinModel":@"data.join"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"joinListArray":[MyHelpOtherListModel class]};
}
@end
@implementation MyHelpOtherListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"listID":@"id"};
}


@end
