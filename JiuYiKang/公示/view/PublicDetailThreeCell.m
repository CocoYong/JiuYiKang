//
//  PublicDetailThreeCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/24.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicDetailThreeCell.h"

@implementation PublicDetailThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
-(void)createImageViewAndLabel
{
    CGFloat imageViewWidth=(SCREENWIDTH-40)/3;
    NSInteger rowNum=floor((self.fileModelArray.count-1)/3)+1;
    for (int i=0; i<rowNum; i++) {
        for (int j=0; j<3; j++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(((imageViewWidth+10)*j)+10, (imageViewWidth+40)*i+10, imageViewWidth, imageViewWidth)];
            PublicFileListModel *listModel=[self.fileModelArray objectAtIndex:i*3+j];
            [imageView setImageWithURL:[NSURL URLWithString:listModel.image_uri relativeToURL:[NSURL URLWithString:KBaseURL]]];
            UILabel *imageTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(imageViewWidth*j+10, (imageViewWidth+50)*i+imageViewWidth+20, imageViewWidth, 20)];
            imageTitleLabel.text=listModel.name;
            imageTitleLabel.textAlignment=NSTextAlignmentCenter;
            [self addSubview:imageView];
            [self addSubview:imageTitleLabel];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
