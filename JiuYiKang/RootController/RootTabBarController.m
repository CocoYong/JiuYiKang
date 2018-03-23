//
//  TabBarViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "RootTabBarController.h"
#import "HelpEachOtherController.h"
#import "PublicController.h"
#import "InvitationController.h"
#import "BlessViewController.h"
#import "MineController.h"
#import "LoginViewController.h"
#define LABELCOLOE  [UtilitiesHelper colorWithHexString:@"#D72827"]
@interface RootTabBarController ()
@property(nonatomic,strong)NSArray *imageNames;
@property(nonatomic,strong)NSArray *selectImageNames;
@property(nonatomic,strong)NSArray *itemLabelTextArray;
@property (nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)UILabel *selectLabel;
//@property(nonatomic,strong)UINavigationController *navFour;
//@property(nonatomic,strong)UINavigationController *navFive;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden=YES;
    [self setUpAllChildViewController];
    [self _initTabBarView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}
//自定义标签栏
- (void)_initTabBarView {
//    float height = IOS7_OR_LATER ? SCREENHEIGHT : SCREENHEIGHT - 20;
    //1.创建标签栏
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 49, SCREENWIDTH,49)];
    _tabBarView.backgroundColor = [UtilitiesHelper colorWithHexString:@"#F9F9F9"];
    [self.view addSubview:_tabBarView];
 
    
    _imageNames = @[@"tabbar-1",@"tabbar-5",@"tabbar-2",@"tabbar-3",@"tabbar-4"];
    _selectImageNames = @[@"tabbar01_hover",@"tabbar05_hover",@"tabbar02_hover",@"tabbar03_hover",@"tabbar04_hover"];
    _itemLabelTextArray=@[@"互助计划",@"发起祈福",@"公示",@"邀请",@"我的"];
    for (int i = 0; i < _imageNames.count; i++) {
        //创建按钮
        CGRect frame = CGRectMake(i * (SCREENWIDTH / _imageNames.count), 0, SCREENWIDTH / _imageNames.count, 49);
        
        
        UIButton *tabBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        tabBarItem.frame = frame;
        tabBarItem.tag = i + 10;
        tabBarItem.imageEdgeInsets=UIEdgeInsetsMake(-10, 0, 5, 0);
        [tabBarItem setImage:[UIImage imageNamed:_imageNames[i]] forState:UIControlStateNormal];
        [tabBarItem setImage:[UIImage imageNamed:_selectImageNames[i]] forState:UIControlStateSelected];
        [tabBarItem addTarget:self action:@selector(tabBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:tabBarItem];
        
        UILabel *itemLabel=[[UILabel alloc]initWithFrame:CGRectMake(i * (SCREENWIDTH / _imageNames.count), 29, SCREENWIDTH / _imageNames.count, 21)];
        itemLabel.textAlignment=NSTextAlignmentCenter;
        itemLabel.textColor=[UIColor blackColor];
        itemLabel.tag=50+i;
        itemLabel.font=[UIFont systemFontOfSize:14];
        itemLabel.text=[_itemLabelTextArray objectAtIndex:i];
        [_tabBarView addSubview:itemLabel];
        if (i == 0) {
            [tabBarItem setSelected:YES];
            _selectButton = tabBarItem;
            self.selectedIndex = i;
            _selectLabel=itemLabel;
            _selectLabel.textColor=LABELCOLOE;
        }
    }
}
#pragma mark - tabBarItemAction
- (void)tabBarItemAction:(UIButton *)tabBarItem
{
    if (tabBarItem.tag - 10==3||tabBarItem.tag-10==4) {
        if ([self checkLoginStat]) {
            UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
            [UIApplication sharedApplication].delegate.window.rootViewController=navcontroller;
        }
    }
    self.selectedIndex = tabBarItem.tag - 10;
    
    //关闭上次选中状态静态显示的按钮
    [_selectButton setSelected:NO];
    [tabBarItem setSelected:YES];
    _selectButton = tabBarItem;
    //修改上次选择的按钮对应label的属性
    _selectLabel.textColor=[UIColor blackColor];
    _selectLabel=[self.tabBarView viewWithTag:tabBarItem.tag+40];
    _selectLabel.textColor=LABELCOLOE;
}
- (void)selectedTabNum:(int)sender
{
    int index = sender + 10;
    UIButton *button_ = (UIButton *)[self.tabBarView viewWithTag:index];
    [self tabBarItemAction:button_];
}

/**
 *  添加所有子控制器方法
 */
- (void)setUpAllChildViewController{
    
    // 1.添加第一个控制器
    HelpEachOtherController *oneVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"HelpEachOtherController"];
    UINavigationController *navOne = [[UINavigationController alloc]initWithRootViewController:oneVC];
       
 
    // 2.添加第2个控制器
    BlessViewController *twoVC = [[UIStoryboard storyboardWithName:@"Bless" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"BlessViewController"];
    UINavigationController *navTwo = [[UINavigationController alloc]initWithRootViewController:twoVC];
    
    
    // 3.添加第3个控制器
    PublicController *threeVC =[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PublicController"];
    UINavigationController *navThree = [[UINavigationController alloc]initWithRootViewController:threeVC];

    
    // 4.添加第4个控制器
    InvitationController *fourVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"InvitationController"];
    UINavigationController *navFour = [[UINavigationController alloc]initWithRootViewController:fourVC];
  
    
    // 5.添加第5个控制器
    MineController *fiveVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MineController"];
    UINavigationController *navFive = [[UINavigationController alloc]initWithRootViewController:fiveVC];
    self.viewControllers=@[navOne,navTwo,navThree,navFour,navFive];
}

-(BOOL)checkLoginStat
{
    if ((MYGETNSUSERDEFAULTSDEFINE(@"token")==nil||[MYGETNSUSERDEFAULTSDEFINE(@"token") isEqualToString:@""]))
    {
        return YES;
    }
    return NO;
}

@end
