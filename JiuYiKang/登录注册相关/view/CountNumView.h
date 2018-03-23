//
//  CountNumView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/4.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TimerCountBack) (UILabel *textLabel,UIButton *butt);
@interface CountNumView : UIView
@property(nonatomic,strong)UILabel *showLabel;
@property(nonatomic,strong)UIButton *clickButt;
@property(nonatomic,strong)NSTimer *timer;
-(instancetype)initWithFrame:(CGRect)frame andCallBack:(TimerCountBack)callBlock;
-(void)creatAndStartTimer;
@end
