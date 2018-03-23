//
//  AllRechargeModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ConfigeListModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *configeID;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *money_des;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@end


@interface JoinListModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *date_enabled;
@property(nonatomic,copy)NSString *date_join_in;
@property(nonatomic,copy)NSString *datetime_disabled;
@property(nonatomic,copy)NSString *datetime_faild;
@property(nonatomic,copy)NSString *listID;
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *join_user_name;
@property(nonatomic,copy)NSString *list_image;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *product_name;
@property(nonatomic,copy)NSString *product_vip_id;
@property(nonatomic,copy)NSString *stat;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *user_id_card;
@property(nonatomic,copy)NSString *user_relation;
@property(nonatomic,assign)BOOL selected;
@end
@interface AllRechargeModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *share_desc;
@property(nonatomic,copy)NSString *share_img;
@property(nonatomic,copy)NSString *share_title;
@property(nonatomic,strong)NSArray *configeListArray;
@property(nonatomic,copy)NSArray *joinListArray;
@property(nonatomic,copy)NSArray *selectIDsArray;
@end
