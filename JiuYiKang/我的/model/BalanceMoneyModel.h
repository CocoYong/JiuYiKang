//
//  BalanceMoneyModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductJoinModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *date_enabled;
@property(nonatomic,copy)NSString *date_join_in;
@property(nonatomic,copy)NSString *datetime_disabled;
@property(nonatomic,copy)NSString *datetime_faild;
@property(nonatomic,copy)NSString *datetime_waiting_begin;
@property(nonatomic,copy)NSString *disabled_msg;
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *is_user_info_error;
@property(nonatomic,copy)NSString *join_user_name;

@property(nonatomic,copy)NSString *list_image;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *money_alert;
@property(nonatomic,copy)NSString *money_normal;
@property(nonatomic,copy)NSString *money_tip;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *product_name;
@property(nonatomic,copy)NSString *product_vip_id;
@property(nonatomic,copy)NSString *product_vip_name;
@property(nonatomic,copy)NSString *moneyMax;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *stat;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *user_id_card;
@property(nonatomic,copy)NSString *user_relation;
@property(nonatomic,copy)NSString *productID;
@property(nonatomic,copy)NSString *stat_and_money_tip;
@end
@interface BalanceMoneyModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *share_desc;
@property(nonatomic,copy)NSString *share_img;
@property(nonatomic,copy)NSString *share_title;
@property(nonatomic,strong)NSArray *detailListArray;
@property(nonatomic,strong)ProductJoinModel *productModel;
@end

@interface DetailListModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *join_id;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *detailID;
@property(nonatomic,copy)NSString *des;

@end
