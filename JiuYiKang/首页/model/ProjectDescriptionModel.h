//
//  ProjectDescriptionModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/21.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ArticleJoinModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *creat_time;
@property(nonatomic,copy)NSString *articleID;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *name_sub;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *product_name;
@property(nonatomic,copy)NSString *short_desc;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@end
@interface JoinItemModel : NSObject
@property(nonatomic,copy)NSString *detail_content;
@property(nonatomic,copy)NSString *name;
@end

@interface ProjectDescriptionModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)ArticleJoinModel *articleModel;
@property(nonatomic,copy)NSString *modelID;
@property(nonatomic,strong)NSArray *joinItemList;
@property(nonatomic,strong)NSNumber *with_footer_nav;
@end
