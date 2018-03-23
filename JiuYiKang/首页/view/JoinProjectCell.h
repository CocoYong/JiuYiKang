//
//  JoinProjectCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinCellModel.h"
@interface JoinProjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *deletButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *certificatTextField;
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
@property (weak, nonatomic) IBOutlet UILabel *taoCanLabel;
@property (weak, nonatomic) IBOutlet UILabel *shenFenZhengLabel;


@property (weak, nonatomic) IBOutlet UIButton *relationButton;
@property (weak, nonatomic) IBOutlet UIButton *taoCanButton;

@property(nonatomic,strong) JoinCellModel *cellModel;
@property(nonatomic,strong)NSIndexPath *selfIndexPath;
@property(nonatomic,copy)NSString *productID;
@end
