//
//  BaseViewController.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
-(void)creatBackNavigationItem;
-(UIBarButtonItem*)createRightNavigationItem:(UIImage*)imageName andAction:(SEL)selector;
-(void)backToFrontViewContrller;
-(void)changeApplicationRootViewController;
-(BOOL)judgeLoginStatus;
@end
