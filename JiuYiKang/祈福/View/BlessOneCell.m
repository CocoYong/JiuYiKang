//
//  BlessOneCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessOneCell.h"
#import "BeginBlessViewController.h"
#import "BeginBlessModel.h"
@implementation BlessOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self)  return nil;
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10,SCREENWIDTH-20, 22)];
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    titleLabel.text=@"证明材料";
    titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UILabel *descLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 42, SCREENWIDTH-20, 22)];
    descLabel.font=[UIFont systemFontOfSize:13];
    descLabel.text=@"上传真实图片更容易集到大家的爱心";
    descLabel.textColor=[UIColor darkGrayColor];
    [self addSubview:descLabel];
    self.frame=CGRectMake(0, 0, SCREENWIDTH, 74);
    self.selectionStyle=UITableViewCellSeparatorStyleNone;
    return self;
}
-(void)showImageWithBrower:(UIButton*)butt
{
    [self.parentController  iamgeButtClicked:butt];
}
-(void)setDataArray:(NSArray *)dataArray
{
    //材料view背景view
    UIView *bgOneView=[[UIView alloc]init];
    CGFloat buttWidth=(SCREENWIDTH-50)/4;
    NSInteger rowNum=floor((dataArray.count-1)/4)+1;
    if (dataArray.count!=0) {
        for (int i=0; i<rowNum; i++) {
            NSInteger tempMark;
            if (i==rowNum-1) {
                tempMark=dataArray.count-(rowNum-1)*4;
            }else
            {
                tempMark=4;
            }
            for (int j=0; j<tempMark; j++) {
                //imageView
                //                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i, buttWidth, buttWidth)];
                //                imageView.tag=(i*4+j)+600;
                //                imageView.image=[UIImage imageNamed:@"icon_xj"];
                
                UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
                butt.frame=CGRectMake(((buttWidth+10)*j)+10, (buttWidth+50)*i, buttWidth, buttWidth);
                BlessTypeImageModel *listModel=[dataArray objectAtIndex:i*4+j];
                [butt setBackgroundColor:[UtilitiesHelper colorWithHexString:@"#ECF6FD"]];
                
                [butt setImage:[UIImage imageNamed:@"icon_xj"] forState:UIControlStateNormal];
                if (listModel.cutImage!=nil) {
                    [butt setImage:listModel.cutImage forState:UIControlStateNormal];
                }
                if (listModel.cutImage!=nil) {
                 [butt setImage:listModel.cutImage forState:UIControlStateNormal];
                }
                butt.tag=(i*4+j)+400;
                [butt addTarget:self action:@selector(showImageWithBrower:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *imageTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+50)*i+buttWidth+10, buttWidth, 20)];
                imageTitleLabel.text=listModel.name;
                imageTitleLabel.tag=(i*4+j)+500;
                imageTitleLabel.font=[UIFont systemFontOfSize:13];
                imageTitleLabel.textAlignment=NSTextAlignmentCenter;
                [bgOneView addSubview:butt];
                [bgOneView addSubview:imageTitleLabel];
            }
        }
        bgOneView.frame=CGRectMake(0, 74, SCREENWIDTH, rowNum*(buttWidth+40)+10);
        self.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(bgOneView.frame));
        _height=CGRectGetMaxY(bgOneView.frame);
        [self addSubview:bgOneView];
    }
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
