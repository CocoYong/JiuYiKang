//
//  PublicDetailTwoCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicDetailTwoCell.h"

@implementation PublicDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
//    [self addObserver:self forKeyPath:@"self.radioImageView.hidden" options:NSKeyValueObservingOptionNew context:nil];
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if (self.radioImageView.hidden) {
//        self.detailLabel.frame=CGRectMake(10, 10, SCREENWIDTH-20, self.detailLabel.frame.size.height);
//        [self layoutSubviews];
//    }
//}
-(void)layoutSubviews
{
    if (self.radioImageView.hidden) {
        self.detailLabel.frame=CGRectMake(10, 10, SCREENWIDTH-20, self.detailLabel.frame.size.height);
        [self layoutIfNeeded];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
