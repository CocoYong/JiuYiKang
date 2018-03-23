//
//  BlessListModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlessSmallModel:NSObject
@property(nonatomic,copy)NSString *smallID; //id
@property(nonatomic,copy)NSString *name; //大病祈福
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *face_uri; //图像
@property(nonatomic,copy)NSString *bless_days; //祈福时间
@property(nonatomic,copy)NSString *bank_name;  //开户行
@property(nonatomic,copy)NSString *bank_card_number;  //开户行账户
@property(nonatomic,copy)NSString *bank_card_user_name;  //开户行姓名
@property(nonatomic,copy)NSString *bank_card_user_mobile;  //电话

@property(nonatomic,copy)NSString *bank_card_user_relative;  //关系
@property(nonatomic,copy)NSString *user_id;  //
@property(nonatomic,copy)NSString *bless_stat;  //祈福状态
@property(nonatomic,copy)NSString *bless_stat_str;  //祈福状态
@property(nonatomic,copy)NSString *bless_type_name; //大病祈福
@property(nonatomic,copy)NSString *count_bless_love;  //爱心数量
@property(nonatomic,copy)NSString *creator_face_uri;  //帮助者图像
@property(nonatomic,copy)NSString *creator_user_name;  //帮助者姓名
@property(nonatomic,copy)NSString *date_bless_end; //结束日期

@property(nonatomic,copy)NSString *bless_for_user_name; //
@property(nonatomic,copy)NSString *bless_for_user_name_images;  //
@property(nonatomic,copy)NSString *bless_reason;  //
@property(nonatomic,copy)NSString *bless_reason_images;  //
@property(nonatomic,copy)NSString *bless_reason_desc_more; //
@property(nonatomic,copy)NSString *id_str;  //
@property(nonatomic,copy)NSString *pay_money;  //
@property(nonatomic,copy)NSString *bless_type_id;
@end

@interface BlessTypeListModel:NSObject
@property(nonatomic,copy)NSString *typeListModelID; //id
@property(nonatomic,copy)NSString *name; //大病祈福
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *image_uri;
@property(nonatomic,copy)NSString *bless_for_user_name_vi_name; //患者姓名
@property(nonatomic,copy)NSString *bless_reason_vi_name;  //所患疾病
@property(nonatomic,copy)NSString *money;
@property(nonatomic,strong)NSArray *bless_list;
@end

@interface BlessListModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSArray *bless_type_list;
@property(nonatomic,strong)NSArray *my_bless_list;
@end
