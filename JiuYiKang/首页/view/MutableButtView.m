//
//  MutableButtView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MutableButtView.h"
@interface MutableButtView()
@property(nonatomic,strong)UIImage *normalIamge;
@property(nonatomic,strong)UIImage *selectedIamge;
@end
@implementation MutableButtView
-(instancetype)initWithFrame:(CGRect)frame andButtonTitleArray:(NSArray *)titleArray andButtSelectColor:(UIColor *)selectColor andButtNormalColor:(UIColor *)normalColor andNormalImage:(UIImage*)nromalImage andSelectedIamge:(UIImage*)selectedIamge andButtCount:(NSInteger)buttNum
{
    if (self=[super initWithFrame:frame]) {
        CGFloat buttWidth=frame.size.width/buttNum;
        for (int i=0; i<buttNum; i++) {
            UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
            butt.frame=CGRectMake(i*buttWidth, 0, buttWidth, frame.size.height-3);
            [butt setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [butt setTitleColor:normalColor forState:UIControlStateNormal];
            [butt setTitleColor:selectColor forState:UIControlStateSelected];
            [butt addTarget:self action:@selector(buttClicked:) forControlEvents:UIControlEventTouchUpInside];
            butt.tag=i+10;
            [self addSubview:butt];
            
            self.normalIamge=nromalImage;
            self.selectedIamge=selectedIamge;
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*buttWidth, self.frame.size.height-3, buttWidth, 2)];
            imageView.tag=i+50;
            imageView.image=nromalImage;
            [self addSubview:imageView];
            
            UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
            lineView.backgroundColor=[UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    return self;
}
-(void)buttClicked:(UIButton*)butt
{
    butt.selected=YES;
    for (UIView *view in self.subviews) {
        if ([view isMemberOfClass:[UIButton class]]&&view.tag!=butt.tag) {
            UIButton *tempButt=(UIButton*)view;
            tempButt.selected=NO;
        }
        if ([view isMemberOfClass:[UIImageView class]]) {
            UIImageView *imageView=(UIImageView*)view;
            if (view.tag==butt.tag+40) {
                imageView.image=self.selectedIamge;
            }else
            {
                imageView.image=self.normalIamge;
            }
        }
    }
    self.buttBlock(butt, butt.tag-10);
}
-(void)setSelectButtIndex:(NSInteger)selectButtIndex
{
    for (UIView *view in self.subviews) {
        if ([view isMemberOfClass:[UIButton class]]&&view.tag-10==selectButtIndex) {
            UIButton *tempButt=(UIButton*)view;
            tempButt.selected=YES;
        }
        if ([view isMemberOfClass:[UIImageView class]]&&view.tag-50==selectButtIndex) {
            UIImageView *imageView=(UIImageView*)view;
                imageView.image=self.selectedIamge;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
