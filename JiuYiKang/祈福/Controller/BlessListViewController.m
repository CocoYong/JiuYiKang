//
//  BlessListViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/13.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessListViewController.h"
#import "BlessListCell.h"
#import "BlessListModel.h"
#import "BlessDetailViewController.h"
@interface BlessListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *blessListTable;

@property (weak, nonatomic) IBOutlet UIButton *bigSickTabButton;
@property (weak, nonatomic) IBOutlet UIView *redBigSickLine;

@property (weak, nonatomic) IBOutlet UIButton *weiXiaoButton;
@property (weak, nonatomic) IBOutlet UIView *redWeiXiaoLine;

@property (weak, nonatomic) IBOutlet UIButton *helpStudyButton;
@property (weak, nonatomic) IBOutlet UIView *redStudyLine;


@property(nonatomic,strong)BlessListModel *listModel;
@property(nonatomic,strong)BlessTypeListModel *typeModel;
@end

@implementation BlessListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    [self requestBlessList];
    self.blessListTable.rowHeight=140;
    self.blessListTable.estimatedRowHeight=UITableViewAutomaticDimension;
    self.blessListTable.tableFooterView=[UIView new];
}
#pragma mark - ---------->>>>>>>>>>tableview代理方法<<<<<<<<<<----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlessListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BlessListCell"];
    [cell configeCellData:[self.typeModel.bless_list objectAtIndex:indexPath.row]];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeModel.bless_list.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlessDetailViewController *detailController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"BlessDetailViewController"];
    BlessSmallModel *smallModel=[self.typeModel.bless_list objectAtIndex:indexPath.row];
    detailController.productID=smallModel.smallID;
    detailController.fromController=@"listController";
    [self showViewController:detailController sender:nil];
}
#pragma mark -  buttonActions

- (IBAction)bigSickAction:(UIButton*)sender
{
    sender.selected=YES;
    sender.selected?(self.redBigSickLine.hidden=NO):(self.redBigSickLine.hidden=YES);
    if (sender.selected) {
        self.redStudyLine.hidden=YES;
        self.redWeiXiaoLine.hidden=YES;
        self.helpStudyButton.selected=NO;
        self.weiXiaoButton.selected=NO;
      
    }
    self.typeModel=[self.listModel.bless_type_list objectAtIndex:0];
    [self.blessListTable reloadData];
}
- (IBAction)helpStudyAction:(UIButton*)sender
{
    sender.selected=YES;
    if (sender.selected) {
        self.redBigSickLine.hidden=YES;
        self.redWeiXiaoLine.hidden=YES;
        self.bigSickTabButton.selected=NO;
        self.weiXiaoButton.selected=NO;
        
    }
     sender.selected?(self.redStudyLine.hidden=NO):(self.redStudyLine.hidden=YES);
    self.typeModel=[self.listModel.bless_type_list objectAtIndex:2];
    [self.blessListTable reloadData];
}
- (IBAction)weiXiaoAction:(UIButton*)sender
{
    sender.selected=YES;
    if (sender.selected) {
        self.redBigSickLine.hidden=YES;
        self.redStudyLine.hidden=YES;
        self.helpStudyButton.selected=NO;
        self.bigSickTabButton.selected=NO;
    }
     sender.selected?(self.redWeiXiaoLine.hidden=NO):(self.redWeiXiaoLine.hidden=YES);
    self.typeModel=[self.listModel.bless_type_list objectAtIndex:1];
    [self.blessListTable reloadData];
}
#pragma mark  ----requestService
-(void)requestBlessList
{
    
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")==nil?@"":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Bless/bless_list" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"] integerValue]==0) {
         self.listModel=[BlessListModel mj_objectWithKeyValues:result];
            dispatch_async(dispatch_get_main_queue(), ^{
            self.typeModel=[self.listModel.bless_type_list objectAtIndex:0];
            [self.blessListTable reloadData];
            });
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
@end
