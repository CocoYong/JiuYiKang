//
//  JoinProjectCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JoinProjectCell.h"

@implementation JoinProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)setCellModel:(JoinCellModel *)cellModel
{
    if (self.selfIndexPath.row==0) {
        self.deletButton.hidden=YES;
    }else
    {
        self.deletButton.hidden=NO;
    }
    if (![cellModel.name isEqualToString:@""]) {
        self.nameTextField.text=cellModel.name;
    }
    if (![cellModel.relationName isEqualToString:@""]) {
        self.relationLabel.text=cellModel.relationName;
    }else
    {
        self.relationLabel.text=@"选择会员与您的关系";
    }
    if (![cellModel.codeNum isEqualToString:@""]) {
        self.certificatTextField.text=cellModel.codeNum;
    }
    if (![cellModel.taoCanName isEqualToString:@""]) {
        self.taoCanLabel.text=cellModel.taoCanName;
    }else
    {
        self.taoCanLabel.text=@"请选择充值套餐";
    }
    if (![self.relationLabel.text isEqualToString:@"选择会员与您的关系"]) {
        self.relationLabel.textColor=[UIColor blackColor];
    }else
    {
        self.relationLabel.textColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"];
    }
    if (![self.taoCanLabel.text isEqualToString:@"请选择充值套餐"]) {
        self.taoCanLabel.textColor=[UIColor blackColor];
    }else
    {
        self.taoCanLabel.textColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"];
    }
    if ([self.productID isEqualToString:@"1"]) {
        self.shenFenZhengLabel.text=@"出生证:";
    }
    _cellModel.name=self.nameTextField.text;
    _cellModel.codeNum=self.certificatTextField.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
