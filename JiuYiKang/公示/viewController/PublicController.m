//
//  PublicController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicController.h"
#import "RootTabBarController.h"
#import "PublicCell.h"
#import "PublicListModel.h"
#import "PublicDetailViewController.h"
@interface PublicController ()<UITableViewDelegate,UITableViewDataSource>
{
    PublicListModel *listModel;
}
@property (weak, nonatomic) IBOutlet UITableView *publicTableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PublicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:@"refreshPublishTable" object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TABBARCONTROLLER.tabBarView.hidden=NO;
    [self requestDataFromService];

}
-(void)refreshTableView
{
    [self.publicTableView reloadData];
}
#pragma mark
#pragma mark-----requestData
-(void)requestDataFromService
{
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_public_list" params:nil block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
         dispatch_async(dispatch_get_main_queue(), ^{
             if ([[tempDic objectForKey:@"code"] integerValue]==0) {
                 listModel=[PublicListModel mj_objectWithKeyValues:result];
                 if (listModel.public_list!=nil&&listModel.public_list.count!=0) {
                     self.webView.hidden=YES;
                     [self.publicTableView reloadData];
                 }else
                 {
                     if (listModel.detail_content!=nil) {
                         self.webView.hidden=NO;
                         [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:listModel.detail_content]]];
                     }else
                     {
                         self.webView.hidden=YES;
                     }
                 }
             }else
             {
                 [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:1.5];
             }
            
         });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma mark
#pragma mark-----------tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listModel.public_list.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicDataModel *model=[listModel.public_list objectAtIndex:indexPath.row];
    if (model.expand) {
        NSLog(@"expandHeight===%f",model.expandHeight);
        return model.expandHeight;
    }else
    {
        NSLog(@"normalHeight===%f",model.normalHeight);
        return model.normalHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PublicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicCell" forIndexPath:indexPath];
    PublicDataModel *model=[listModel.public_list objectAtIndex:indexPath.row];
    cell.model=model;
    cell.detailLabel.text=model.short_des;
    cell.timeLabel.text=model.date_join;
    cell.nameLabel.text=model.user_name;
    cell.projectNameLabel.text=model.product_name;
    cell.moneyLabel.text=[NSString stringWithFormat:@"%@元",model.money_need];
    [cell.photoImageView setImageWithURL:[NSURL URLWithString:model.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicDetailViewController *detailController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"PublicDetailViewController"];
    PublicDataModel *dataModel=[listModel.public_list objectAtIndex:indexPath.row];
    detailController.publicID=dataModel.publicID;
    [self showViewController:detailController sender:nil];
}
//重用headersection
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    PublicHeaderFooterView *headerView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PublicHeaderFooterView"];
//    headerView.photoImageView.image=[UIImage imageNamed:@"head_mr"];
//    
//    return headerView;
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 10;
//}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
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
