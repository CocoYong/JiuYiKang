//
//  MineTableViewCellOne.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineTableViewCellOne.h"

@implementation MineTableViewCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.location isEqualToString:@"right"]) {
        self.trailingWidth.constant=10;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
