//
//  BabyHeaderView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BabyHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *mainTitleLabel;
@property(nonatomic,strong)UIImageView *hongSeLine;
@property(nonatomic,strong)UIImageView *huiseLine;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
