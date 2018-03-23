//
//  BabyProjectModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : NSObject
@property(nonatomic,copy)NSString *age_limite;
@property(nonatomic,copy)NSString *count_join;
@property(nonatomic,copy)NSString *count_join_3_days;
@property(nonatomic,copy)NSString *count_join_3_days_demo;
@property(nonatomic,copy)NSString *count_join_demo;
@property(nonatomic,copy)NSString *detail_image_about;//服务详情
@property(nonatomic,copy)NSString *detail_image_service;//服务保障
@property(nonatomic,copy)NSString *detail_image_top;//顶部图
@property(nonatomic,copy)NSString *projectID;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *list_image;
@property(nonatomic,copy)NSString *money_alert;
@property(nonatomic,copy)NSString *money_max;
@property(nonatomic,copy)NSString *money_normal;
@property(nonatomic,copy)NSString *money_tip;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,copy)NSString *to_des;
@end




@interface BabyProjectModel : NSObject
@property(nonatomic,copy)NSArray *helpOthersModelsArray;
@property(nonatomic,copy)NSArray *commonIssuesModelsArray;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)Product *product;
@property(nonatomic,strong)NSArray *fast_qa_list;
@property(nonatomic,strong)NSArray *product_rule_list;
@property(nonatomic,copy)NSString *msg;
@end




@interface RuleListModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *detail_content;
@property(nonatomic,copy)NSString *ruleID;
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;
@end

@interface FastQList : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *detail_content;
@property(nonatomic,copy)NSString *group_name;
@property(nonatomic,copy)NSString *questionID;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;
@end
