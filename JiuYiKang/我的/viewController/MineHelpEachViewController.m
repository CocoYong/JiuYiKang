//
//  MineHelpEachViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//   我的互助

#import "MineHelpEachViewController.h"
#import "MineHelpEachTableViewCell.h"
#import "GuaranteeVoucherViewController.h"
#import "ForFamilyViewController.h"
#import "RootTabBarController.h"
#import "MyHelpOtherModel.h"
#import "RechargeViewController.h"
#import "MyProtectCardController.h"
@interface MineHelpEachViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MyHelpOtherModel *listModel;
}
@property (weak, nonatomic) IBOutlet UITableView *mineHelpEachTableView;
@property (weak, nonatomic) IBOutlet UIView *noPlanBgView;

@end

@implementation MineHelpEachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的互助";
     [self creatBackNavigationItem];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self requestDataFromService];
}
#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listModel.joinListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineHelpEachTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHelpEachTableViewCell" forIndexPath:indexPath];
    cell.itemModel=[listModel.joinListArray objectAtIndex:indexPath.row];
    [cell.imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.imageButton.tag=indexPath.row*3+0;
    [cell.chargeButton addTarget:self action:@selector(chargeButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.protectCardButt addTarget:self action:@selector(protectCardButtAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.protectCardButt.tag=indexPath.row*3+2;
    cell.chargeButton.tag=indexPath.row*3+1;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}


-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/my_join" params:paramsDic block:^(NSObject *result) {
        listModel=[MyHelpOtherModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (listModel.joinListArray.count==0) {
                self.noPlanBgView.hidden=NO;
                self.mineHelpEachTableView.hidden=YES;
            }else
            {
                self.noPlanBgView.hidden=YES;
                self.mineHelpEachTableView.hidden=NO;
              [self.mineHelpEachTableView reloadData];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma mark
#pragma mark----------buttAction
-(void)backToFrontViewContrller
{
    if ([self.fromPage isEqualToString:@"join"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)chargeButtAction:(UIButton*)butt
{
    MyHelpOtherListModel *model= [listModel.joinListArray objectAtIndex:butt.tag/3];
    RechargeViewController *chargeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"RechargeViewController"];
    chargeController.rechargeItemID=model.listID;
    chargeController.fromPage=@"mineHelp";
    [self showViewController:chargeController sender:nil];
}
-(void)imageButtonAction:(UIButton*)butt
{
   MyHelpOtherListModel *model= [listModel.joinListArray objectAtIndex:butt.tag/3];
    GuaranteeVoucherViewController *guranteeCotroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"GuaranteeVoucherViewController"];
    guranteeCotroller.listModel=model;
    [self showViewController:guranteeCotroller sender:nil];
}
- (IBAction)forFamilyButtAction:(id)sender {
    ForFamilyViewController *forFamilyController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ForFamilyViewController"];
    [self showViewController:forFamilyController sender:nil];
}
-(void)protectCardButtAction:(UIButton*)butt
{
    MyHelpOtherListModel *model= [listModel.joinListArray objectAtIndex:butt.tag/3];
    MyProtectCardController *protectCardCotroller=[[MyProtectCardController alloc]init];
    protectCardCotroller.join_id=model.listID;
    [self showViewController:protectCardCotroller sender:nil];
    
}
- (IBAction)invitFriendButtAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [TABBARCONTROLLER selectedTabNum:3];
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
