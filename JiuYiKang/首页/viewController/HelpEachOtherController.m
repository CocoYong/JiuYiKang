//
//  HelpEachOtherController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "HelpEachOtherController.h"
#import "HomeTableCell.h"
#import "MesssageCenterViewController.h"
#import "AllRechargeViewController.h"
#import "ForFamilyViewController.h"
#import "BabyProjectViewController.h"
#import "HelpOtherIntroduceController.h"
#import "RootTabBarController.h"
#import "HomeIndex.h"
#import "BlessListViewController.h"
#import "SDCycleScrollView.h"
#import "FirstViewController.h"
@interface HelpEachOtherController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
{
    NSArray *iconImageArray;
    NSArray *textArray;
    HomeIndex *homeModel;
}
@property (weak, nonatomic) IBOutlet UIView *tableHeadView;
@property(nonatomic,strong)SDCycleScrollView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *countNumLabel;

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@end

@implementation HelpEachOtherController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"互助计划";
    //导航右按钮
    self.navigationItem.rightBarButtonItem=[self createRightNavigationItem:[UIImage imageNamed:@"message"] andAction:@selector(rightNavigationItemClicked)];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (MYGETNSUSERDEFAULTSDEFINE(@"firstLaunch")==nil) {
        FirstViewController *firstController=[[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FirstViewController"];
        [self presentViewController:firstController animated:YES completion:nil];
    }
    TABBARCONTROLLER.tabBarView.hidden=NO;
    [self requestDataFromService];
    
}
#pragma mark
#pragma mark----试图定制
-(void)createScrollView
{
    NSMutableArray *imageArray=[NSMutableArray arrayWithCapacity:10];
    for (Bannsers *banner in homeModel.banners) {
        NSString *urlString=[NSString stringWithFormat:@"%@%@",KBaseURL,banner.image_uri];
        [imageArray addObject:urlString];
    }
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _headerView.currentPageDotImage = [UIImage imageNamed:@"point_1"];
    _headerView.pageDotImage = [UIImage imageNamed:@"point_2"];
    _headerView.imageURLStringsGroup = imageArray;
    [self.tableHeadView addSubview:self.headerView];
}
-(void)rightNavigationItemClicked
{
    if ([self judgeLoginStatus]) {
        UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
        [UIApplication sharedApplication].delegate.window.rootViewController=navcontroller;
    }else
    {
        MesssageCenterViewController *messagerCenterController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"MesssageCenterViewController"];
        TABBARCONTROLLER.tabBarView.hidden=YES;
        [self showViewController:messagerCenterController sender:nil];
    }
}
#pragma mark
#pragma mark  ----buttonAction
- (IBAction)fourButtonAction:(UIButton *)sender {
    
    if (sender.tag==111) {
        if ([self judgeLoginStatus]) {
            UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
            [UIApplication sharedApplication].delegate.window.rootViewController=navcontroller;
            
        }else
        {
            AllRechargeViewController *allRechargeController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"AllRechargeViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:allRechargeController sender:nil];
        }
    }else if (sender.tag==222)
    {
        ForFamilyViewController *forFamilyController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ForFamilyViewController"];
        TABBARCONTROLLER.tabBarView.hidden=YES;
        [self showViewController:forFamilyController sender:nil];
    }else if (sender.tag==333)
    {
        BlessListViewController *blessListController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"BlessListViewController"];
        TABBARCONTROLLER.tabBarView.hidden=YES;
        [self showViewController:blessListController sender:nil];
    }else
    {
        HelpOtherIntroduceController *helpOtherController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"HelpOtherIntroduceController"];
        TABBARCONTROLLER.tabBarView.hidden=YES;
        [self showViewController:helpOtherController sender:nil];
    }
    
}
#pragma mark
#pragma mark  ----requestService
-(void)requestDataFromService
{
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_list" params:nil block:^(NSObject *result) {
        homeModel=[HomeIndex mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createScrollView];
            self.countNumLabel.text=[NSString stringWithFormat:@"%@",homeModel.count_join];
            [self.mainTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

#pragma mark
#pragma mark ------tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableCell" forIndexPath:indexPath];
    ProductList *product=[homeModel.product_list objectAtIndex:indexPath.row];
//    cell.indexPath=indexPath;
    [cell.titleImageView setImageWithURL:[NSURL URLWithString:product.list_image relativeToURL:[NSURL URLWithString:KBaseURL]]];
    cell.titleLabel.text=product.name;
    cell.secondTitleLabel.text=product.short_des;
    cell.shuoMIngLabel.text=product.age_limite;
    cell.joinButton.tag=indexPath.row+10;
    [cell.joinButton addTarget:self action:@selector(joinProjectButtAction:) forControlEvents:UIControlEventTouchUpInside];
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    ProductList *product=[homeModel.product_list objectAtIndex:indexPath.row];
    babyProjectController.projectID=product.productID;
    [self showViewController:babyProjectController sender:nil];
}
-(void)joinProjectButtAction:(UIButton*)butt
{
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    ProductList *product=[homeModel.product_list objectAtIndex:butt.tag-10];
    babyProjectController.projectID=product.productID;
    [self showViewController:babyProjectController sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
