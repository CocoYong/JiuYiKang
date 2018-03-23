//
//  BalanceMoneyViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//  余额明细

#import "BalanceMoneyViewController.h"
#import "BalanceMoneyCell.h"
#import "BalanceMoneyModel.h"
#import "RechargeViewController.h"
@interface BalanceMoneyViewController ()
{
    BalanceMoneyModel *balanceModel;
}
@property (weak, nonatomic) IBOutlet UITableView *balanceTableView;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;

@end

@implementation BalanceMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    [self requestDataFromService];
}
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    NSString *urlString=[NSString stringWithFormat:@"AppApi/Ushow/my_join_balance/%@",self.joinID];
    [ZYDataRequest requestWithURL:urlString params:paramsDic block:^(NSObject *result) {
        balanceModel=[BalanceMoneyModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.yueLabel.text=[NSString stringWithFormat:@"￥%@",balanceModel.productModel.money];
            [self.balanceTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

- (IBAction)rechargeButtAction:(UIButton *)sender {
    RechargeViewController *rechargeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"RechargeViewController"];
    rechargeController.rechargeItemID=balanceModel.productModel.productID;
    rechargeController.fromPage=@"balance";
    [self showViewController:rechargeController sender:nil];
}

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return balanceModel.detailListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BalanceMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BalanceMoneyCell" forIndexPath:indexPath];
    DetailListModel *listModel=[balanceModel.detailListArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=listModel.name;
    cell.detailLabel.text=listModel.des;
    cell.timeLabel.text=[[listModel.create_time componentsSeparatedByString:@" "] firstObject];
    cell.moneyLabel.text=listModel.money;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
