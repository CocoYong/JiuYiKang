//
//  JieSuanMingXiModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/7.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MoneyInfoModel : NSObject
@property(nonatomic,copy)NSString *money_doing;
@property(nonatomic,copy)NSString *sum_push_money;
@property(nonatomic,copy)NSString *sum_push_money_enabled;
@property(nonatomic,copy)NSString *hadDespositMoney;
@end


@interface JieSuanMingXiModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *money_doing;
@property(nonatomic,strong)NSArray *pushListArray;
@property(nonatomic,copy)NSString *share_desc;
@property(nonatomic,copy)NSString *share_img;
@property(nonatomic,copy)NSString *share_title;
@property(nonatomic,strong)MoneyInfoModel *moneyInfoModel;
@end

@interface MingXiPushListModel : NSObject
@property(nonatomic,copy)NSString *apply_id;
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *from_user_id;
@property(nonatomic,copy)NSString *from_user_id_str;
@property(nonatomic,copy)NSString *listID;
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *title_sub;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_id;
@end


