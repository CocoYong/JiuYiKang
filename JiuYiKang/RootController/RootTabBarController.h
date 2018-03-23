//
//  TabBarViewController.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController
@property(nonatomic,strong)UIView *tabBarView;
@property(nonatomic,strong)UIImageView *selectImageView;
- (void)selectedTabNum:(int)sender;
@end
