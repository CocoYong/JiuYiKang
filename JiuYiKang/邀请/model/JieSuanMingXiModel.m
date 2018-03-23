//
//  JieSuanMingXiModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/7.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JieSuanMingXiModel.h"

@implementation JieSuanMingXiModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"pushListArray":[MingXiPushListModel class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"pushListArray":@"data.my_push_list",
             @"moneyInfoModel":@"data.user_money_info",
             @"money_doing":@"data.money_doing",
             @"share_desc":@"data.share_desc",
             @"share_img":@"data.share_img",
             @"share_title":@"data.share_title"};
}
@end
@implementation MingXiPushListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"listID":@"id"};
}


@end

@implementation MoneyInfoModel

-(NSString*)hadDespositMoney
{
    return [NSString stringWithFormat:@"%.2f",[self.sum_push_money floatValue]-[self.sum_push_money_enabled floatValue]-[self.money_doing floatValue]];
}
@end
