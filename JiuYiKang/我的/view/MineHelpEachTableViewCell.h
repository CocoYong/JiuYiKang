//
//  MineHelpEachTableViewCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHelpOtherModel.h"
@interface MineHelpEachTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taocanLabel;

@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UIButton *chargeButton;
@property (weak, nonatomic) IBOutlet UIView *nameBackView;
@property (weak, nonatomic) IBOutlet UIButton *protectCardButt;

@property(nonatomic,strong) MyHelpOtherListModel *itemModel;
@end
