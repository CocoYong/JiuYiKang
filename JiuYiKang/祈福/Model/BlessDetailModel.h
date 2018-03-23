//
//  BlessDetailModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageListModel:NSObject
@property(nonatomic,copy)NSString *name; //说明  eg  疾病证明  入院证明
@property(nonatomic,copy)NSString *image_uri;//图像
@property(nonatomic,copy)NSString *image_uri_thumb; //小图像
@end
@interface ReferencDataModel:NSObject
@property(nonatomic,copy)NSString *user_name; //证明人姓名
@property(nonatomic,copy)NSString *user_relative;//关系
@property(nonatomic,copy)NSString *face_uri;//图像
@property(nonatomic,copy)NSString *id_card_image;//身份证
@property(nonatomic,copy)NSString *other_images;//其他图像
@property(nonatomic,copy)NSString *desc; //描述
@property(nonatomic,copy)NSString *pass_stat;//是否通过审核
@end

@interface BlessLoveListModel:NSObject
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *face_uri;
@end

@interface OtherDataModel:NSObject
@property(nonatomic,copy)NSString *name;
@end

@interface BlessModel:NSObject
@property(nonatomic,copy)NSString *blessID; //blessID
@property(nonatomic,copy)NSString *name; // 祈福标题
@property(nonatomic,copy)NSString *desc; //描述
@property(nonatomic,copy)NSString *face_uri; //图像
@property(nonatomic,copy)NSString *bless_days; //天数
@property(nonatomic,copy)NSString *id_str; //分享专用
@property(nonatomic,copy)NSString *create_time; //创建时间
@property(nonatomic,copy)NSString *bless_type_name; //祈福类型 eg 大病祈福  天下微笑  助学
@property(nonatomic,copy)NSString *count_bless_love; //祈福爱心数
@property(nonatomic,copy)NSString *creator_face_uri; //创建者图像
@property(nonatomic,copy)NSString *creator_user_name; //创建者名字
@property(nonatomic,copy)NSString *bless_for_user_name; //患者姓名
@property(nonatomic,copy)NSString *bless_reason; //祈福原因
@property(nonatomic,copy)NSString *bless_username; //祈福人姓名
@property(nonatomic,copy)NSString *bless_stat_str; //祈福装填描述  eg  进行中  已完成等
@property(nonatomic,copy)NSString *date_show; //显示日期
@property(nonatomic,copy)NSString *pay_money; //钱数
@property(nonatomic,copy)NSString *bless_stat; //祈福状态码
@property(nonatomic,copy)NSString *bank_name; //银行名字
@property(nonatomic,copy)NSString *bank_card_number;//银行账户号
@property(nonatomic,copy)NSString *bank_card_user_name; //开户人

@property(nonatomic,strong)NSArray *bless_for_user_name_images; //身份材料
@property(nonatomic,strong)NSArray *bless_reason_images; //证明材料
@property(nonatomic,strong)NSArray *bless_reason_desc_more; //增补信息
@end

@interface OtherBlessListModel:NSObject
@property(nonatomic,copy)NSString *blessID;
@property(nonatomic,copy)NSString *name;
@end

@interface BlessDetailModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)BlessModel *bless;

@property(nonatomic,copy)NSString *bless_money_desc; //祈福钱描述
@property(nonatomic,copy)NSString *bless_type_chengnuo; //祈福承诺
@property(nonatomic,copy)NSString *bless_type_shenming; //祈福申明
@property(nonatomic,copy)NSString *free_product_ticket;  // 体验产品票
@property(nonatomic,strong)NSArray *bless_images_list;  //疾病证明 入院证明
@property(nonatomic,strong)NSArray *bless_reterence_list; //证明人数组
@property(nonatomic,strong)NSArray *bless_love_list; // scrollView 中 帮助过他的人
@property(nonatomic,strong)NSArray *other_bless_list; //其他祈福信息



@property(nonatomic,copy)NSString *name; //祈福名称
@property(nonatomic,copy)NSString *desc; //描述简介
@property(nonatomic,copy)NSString *image_uri;//祈福图像
@property(nonatomic,copy)NSString *bless_for_user_name_vi_name; //患者姓名
@property(nonatomic,copy)NSString *bless_reason_vi_name; //所患疾病
@property(nonatomic,copy)NSString *money; //钱

@property(nonatomic,copy)NSString *my_count_send_love; //我送出的爱心数量
@property(nonatomic,copy)NSString *my_can_send_love; //我可以送的爱心数量

@property(nonatomic,copy)NSString *share_title;
@property(nonatomic,copy)NSString *share_img;
@property(nonatomic,copy)NSString *share_desc;
@property(nonatomic,strong)UIImage *shareImage;

@end
