//
//  BeginUpdateModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/27.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeginUpdateModel : NSObject
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *bless_type_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *bless_username;
@property(nonatomic,strong)NSMutableArray *photoModelArray;
@property(nonatomic,copy)NSString *bless_days;
@property(nonatomic,copy)NSString *bank_name;
@property(nonatomic,copy)NSString *bank_card_number;
@property(nonatomic,copy)NSString *bank_card_user_name;
@property(nonatomic,copy)NSString *bank_card_user_mobile;
@property(nonatomic,copy)NSString *bank_card_user_relative;
-(NSString*)checkPropertyIsEmpty;
-(BOOL)chechInfomationIsOK;
@end
