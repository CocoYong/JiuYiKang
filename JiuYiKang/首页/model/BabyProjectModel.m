//
//  BabyProjectModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BabyProjectModel.h"
#import "UILabel+Universal.h"
@implementation BabyProjectModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"fast_qa_list":[FastQList class],
             @"product_rule_list":[RuleListModel class]};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"fast_qa_list":@"data.fast_qa_list",
             @"product_rule_list":@"data.product_rule_list",
             @"product":@"data.product"};
}
@end
@implementation Product
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"projectID":@"id"};
}
-(void)setList_image:(NSString *)list_image
{
    if ([list_image containsString:@"\\"]) {
        _list_image=[list_image stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }else
    {
        _list_image=list_image;
    }
}
-(void)setDetail_image_top:(NSString *)detail_image_top
{
    if ([detail_image_top containsString:@"\\"]) {
        _detail_image_top=[detail_image_top stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }else
    {
        _detail_image_top=detail_image_top;
    }
}
-(void)setDetail_image_about:(NSString *)detail_image_about
{
    if ([detail_image_about containsString:@"\\"]) {
        _detail_image_about=[detail_image_about stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }else
    {
        _detail_image_about=detail_image_about;
    }
}
-(void)setDetail_image_service:(NSString *)detail_image_service
{
    if ([detail_image_service containsString:@"\\"]) {
     _detail_image_service=[detail_image_service stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    }else
    {
        _detail_image_service=detail_image_service;
    }
}
@end
@implementation RuleListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ruleID":@"id"};
}
-(void)setDetail_content:(NSString *)detail_content
{
    _detail_content=detail_content;
    self.normalHeight=50;
}
@end

@implementation FastQList
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"questionID":@"id"};
}
-(void)setDetail_content:(NSString *)detail_content
{
    _detail_content=detail_content;
    self.normalHeight=50;
}
@end
