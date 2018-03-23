//
//  BaseViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"久益康";
    //设置导航条背景色为黑色是为了让状态栏的背景色也是黑色这样状态栏的文字就是白色了
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    //设置标题的颜色为白色
    NSDictionary *attibutsDic=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.navigationController.navigationBar.titleTextAttributes=attibutsDic;
    //关闭半透明的导航
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationController.navigationBar.barTintColor=[UtilitiesHelper colorWithHexString:@"#373B3E"];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarbg"] forBarMetrics:UIBarMetricsDefault];
    
}
-(void)creatBackNavigationItem
{
    UIButton *leftItem=[UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame=CGRectMake(0, 0, 20, 20);
    [leftItem setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(backToFrontViewContrller) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:leftItem];
    self.navigationItem.leftBarButtonItem=buttonItem;
}
-(void)backToFrontViewContrller
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIBarButtonItem*)createRightNavigationItem:(UIImage*)imageName andAction:(SEL)selector
{
    UIButton *rightItem=[UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame=CGRectMake(0, 0, 25, 25);
    [rightItem setImage:imageName forState:UIControlStateNormal];
    [rightItem addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:rightItem];
    return buttonItem;
}
-(BOOL)judgeLoginStatus
{
    if (MYGETNSUSERDEFAULTSDEFINE(@"token")==nil||[MYGETNSUSERDEFAULTSDEFINE(@"token") isEqualToString:@""]){
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
