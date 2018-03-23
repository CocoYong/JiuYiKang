//
//  InvitedListModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitedListModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSArray *pushListArray;
@property(nonatomic,copy)NSString *pushCount;
@property(nonatomic,copy)NSString *share_title;
@property(nonatomic,copy)NSString *share_img;
@property(nonatomic,copy)NSString *share_desc;
@property(nonatomic,copy)NSString *sum_push_money;
@property(nonatomic,strong)UIImage *shareImage;
@end


@interface PushListModel : NSObject
@property(nonatomic,copy)NSString *agent_type;
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *bank_card_user_name;
@property(nonatomic,copy)NSString *bank_name;
@property(nonatomic,copy)NSString *bank_name_sub;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *create_time;

@property(nonatomic,copy)NSString *datetime_last_read_msg;
@property(nonatomic,copy)NSString *face_uri;
@property(nonatomic,copy)NSString *firendID;
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *is_agent_join_any;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *is_pusher_money;

@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,strong)NSArray *pusher_id;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *sum_push_money;
@property(nonatomic,copy)NSString *sum_push_money_enabled;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *weixin_open_id;
@end
