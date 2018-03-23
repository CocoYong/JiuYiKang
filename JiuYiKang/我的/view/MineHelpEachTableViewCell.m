//
//  MineHelpEachTableViewCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineHelpEachTableViewCell.h"
#import "UIButton+AFNetworking.h"
@implementation MineHelpEachTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameBackView.layer.cornerRadius=10;
    self.nameBackView.backgroundColor=[UtilitiesHelper colorWithHexString:@"#EEF0F1"];
   
    self.nameLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#EEF0F1"];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)setItemModel:(MyHelpOtherListModel *)itemModel
{
    _itemModel=itemModel;
    self.nameLabel.text=itemModel.join_user_name;
    self.projectNameLabel.text=itemModel.product_name;
    self.taocanLabel.text=itemModel.product_vip_name;
    self.introductionLabel.text=itemModel.stat_and_money_tip;
    self.moneyLabel.text=[NSString stringWithFormat:@"￥%@",itemModel.money];
    switch ([itemModel.stat integerValue]) {
        case 0:
        case 1:
        case 2:
            self.statusImageView.image=[UIImage imageNamed:@"lvsestat"];
            break;
        case 3:
        case 4:
            self.statusImageView.image=[UIImage imageNamed:@"huisestat"];
            break;
        case 5:
            self.statusImageView.image=[UIImage imageNamed:@"huangsestat"];
            break;
        default:
            break;
    }
    [self.imageButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:itemModel.list_image relativeToURL:[NSURL URLWithString:KBaseURL]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
