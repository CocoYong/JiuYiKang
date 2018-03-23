//
//  PublicDetailOneCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDetailModel.h"
@interface PublicDetailOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *huiseXian;

-(void)configeCellModel:(PublicDetailDataModel*)dataModel withIndexPath:(NSIndexPath*)indexpath;
@end
