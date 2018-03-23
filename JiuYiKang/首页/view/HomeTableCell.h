//
//  HomeTableCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/14.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuoMIngLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@end
