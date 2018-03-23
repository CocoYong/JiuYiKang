//
//  AddReferenceModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/28.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AddReferenceModel.h"

@implementation AddReferenceModel
-(BOOL)chechInfomationIsOK
{
    if ([[self checkPropertyIsEmpty] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
-(NSString*)checkPropertyIsEmpty
{
    if (self.user_name==nil||[self.user_name isEqualToString:@""]) {
        return  @"证明人姓名不能为空";
    }
    if (self.desc==nil||[self.desc isEqualToString:@""]) {
        return  @"请填写证明描述";
    }
    if (self.user_mobile==nil||[self.user_mobile isEqualToString:@""]) {
        return  @"手机号需要填写";
    }
    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.user_mobile]) {
        return  @"手机号格式填写有误";
    }
    if (self.user_relative==nil||[self.user_relative isEqualToString:@""]) {
        return  @"选择证明人和您的关系";
    }
    if (self.face_uri==nil||[self.face_uri isEqualToString:@""]) {
        return  @"证明人图像还没选";
    }if (self.id_card_image==nil||[self.id_card_image isEqualToString:@""]) {
        return  @"请上传身份证图像";
    }
    return @"";
}

@end
