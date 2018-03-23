//
//  BabyHeaderView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BabyHeaderView.h"

@implementation BabyHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        _mainTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 21)];
        _mainTitleLabel.font=[UIFont boldSystemFontOfSize:17];
        _mainTitleLabel.textAlignment=NSTextAlignmentLeft;
        [self addSubview:_mainTitleLabel];
        
        _hongSeLine=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 104, 2)];
        _hongSeLine.image=[UIImage imageNamed:@"hongsexian"];
        [self addSubview:_hongSeLine];
        
        _huiseLine=[[UIImageView alloc]initWithFrame:CGRectMake(10, 42, SCREENWIDTH-10, 1)];
        _huiseLine.image=[UIImage imageNamed:@"huisexian"];
        [self addSubview:_huiseLine];
    }
    return  self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
