//
//  QuestionHeaderView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "QuestionHeaderView.h"

@implementation QuestionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
        _hongseImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 5, 20)];
        _hongseImageView.image=[UIImage imageNamed:@"icon_titda"];
        [self addSubview:_hongseImageView];
        
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 13, 300, 23)];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
        _titleLabel.textColor=[UIColor redColor];
        [self addSubview:_titleLabel];
        
//        _huiseXianIamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 49, SCREENWIDTH, 1)];
//        _huiseXianIamgeView.image=[UIImage imageNamed:@"huisexian"];
//        [self addSubview:_huiseXianIamgeView];
        
        
        _huiseTiaoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 10)];
        _huiseTiaoImageView.image=[UIImage imageNamed:@"huisetiao"];
        [self addSubview:_huiseTiaoImageView];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
