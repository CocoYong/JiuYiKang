//
//  MineAddressModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineAddressModel.h"

@implementation MineAddressModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"address_detail":@"data.user_address.address_detail",
             @"post_code":@"data.user_address.post_code",
             @"province_city_district":@"data.user_address.province_city_district",
             @"user_name":@"data.user_address.user_name",
             @"mobile":@"data.user_address.mobile"};
}
@end
