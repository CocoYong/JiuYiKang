//
//  JieSuanMoneyViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JieSuanMoneyViewController.h"
#import "DepositViewController.h"
#import "JieSuanMingXiCell.h"
#import "RootTabBarController.h"
#import "JieSuanMingXiModel.h"
@interface JieSuanMoneyViewController ()
{
    JieSuanMingXiModel *mingXiModel;
}
@property (weak, nonatomic) IBOutlet UITableView *jieSuanTableView;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *canDepositMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hadDepositMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *iceMoneyLabel;

@end

@implementation JieSuanMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    [self requestDataFromService];
}

-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/my_push_money" params:paramsDic block:^(NSObject *result) {
        mingXiModel=[JieSuanMingXiModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totalMoneyLabel.text=[NSString stringWithFormat:@"￥%@",mingXiModel.moneyInfoModel.sum_push_money];
            self.canDepositMoneyLabel.text=[NSString stringWithFormat:@"￥%@",mingXiModel.moneyInfoModel.sum_push_money_enabled];
            self.hadDepositMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",fabs([mingXiModel.moneyInfoModel.hadDespositMoney floatValue])];
            self.iceMoneyLabel.text=[NSString stringWithFormat:@"￥%@",mingXiModel.moneyInfoModel.money_doing];
            [self.jieSuanTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        TABBARCONTROLLER.tabBarView.hidden=YES;
    self.jieSuanTableView.rowHeight=80;
    [self requestDataFromService];
}
- (IBAction)applyDepositBttonAction:(UIButton *)sender {
    DepositViewController *applyDespositController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"DepositViewController"];
    applyDespositController.despositMoney=mingXiModel.moneyInfoModel.sum_push_money_enabled;
    [self showViewController:applyDespositController sender:nil];
}

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mingXiModel.pushListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JieSuanMingXiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JieSuanMingXiCell" forIndexPath:indexPath];
    MingXiPushListModel *itemModel=[mingXiModel.pushListArray objectAtIndex:indexPath.row];
    cell.applyTimeLabel.text=[[itemModel.create_time componentsSeparatedByString:@" "] firstObject];
    cell.applyDepositLabel.text=itemModel.title;
    cell.stateLabel.text=itemModel.title_sub;
    if ([itemModel.title isEqualToString:@"推广奖励"]) {
        cell.moneyLabel.text=[NSString stringWithFormat:@"+%@",itemModel.money];
    }else
    {
       cell.moneyLabel.text=[NSString stringWithFormat:@"-%@",itemModel.money];
    }
    return cell;
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
