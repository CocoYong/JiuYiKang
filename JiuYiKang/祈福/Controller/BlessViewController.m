//
//  BlessViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessViewController.h"
#import "BeginBlessViewController.h"
#import "BlessOrignalModel.h"
#import "UIImageView+WebCache.h"
#import "RootTabBarController.h"
#import "BlessTypeCell.h"
@interface BlessViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *blessTable;

@property(nonatomic,strong)BlessOrignalModel *model;
@property (weak, nonatomic) IBOutlet UILabel *blessDescLabel;

@end

@implementation BlessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blessTable.tableFooterView=[UIView new];
    self.blessTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.blessTable.rowHeight=SCREENWIDTH*176/580+10;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self requestDataFromService];
    TABBARCONTROLLER.tabBarView.hidden=NO;
}
#pragma mark - ----requestService
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":@""};
    [ZYDataRequest requestWithURL:@"AppApi/Bless/index" params:paramsDic block:^(NSObject *result) {
        self.model=[BlessOrignalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.blessDescLabel.text=self.model.bless_desc;
            [self.blessTable reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma mark - tableView----
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlessTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BlessTypeCell"];
    BlessTypeModel *model=[self.model.bless_type_list objectAtIndex:indexPath.row];
    cell.backImageView.userInteractionEnabled=YES;
    if (indexPath.row==0) {
        [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.image_uri] placeholderImage:[UIImage imageNamed:@"qf_bg1"]];
        cell.iconImageView.image=[UIImage imageNamed:@"qf_icon1"];
        cell.titleLabel.text=@"大病祈福";
        cell.introLabel.text=model.desc;
    }else if (indexPath.row==1)
    {
        [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.image_uri] placeholderImage:[UIImage imageNamed:@"qf_bg2"]];
        cell.iconImageView.image=[UIImage imageNamed:@"qf_icon2"];
        cell.titleLabel.text=@"天下微孝";
        cell.introLabel.text=model.desc;
    }else
    {
        [cell.backImageView sd_setImageWithURL:[NSURL URLWithString:model.image_uri] placeholderImage:[UIImage imageNamed:@"qf_bg3"]];
        cell.titleLabel.text=@"爱心助学";
        cell.iconImageView.image=[UIImage imageNamed:@"qf_icon3"];
        cell.introLabel.text=model.desc;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self judgeLoginStatus]) {
        UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
        [UIApplication sharedApplication].delegate.window.rootViewController=navcontroller;
    }else
    {
        BlessTypeModel *model=[self.model.bless_type_list objectAtIndex:indexPath.row];
        BeginBlessViewController *beginBlessController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"BeginBlessViewController"];
        beginBlessController.typeID=model.typeID;
        TABBARCONTROLLER.tabBarView.hidden=YES;
        [self showViewController:beginBlessController sender:nil];
    }
}

@end
