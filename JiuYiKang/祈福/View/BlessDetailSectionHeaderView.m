//
//  BlessDetailSectionHeaderView.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessDetailSectionHeaderView.h"

@implementation BlessDetailSectionHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithReuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    UIImageView *huiseTiaoView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    huiseTiaoView.image=[UIImage imageNamed:@"huisetiao"];
    [self addSubview:huiseTiaoView];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREENWIDTH, 22)];
    _titleLabel.font=[UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor=[UIColor darkGrayColor];
    [self addSubview:_titleLabel];
    CGSize  labelSize=[_titleLabel sizeThatFits:CGSizeMake(SCREENWIDTH, 22)];
    _titleLabel.frame=CGRectMake(10, 10, labelSize.width, 22);
    
    _lineImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+10, SCREENWIDTH-20, 1)];
    _lineImage.image=[UIImage imageNamed:@"huisexian"];
    [self addSubview:_lineImage];
    
    _redLineView=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+10, labelSize.width, 1)];
    _redLineView.backgroundColor=[UIColor redColor];
    [self addSubview:_redLineView];
    return self;
}

@end
