//
//  PublicCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicCell.h"
@implementation PublicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
- (IBAction)expandButtAction:(UIButton *)sender {
    self.model.expand=!self.model.expand;
    if (self.model.expand) {
        sender.selected=YES;
        self.detailLabel.frame=CGRectMake(10, 51, SCREENWIDTH-20, self.model.expandHeight-178);
    }else
    {
        sender.selected=NO;
        self.detailLabel.frame=CGRectMake(0, 0, 0, 0);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshPublishTable" object:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
