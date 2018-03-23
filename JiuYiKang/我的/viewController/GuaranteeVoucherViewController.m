//
//  GuaranteeVoucherViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//   保障凭证

#import "GuaranteeVoucherViewController.h"
#import "GuaranteeTableViewCell.h"
#import "GuaranteeHeadCell.h"
#import "ApplyMoneyViewController.h"  //申请互助
#import "ForFamilyViewController.h"   //为家人加入计划
#import "MembershipViewController.h" //会员公约/平台公约
#import "PlanCauseViewController.h" //计划条款
#import "SickAndHurtViewController.h" //伤残评定
#import "BalanceMoneyViewController.h" //余额明细
#import "AboutUsViewController.h" //关于我们
#import "RootTabBarController.h"
#import "UILabel+Universal.h"
@interface GuaranteeVoucherViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MyHelpOtherModel *cerModel;
    NSArray *cellTitleArray;
}
@property (weak, nonatomic) IBOutlet UITableView *footTableView;
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation GuaranteeVoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    cellTitleArray=@[@"申请互助",@"进一步了解久益康",@"为家人加入计划",@"邀请好友获得奖励"];
    self.footTableView.estimatedRowHeight=300;
    self.footTableView.rowHeight=UITableViewAutomaticDimension;
    [self requestDataFromService];
}
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    NSString *urlString=[NSString stringWithFormat:@"AppApi/Ushow/certificate/%@",self.listModel.listID];
    [ZYDataRequest requestWithURL:urlString params:paramsDic block:^(NSObject *result) {
        cerModel=[MyHelpOtherModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.footTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

#pragma buttonAction
- (void)pingTaiGongYueAction:(id)sender {
    MembershipViewController *memberController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MembershipViewController"];
    [self showViewController:memberController sender:nil];
}
- (void)jiHuaTiaoKuanAction:(id)sender {
    PlanCauseViewController *planController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"PlanCauseViewController"];
    planController.productID=self.listModel.product_id;
    [self showViewController:planController sender:nil];
}
- (void)shangCanPingDingAction:(id)sender {
    SickAndHurtViewController *sickController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"SickAndHurtViewController"];
    [self showViewController:sickController sender:nil];
}
- (void)chaKanYuEAction:(id)sender {
    BalanceMoneyViewController *yuEController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"BalanceMoneyViewController"];
    yuEController.joinID=self.listModel.listID;
    [self showViewController:yuEController sender:nil];
}


#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        GuaranteeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuaranteeHeadCell" forIndexPath:indexPath];
        [cell.gongYueButt addTarget:self action:@selector(pingTaiGongYueAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tiaoKuanButt addTarget:self action:@selector(jiHuaTiaoKuanAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shangCanButt addTarget:self action:@selector(shangCanPingDingAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.moneyBalanceButt addTarget:self action:@selector(chaKanYuEAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.tempModel=cerModel.joinModel;
        switch ([cerModel.joinModel.stat integerValue]) {
            case 1:
                cell.stateLabel.attributedText=[UILabel createAttributStringWithOriginalString:[NSString stringWithFormat:@"待生效:%@",self.listModel.stat_and_money_tip] specialTextArray:@[@"待生效"] andAttributs:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
                break;
            case 2:
                cell.stateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#389839"];
                cell.stateLabel.text=@"已生效";
                break;
            case 3:
                cell.stateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#FC6621"];
                cell.stateLabel.text=@"已失效";
                break;
            case 4:
                cell.stateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#999999"];
                cell.stateLabel.attributedText=[UILabel createAttributStringWithOriginalString:[NSString stringWithFormat:@"已封禁(%@)",self.listModel.stat_and_money_tip] specialTextArray:@[@"已封禁"] andAttributs:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
                break;
            case 5:
                cell.stateLabel.text=@"失效等待期";
                break;
                
                
            default:
                break;
        }

        return cell;
    }else
    {
        GuaranteeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuaranteeTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.text=[cellTitleArray objectAtIndex:indexPath.row-1];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
        {
            if ([cerModel.joinModel.stat isEqualToString:@"1"]) {
                self.alertView.hidden=NO;
            }else{
                ApplyMoneyViewController *applyMoneyController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"ApplyMoneyViewController"];
                [self showViewController:applyMoneyController sender:nil];
            }
        }
            break;
        case 2:
        {
            AboutUsViewController *aboutUsController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            [self showViewController:aboutUsController sender:nil];
        }
            break;
        case 3:
        {
            ForFamilyViewController *forFamilyController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ForFamilyViewController"];
            [self showViewController:forFamilyController sender:nil];
        }
            break;
        case 4:
        {
            [self.navigationController popToRootViewControllerAnimated:NO];
            [TABBARCONTROLLER selectedTabNum:3];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)closedButtAction:(UIButton *)sender {
    self.alertView.hidden=YES;
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
