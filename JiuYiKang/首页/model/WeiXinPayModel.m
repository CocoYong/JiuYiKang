//
//  WeiXinPayModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "WeiXinPayModel.h"

@implementation WeiXinPayModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"appid":@"data.appid",
             @"noncestr":@"data.noncestr",
             @"package":@"data.package",
             @"partnerid":@"data.partnerid",
             @"pay_id":@"data.pay_id",
             @"prepayid":@"data.prepayid",
             @"sign":@"data.sign",
             @"timestamp":@"data.timestamp"};
}
@end
