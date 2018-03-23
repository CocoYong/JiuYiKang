//
//  PublicHeaderFooterView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/7.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicHeaderFooterView : UITableViewHeaderFooterView
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *nameLabel;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
