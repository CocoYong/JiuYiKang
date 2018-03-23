//
//  QuestionCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.webView.scrollView.scrollEnabled=NO;
}
- (IBAction)expandButtAction:(UIButton *)sender {
    if (self.indexpath.section==0) {
        self.introModel.expand=!self.introModel.expand;
        if (self.introModel.expand) {
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
            //        self.detaillabel.frame=CGRectMake(10, 51, SCREENWIDTH-20, self.introModel.expandHeight-61);
            self.introModel.expandHeight=CGRectGetHeight(self.webView.frame)+61;
            self.webView.frame=self.webViewFrame;
        }else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_2"] forState:UIControlStateNormal];
            self.webView.frame=CGRectMake(0, 0, 0, 0);
        }
    }else
    {
        self.clauseModel.expand=!self.clauseModel.expand;
        if (self.clauseModel.expand) {
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
            //        self.detaillabel.frame=CGRectMake(10, 51, SCREENWIDTH-20, self.introModel.expandHeight-61);
            self.webView.frame=self.webViewFrame;
            self.clauseModel.expandHeight=CGRectGetHeight(self.webView.frame)+61;
            
        }else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_2"] forState:UIControlStateNormal];
            //        self.detaillabel.frame=CGRectMake(0, 0, 0, 0);
            self.webView.frame=CGRectMake(0, 0, 0, 0);
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
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
