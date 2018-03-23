//
//  MineTableViewCellOne.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCellOne : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property(strong,nonatomic) NSString *location;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingWidth;

@end
