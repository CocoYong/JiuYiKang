//
//  AllRechargeModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AllRechargeModel.h"

@implementation AllRechargeModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"share_desc":@"data.share_desc",
             @"share_img":@"data.share_img",
             @"share_title":@"data.share_title",
             @"configeListArray":@"data.config_recharge_list",
             @"joinListArray":@"data.join_list",
             @"selectIDsArray":@"data.select_ids"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"configeListArray":[ConfigeListModel class],
             @"joinListArray":[JoinListModel class],
             @"selectIDsArray":[NSString class]};
}
@end
@implementation ConfigeListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"configeID":@"id"};
}


@end
@implementation JoinListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"listID":@"id"};
}
-(void)setProduct_name:(NSString *)product_name
{
    _product_name=product_name;
    self.selected=NO;
}

@end
