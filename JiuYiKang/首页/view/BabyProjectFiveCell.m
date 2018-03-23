//
//  BabyProjectFiveCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/21.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BabyProjectFiveCell.h"

@implementation BabyProjectFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.detaillabel.hidden=YES;
    self.webView.scrollView.scrollEnabled=NO;
}
- (IBAction)expandButtAction:(UIButton *)sender {
    sender.selected=!sender.selected;
    self.commonModel.expand=!self.commonModel.expand;
    if (self.commonModel.expand) {
//        self.detaillabel.frame=CGRectMake(10, 51, SCREENWIDTH-20, self.commonModel.expandHeight-61);
        self.webView.frame=self.webViewFrame;
        self.commonModel.expandHeight=CGRectGetHeight(self.webView.frame)+61;
    }else
    {
//        self.detaillabel.frame=CGRectMake(0, 0, 0, 0);
        self.webView.frame=CGRectMake(0, 0, 0, 0);

    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshBabyControler" object:nil];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize fittingSize=[webView sizeThatFits:CGSizeZero];
    webView.frame=CGRectMake(10, 51, fittingSize.width, fittingSize.height);
    self.webViewFrame=webView.frame;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
