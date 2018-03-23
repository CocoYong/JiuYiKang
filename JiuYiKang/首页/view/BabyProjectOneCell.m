//
//  BabyProjectOneCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BabyProjectOneCell.h"

@implementation BabyProjectOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.detaillabel.hidden=YES;
    self.webView.scrollView.scrollEnabled=NO;
}
- (IBAction)expandButtAction:(UIButton *)sender {
     sender.selected=!sender.selected;
     self.helpModel.expand=!self.helpModel.expand;
        if (self.helpModel.expand) {
//            self.detaillabel.frame=CGRectMake(10, 51, SCREENWIDTH-20, self.helpModel.expandHeight-61);
            self.webView.frame=self.webViewFrame;
            self.helpModel.expandHeight=CGRectGetHeight(self.webView.frame)+61;
        }else
        {
//            self.detaillabel.frame=CGRectMake(0, 0, 0, 0);
            self.webView.frame=CGRectMake(0, 0, 0, 0);
        }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshBabyControler" object:nil];
    //    self.reloadBlock();//不靠谱   有时候会出问题。。。要好好研究下。。。。
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
