//
//  CommonQuestionModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "CommonQuestionModel.h"
#import "UILabel+Universal.h"
@implementation CommonQuestionModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"huzhuIntroArray":@"data.qa_options.互助介绍",
             @"huzhuClauseArray":@"data.qa_options.互助规则"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"huzhuIntroArray":[HuZhuIntroModel class],
             @"huzhuClauseArray":[HuZhuClauseModel class]};
}

@end

@implementation HuZhuIntroModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"huzhuId":@"id"};
}
-(void)setDetail_content:(NSString *)detail_content
{
    _detail_content=detail_content;
    self.normalHeight=50;
}
@end

@implementation HuZhuClauseModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"clauseId":@"id"};
}
-(void)setDetail_content:(NSString *)detail_content
{
    _detail_content=detail_content;
    self.normalHeight=50;
}
@end
