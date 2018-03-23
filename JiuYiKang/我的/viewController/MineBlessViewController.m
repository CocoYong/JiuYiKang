//
//  MineBlessViewController.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/12/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineBlessViewController.h"
#import "BlessListCell.h"
#import "BlessListModel.h"
#import "UIImageView+WebCache.h"
#import "BlessDetailViewController.h"
@interface MineBlessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mineBlessTable;
@property(nonatomic,strong)BlessListModel *listModel;

@end

@implementation MineBlessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMineBlessList];
    [self creatBackNavigationItem];
    
    self.mineBlessTable.tableFooterView=[UIView new];
    self.mineBlessTable.rowHeight=100;
    self.mineBlessTable.separatorStyle=UITableViewCellSeparatorStyleNone;
}


#pragma mark - ---------->>>>>>>>>>tableview代理方法<<<<<<<<<<----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlessListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BlessListCell"];
    BlessSmallModel *tempModel=[self.listModel.my_bless_list objectAtIndex:indexPath.row];
    cell.mineBlessTitleLabel.text=tempModel.name;
    cell.mineBlessDescLabel.text=tempModel.desc;
    cell.mineBlessStateLabel.text=tempModel.bless_stat_str;
    if ([tempModel.bless_stat_str isEqualToString:@"待支付"]) {
        cell.mineBlessStateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#B7B7B7"];
    }else if ([tempModel.bless_stat_str isEqualToString:@"进行中"])
    {
       cell.mineBlessStateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#EBB829"];
    }else if ([tempModel.bless_stat_str isEqualToString:@"审核中"])
    {
        cell.mineBlessStateLabel.backgroundColor=[UtilitiesHelper colorWithHexString:@"#FF864E"];
    }else
    {
        cell.mineBlessStateLabel.backgroundColor=[UIColor redColor];
    }
    [cell.mineBlessImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBaseURL,tempModel.face_uri]] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRefreshCached];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listModel.my_bless_list.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlessDetailViewController *detailController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"BlessDetailViewController"];
    BlessSmallModel *smallModel=[self.listModel.my_bless_list objectAtIndex:indexPath.row];
    detailController.productID=smallModel.smallID;
    [self showViewController:detailController sender:nil];
}
#pragma mark  ----requestService
-(void)requestMineBlessList
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/my_bless" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"] integerValue]==0) {
            self.listModel=[BlessListModel mj_objectWithKeyValues:result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mineBlessTable reloadData];
            });
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)backToFrontViewContrller
{
    if ([self.fromType isEqualToString:@"addReference"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
