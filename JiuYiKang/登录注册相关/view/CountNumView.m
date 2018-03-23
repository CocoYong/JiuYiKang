//
//  CountNumView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/4.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "CountNumView.h"
@interface CountNumView()
{
    NSInteger countNum;
}
@property(nonatomic,copy)TimerCountBack callBackBlock;
@end
@implementation CountNumView
-(instancetype)initWithFrame:(CGRect)frame andCallBack:(TimerCountBack)callBlock
{
    self=[super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    countNum=60;
    _showLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _showLabel.textAlignment=NSTextAlignmentCenter;
    _showLabel.textColor=[UIColor redColor];
    _showLabel.font=[UIFont systemFontOfSize:17];
    _showLabel.layer.borderWidth=0.5;
    _showLabel.layer.cornerRadius=5;
    _showLabel.layer.borderColor=[UIColor redColor].CGColor;
    _showLabel.hidden=YES;
    [self addSubview:_showLabel];
    
    _clickButt=[UIButton buttonWithType:UIButtonTypeCustom];
    _clickButt.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_clickButt setTitle:@"获取验证码" forState:UIControlStateNormal];
    _clickButt.layer.borderWidth=0.5;
    _clickButt.layer.cornerRadius=5;
    _clickButt.layer.borderColor=[UIColor redColor].CGColor;
    _clickButt.titleLabel.font=[UIFont systemFontOfSize:14];
    [_clickButt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_clickButt addTarget:self action:@selector(showCountNumLabel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_clickButt];
    
    self.callBackBlock = callBlock;
    return self;
}
-(void)showCountNumLabel:(UIButton*)butt
{
    self.callBackBlock(self.showLabel,self.clickButt);
}
-(void)creatAndStartTimer
{
    _timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(changeCountNum) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)changeCountNum
{
    self.clickButt.hidden=YES;
    self.showLabel.hidden=NO;
    countNum--;
    self.showLabel.text=[NSString stringWithFormat:@"%ldS",countNum];
    if (countNum==0) {
        [_timer invalidate];
        _timer=nil;
        countNum=60;
        self.clickButt.hidden=NO;
        self.showLabel.hidden=YES;
    }
}
@end
