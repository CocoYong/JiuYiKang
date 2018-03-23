//
//  BlessDetailCell.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessDetailCell.h"
#import "BlessDetailModel.h"
#import "UIImageView+WebCache.h"
@implementation BlessDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.referencePhotoImageView.clipsToBounds=YES;
    self.referencePhotoImageView.layer.cornerRadius=40;
    
    
    self.photoImageView.clipsToBounds=YES;
    self.photoImageView.layer.cornerRadius=20;
    
    self.typeBgView.layer.cornerRadius=11;
    self.statusBgView.layer.cornerRadius=11;
    self.borderBgView.layer.borderWidth=1;
    self.borderBgView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#EBECED"].CGColor;
    
    self.stateBgView.layer.cornerRadius=5;
    self.stateBgView.clipsToBounds=YES;
    self.stateBgView.layer.borderWidth=1;
    self.stateBgView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#82DAA3"].CGColor;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
