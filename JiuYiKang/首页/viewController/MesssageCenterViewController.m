//
//  MesssageCenterViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MesssageCenterViewController.h"
#import "MessageCenterCell.h"
#import "MessageCenterModel.h"
#import "UniversalModel.h"
#import "MJRefresh.h"
@interface MesssageCenterViewController ()
{
    MessageCenterModel *centerModel;
    NSMutableArray *dataArray;
    NSInteger pageOffset;
    NSInteger  totalItemCount;
}
@property (weak, nonatomic) IBOutlet UITableView *messageTalbe;
@property (weak, nonatomic) IBOutlet UIView *noDataView;


@end

@implementation MesssageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.title=@"我的消息";
    pageOffset=0;
    self.messageTalbe.estimatedRowHeight=100;
    self.messageTalbe.rowHeight=UITableViewAutomaticDimension;
    self.messageTalbe.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableViewData)];
    self.messageTalbe.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTableViewData)];
    dataArray=[NSMutableArray arrayWithCapacity:10];
}
-(void)refreshTableViewData
{
    [self requestDataFromService:pageOffset isRefresh:YES];
}
-(void)loadMoreTableViewData
{
    pageOffset+=5;
    if (dataArray.count==[centerModel.msg_count integerValue]) {
        [self.messageTalbe.mj_footer endRefreshingWithNoMoreData];
        pageOffset=0;
    }else
    {
        [self requestDataFromService:pageOffset isRefresh:NO];
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self requestDataFromService:0 isRefresh:YES];
}
-(void)requestDataFromService:(NSInteger)offset isRefresh:(BOOL)refresh
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"per_page":@"5",@"offset":[NSNumber numberWithInteger:offset]};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/msg" params:paramsDic block:^(NSObject *result) {
        
        centerModel=[MessageCenterModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([centerModel.code isEqualToString:@"0"]) {
                if (refresh) {
                    [dataArray removeAllObjects];
                    [self.messageTalbe.mj_header endRefreshing];
                    [dataArray addObjectsFromArray:centerModel.messageListArray];
                }else
                {
                    [self.messageTalbe.mj_footer endRefreshing];
                    [dataArray addObjectsFromArray:centerModel.messageListArray];
                }
                [self.messageTalbe reloadData];
                if (dataArray.count==0) {
                    self.noDataView.hidden=NO;
                }else
                {
                    self.noDataView.hidden=YES;
                }
            }
//            else
//            {
//             [MBProgressHUD show:centerModel.msg view:self.view time:1.5];
//            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)requestDeleteMessageService:(NSString*)messageID;
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"id":messageID};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/msg_delete" params:paramsDic block:^(NSObject *result) {
        UniversalModel *univerModel=[UniversalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([univerModel.code isEqualToString:@"0"]) {
                [self requestDataFromService:0 isRefresh:YES];
            }else
            {
                [MBProgressHUD show:univerModel.msg view:self.view time:1.5];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}


#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterCell" forIndexPath:indexPath];
    MessageListModel *listItem=[dataArray objectAtIndex:indexPath.row];
    cell.mainTitleLabel.text=listItem.title;
    cell.timeLabel.text=[listItem.create_time substringToIndex:10];
    cell.introduceLabel.text=listItem.msg_content;
    [cell.deletMessageButt addTarget:self action:@selector(deleteMessage:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletMessageButt.tag=indexPath.row;
    return cell;
}
-(void)deleteMessage:(UIButton *)butt
{
    MessageListModel *listItem=[dataArray objectAtIndex:butt.tag];
    [self requestDeleteMessageService:listItem.messageID];
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
