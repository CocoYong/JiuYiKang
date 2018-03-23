//
//  BlessDetailSectionHeaderView.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlessDetailSectionHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *redLineView;
@property(nonatomic,strong)UIImageView *lineImage;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
