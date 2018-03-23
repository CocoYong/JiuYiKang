//
//  GuaranteeHeadCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "GuaranteeHeadCell.h"
#import "NSDate+ZYAdditions.h"
@implementation GuaranteeHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
}
- (IBAction)expandPeopleCodeLabelContent:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected) {
//        [sender setTitle:@"展开" forState:UIControlStateNormal];
        self.peopleCodeLabel.text=@"*******";
    }else{
//        [sender setTitle:@"隐藏" forState:UIControlStateNormal];
      self.peopleCodeLabel.text=self.tempModel.user_id_card;
    }
}

-(void)setTempModel:(MyHelpOtherListModel *)tempModel
{
    _tempModel=tempModel;
    self.voucherNumLabel.text=tempModel.id_str;
    self.projectNameLabel.text=tempModel.product_name;
    self.maxGetMoneyLabel.text=tempModel.money_max;
    self.protectManLabel.text=tempModel.join_user_name;
    self.peopleCodeLabel.text=tempModel.user_id_card;
    self.joinTimeLabel.text=[NSDate dateWithOriginalString:tempModel.date_join_in andOriginalDateFormater:@"yyyy-MM-dd HH:mm:ss" newDateFormater:@"yyyy年MM月dd日"];
    self.shouYiRenLabel.text=@"法定继承人";
    self.guanXiLabel.text=tempModel.user_relation;
    self.moneyLabel.text=tempModel.money;
//    [self.stateImageView setImageWithURL:[NSURL URLWithString:tempModel.list_image relativeToURL:[NSURL URLWithString:KBaseURL]]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
