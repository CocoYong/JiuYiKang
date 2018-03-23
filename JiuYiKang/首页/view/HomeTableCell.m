//
//  HomeTableCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/14.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//没用到咔咔
static inline  NSString *HomeItemsImageNamed(NSInteger itemsIndex){
    //静态列表数据
    NSArray *imageArray=@[@"pro_pic1",@"pro_pic2",@"pro_pic3"];
    return [imageArray objectAtIndex:itemsIndex];
}
static inline  NSString *HomeItemsTitleNamed(NSInteger itemsIndex){
    //静态列表数据
    NSArray *titleArray=@[@"宝宝计划",@"银丝计划",@"大病互助"];
    return [titleArray objectAtIndex:itemsIndex];
}
static inline  NSString *HomeItemsSecondTitleNamed(NSInteger itemsIndex){
    //静态列表数据
    NSArray *secondTitle=@[@"帮助天下父母照看您的孩子",@"帮助天下子女照顾您的父母",@"我助人人，人人助我"];
    return [secondTitle objectAtIndex:itemsIndex];
}
static inline  NSString *HomeItemsShuoMingNamed(NSInteger itemsIndex){
    //静态列表数据
    NSArray *imageArray=@[@"从怀孕起~孩子3岁",@"51~65岁",@"18~50岁"];
    return [imageArray objectAtIndex:itemsIndex];
}
//static inline NSString *orderDetailStatus(NSString *statusString){
//    NSDictionary *statusDic=@{@"pending":@"待付款",@"starting":@"付款成功",@"finish":@"等待确认",@"signin":@"交易成功"};
//    return  [statusDic objectForKey:statusString];
//}
@end
