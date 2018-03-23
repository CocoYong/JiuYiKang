//
//  AllRechargeCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AllRechargeCell.h"

@implementation AllRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.bgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth=0.5;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
