//
//  BlessOneCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BeginBlessViewController;
@interface BlessOneCell : UITableViewCell
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)BeginBlessViewController *parentController;
-(instancetype)initWithFrame:(CGRect)frame;
@end
