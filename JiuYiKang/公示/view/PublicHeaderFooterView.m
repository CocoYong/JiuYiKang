//
//  PublicHeaderFooterView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/7.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicHeaderFooterView.h"

@implementation PublicHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        _bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        imageView.image=[UIImage imageNamed:@"huisetiao"];
        [_bgView addSubview:imageView];
        
        UIImageView *honseImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 5, 20)];
        honseImageView.image=[UIImage imageNamed:@"icon_titda"];
        [_bgView addSubview:honseImageView];

        
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 150, 21)];
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.textAlignment=NSTextAlignmentLeft;
        _nameLabel.font=[UIFont boldSystemFontOfSize:18];
        [_bgView addSubview:_nameLabel];
        
        
//        UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 49, SCREENWIDTH, 1)];
//        lineImageView.image=[UIImage imageNamed:@"huisexian"];
//        [_bgView addSubview:lineImageView];

    }
    return self;
}
@end
