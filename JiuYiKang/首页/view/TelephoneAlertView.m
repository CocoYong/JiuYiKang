//
//  TelephoneAlertView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/6.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "TelephoneAlertView.h"

@implementation TelephoneAlertView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.dialogView.layer.cornerRadius=5.0;
}
+(instancetype)telephoneView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TelephoneAlertView" owner:nil options:nil] objectAtIndex:0];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
    }
    return self;
}
- (IBAction)sureButtAction:(UIButton *)sender {
    
    self.clickBlock(sender);
    [self  removeFromSuperview];
}
- (IBAction)cancelButtAction:(UIButton *)sender {
    self.clickBlock(sender);
    [self removeFromSuperview];
}

@end
