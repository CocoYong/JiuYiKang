//
//  CommonQuestionModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuZhuIntroModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *detail_content;
@property(nonatomic,copy)NSString *group_name;
@property(nonatomic,copy)NSString *huzhuId;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;

@end

@interface HuZhuClauseModel : NSObject
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *detail_content;
@property(nonatomic,copy)NSString *group_name;
@property(nonatomic,copy)NSString *clauseId;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;
@end

@interface CommonQuestionModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSArray *huzhuIntroArray;
@property(nonatomic,strong)NSArray *huzhuClauseArray;
@end

