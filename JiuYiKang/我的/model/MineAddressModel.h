//
//  MineAddressModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineAddressModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *address_detail;
@property(nonatomic,copy)NSString *post_code;
@property(nonatomic,copy)NSString *province_city_district;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *mobile;

@end
