//
//  BlessListCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/13.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessListCell.h"
#import "UIImageView+WebCache.h"
@implementation BlessListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderWidth=0.5;
    self.bgView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#EEEEEE"].CGColor;
    self.mineBlessStateLabel.layer.cornerRadius=5;
    
    self.statusLabelBgView.layer.cornerRadius=11;
    self.statusLabelBgView.clipsToBounds=YES;
}
-(void)configeCellData:(BlessSmallModel *)samllModel
{
    NSString *imageUrlString=[NSString stringWithFormat:@"%@%@",KBaseURL,samllModel.face_uri];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"qf_pic3"] options:SDWebImageRetryFailed];
    self.nameLabel.text=samllModel.name;
    self.descLabel.text=samllModel.desc;
    self.starLabel.text=[NSString stringWithFormat:@"%@颗",samllModel.count_bless_love];
    if ([samllModel.bless_stat integerValue]==40) {
        self.successImageView.hidden=NO;
    }else
    {
        self.successImageView.hidden=YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
