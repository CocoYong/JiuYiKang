//
//  BeginUpdateModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/27.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BeginUpdateModel.h"
#import "BeginBlessModel.h"
@implementation BeginUpdateModel
-(NSMutableArray *)photoModelArray
{
    if (_photoModelArray==nil) {
        _photoModelArray=[NSMutableArray arrayWithCapacity:10];
    }
    return _photoModelArray;
}
-(BOOL)chechInfomationIsOK
{
    if ([[self checkPropertyIsEmpty] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
-(NSString*)checkPropertyIsEmpty
{
    if (self.name==nil||[self.name isEqualToString:@""]) {
        return  @"标题不能为空";
    }
    if (self.bless_username==nil||[self.bless_username isEqualToString:@""]) {
        return  @"祈福人姓名不能为空";
    }
    if (self.desc==nil||[self.desc isEqualToString:@""]) {
        return  @"描述不能为空";
    }
    if (self.bless_days==nil||[self.bless_days isEqualToString:@""]) {
        return  @"请选择爱心时长";
    }
    if (self.bank_name==nil||[self.bank_name isEqualToString:@""]) {
        return  @"请填写开户银行";
    }
    if (self.bank_card_number==nil||[self.bank_card_number isEqualToString:@""]) {
        return  @"请填写开户行账户";
    }if (self.bank_card_user_name==nil||[self.bank_card_user_name isEqualToString:@""]) {
        return  @"请填写开户行姓名";
    }
    if (self.bank_card_user_mobile==nil||[self.bank_card_user_mobile isEqualToString:@""]) {
        return  @"请填写手机号";
    }
    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.bank_card_user_mobile]) {
        return  @"手机号格式填写有误";
    }
    if (self.bank_card_user_relative==nil||[self.bank_card_user_relative isEqualToString:@""]) {
        return  @"请选择收款人身份";
    }
    for (BlessTypeImageModel *model in self.photoModelArray){
        if (model.imageUri==nil) {
            return [NSString stringWithFormat:@"%@未上传",model.name];
        }
    }
    return @"";
}
@end
