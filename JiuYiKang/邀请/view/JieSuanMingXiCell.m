//
//  JieSuanMingXiCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/12.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JieSuanMingXiCell.h"

@implementation JieSuanMingXiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
