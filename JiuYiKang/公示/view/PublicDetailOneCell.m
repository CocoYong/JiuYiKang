//
//  PublicDetailOneCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicDetailOneCell.h"

@implementation PublicDetailOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}
-(void)configeCellModel:(PublicDetailDataModel *)dataModel withIndexPath:(NSIndexPath *)indexpath
{
    switch (indexpath.row) {
        case 0:
            self.nameLabel.text=@"互助计划";
            self.detailLabel.text=dataModel.product_name;
            break;
        case 1:
            self.nameLabel.text=@"编号";
            self.detailLabel.text=dataModel.id_str;
            break;
        case 2:
            self.nameLabel.text=@"加入日期";
            self.detailLabel.text=dataModel.date_join;
            break;
        case 3:
            self.nameLabel.text=@"生效日期";
            self.detailLabel.text=dataModel.date_enabled;
            break;
        case 4:
            self.nameLabel.text=@"参与人数";
            self.detailLabel.text=dataModel.count_join;
            break;
        case 5:
            self.nameLabel.text=@"所需互助金";
            self.detailLabel.text=dataModel.money_need;
            break;
        case 6:
            self.nameLabel.text=@"公示日期";
            self.detailLabel.text=dataModel.date_public;
            break;
        case 7:
            self.nameLabel.text=@"划款日期";
            self.detailLabel.text=dataModel.date_money_collect;
            break;
        default:
            break;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//static inline NSString *orderDetailStatus(NSString *statusString){
//    NSDictionary *statusDic=@{@"pending":@"待付款",@"starting":@"付款成功",@"finish":@"等待确认",@"signin":@"交易成功"};
//    return  [statusDic objectForKey:statusString];
//}
@end
