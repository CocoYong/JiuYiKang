//
//  BlessListCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/13.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlessListModel.h"
@interface BlessListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIImageView *successImageView;


//mineBlessProperty

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *statusLabelBgView;
@property (weak, nonatomic) IBOutlet UIImageView *mineBlessImageView;
@property (weak, nonatomic) IBOutlet UILabel *mineBlessTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mineBlessStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *mineBlessDescLabel;






-(void)configeCellData:(BlessSmallModel*)samllModel;
@end
