//
//  MessageCenterCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UIButton *deletMessageButt;

@end
