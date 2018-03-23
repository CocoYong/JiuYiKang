//
//  PublicListModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicListModel.h"
#import "UILabel+Universal.h"
@implementation PublicListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"public_list":@"data.public_list",
             @"detail_content":@"data.detail_content"
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"public_list":[PublicDataModel class]};
}
@end

@implementation PublicDataModel
-(void)setShort_des:(NSString *)short_des
{
    _short_des=short_des;
    self.expandHeight=[UILabel calculateLabelHeightWithContent:short_des andFontSize:DETAILFONTSIZE andRectSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX)]+178;
    self.normalHeight=158;
    NSLog(@"expandHeight====%f,normalHeight====%f",self.expandHeight,self.normalHeight);
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"publicID":@"id"};
}
@end
