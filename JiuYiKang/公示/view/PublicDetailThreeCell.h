//
//  PublicDetailThreeCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/24.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDetailModel.h"
@interface PublicDetailThreeCell : UITableViewCell
@property(nonatomic,strong)NSArray *fileModelArray;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)createImageViewAndLabel;
@end
