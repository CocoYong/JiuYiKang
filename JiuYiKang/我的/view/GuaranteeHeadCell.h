//
//  GuaranteeHeadCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHelpOtherModel.h"
@interface GuaranteeHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *voucherNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxGetMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *protectManLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *joinTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouYiRenLabel;
@property (weak, nonatomic) IBOutlet UILabel *guanXiLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *gongYueButt;
@property (weak, nonatomic) IBOutlet UIButton *tiaoKuanButt;
@property (weak, nonatomic) IBOutlet UIButton *shangCanButt;
@property (weak, nonatomic) IBOutlet UIButton *moneyBalanceButt;
@property(nonatomic,strong) MyHelpOtherListModel *tempModel;
@end
