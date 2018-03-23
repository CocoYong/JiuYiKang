//
//  WeiXinPayModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXinPayModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *appid;
@property(nonatomic,copy)NSString *noncestr;
@property(nonatomic,copy)NSString *package;
@property(nonatomic,copy)NSString *partnerid;
@property(nonatomic,copy)NSString *pay_id;
@property(nonatomic,copy)NSString *prepayid;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic,copy)NSString *timestamp;
@end
