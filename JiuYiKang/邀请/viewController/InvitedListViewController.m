//
//  InvitedListViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "InvitedListViewController.h"
#import "InvitedListCell.h"
#import "RootTabBarController.h"
#import "InvitedListModel.h"
#import "UILabel+Universal.h"
#import "MJRefresh.h"
@interface InvitedListViewController ()<UIScrollViewDelegate>
{
    InvitedListModel *invitModel;
    NSInteger totalItemNum;
    NSMutableArray *itemsArray;
    NSInteger pageOffSet;

}
@property (weak, nonatomic) IBOutlet UITableView *invitedListTableView;

@property (weak, nonatomic) IBOutlet UILabel *totalInvitedLabel;



@end

@implementation InvitedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    pageOffSet=0;
    self.invitedListTableView.rowHeight=40;
    itemsArray=[NSMutableArray arrayWithCapacity:10];
    self.invitedListTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.invitedListTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    [self requestDataFromService:pageOffSet isRefresh:YES];
}
-(void)refreshData
{
  [self requestDataFromService:pageOffSet isRefresh:YES];
}
-(void)loadMoreData
{
    pageOffSet+=5;
    if (totalItemNum==[itemsArray count]) {
        pageOffSet=0;
        [self.invitedListTableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self requestDataFromService:pageOffSet isRefresh:NO];
    }
}
-(void)requestDataFromService:(NSInteger)offset isRefresh:(BOOL)refresh
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"per_page":@"5",@"offset":[NSNumber numberWithInteger:offset]};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/my_push_user" params:paramsDic block:^(NSObject *result) {
        invitModel=[InvitedListModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (refresh) {
                [itemsArray removeAllObjects];
                [itemsArray addObjectsFromArray:invitModel.pushListArray];
            }else
            {
                [itemsArray addObjectsFromArray:invitModel.pushListArray];
            }
            self.totalInvitedLabel.attributedText=[UILabel createAttributStringWithOriginalString:[NSString stringWithFormat:@"邀请记录(共%@人，总奖励:￥%@)",invitModel.pushCount,self.totalMoney] specialTextArray:@[invitModel.pushCount,self.totalMoney] andAttributs:@{NSForegroundColorAttributeName:[UIColor redColor]}];
            totalItemNum=[invitModel.pushCount integerValue];
            [self.invitedListTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

#pragma buttActions

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemsArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    InvitedListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvitedListCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.nickNameLabel.text=@"微信昵称";
        cell.telephoneNumLabel.text=@"手机号";
        cell.invitedTimeLabel.text=@"邀请时间";
    }else
    {
        PushListModel *listModel=[itemsArray objectAtIndex:indexPath.row-1];
        cell.nickNameLabel.text=listModel.user_name;
        cell.telephoneNumLabel.text=listModel.mobile;
        cell.invitedTimeLabel.text=[listModel.create_time substringToIndex:10];
    }
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        NSLog(@"scrollViewContentOffset====%@",NSStringFromCGPoint(scrollView.contentOffset));
    }
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
