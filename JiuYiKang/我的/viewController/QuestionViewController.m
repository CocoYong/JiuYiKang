//
//  QuestionViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionCell.h"
#import "QuestionHeaderView.h"
#import "RootTabBarController.h"
#import "CommonQuestionModel.h"
@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *headArray;
    CommonQuestionModel *quesModel;
}
@property (weak, nonatomic) IBOutlet UITableView *questionTableView;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    [self requestDataFromService];
    headArray=@[@"互助介绍",@"互助规则"];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:@"refresh" object:nil];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)refreshTableView
{
    [self.questionTableView reloadData];
}
-(void)requestDataFromService
{
    [ZYDataRequest requestWithURL:@"AppApi/Public/qa" params:nil block:^(NSObject *result) {
        quesModel=[CommonQuestionModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.questionTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

#pragma tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return quesModel.huzhuIntroArray.count;
    }else{
        return quesModel.huzhuClauseArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        HuZhuIntroModel *introModel=[quesModel.huzhuIntroArray objectAtIndex:indexPath.row];
        if (introModel.expand) {
            return introModel.expandHeight;
        }else
        {
            return introModel.normalHeight;
        }
    }else
    {
        HuZhuClauseModel *clauseModel=[quesModel.huzhuClauseArray objectAtIndex:indexPath.row];
        if (clauseModel.expand) {
            return clauseModel.expandHeight;
        }else
        {
            return clauseModel.normalHeight;
        }

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        HuZhuIntroModel *introModel=[quesModel.huzhuIntroArray objectAtIndex:indexPath.row];
        cell.introModel=introModel;
        cell.titleLabel.text=introModel.name;
        cell.indexpath=indexPath;
        [cell.webView loadHTMLString:introModel.detail_content baseURL:nil];
    }else
    {
        HuZhuClauseModel *clauseModel=[quesModel.huzhuClauseArray objectAtIndex:indexPath.row];
        cell.clauseModel=clauseModel;
        cell.titleLabel.text=clauseModel.name;
        cell.indexpath=indexPath;
        [cell.webView loadHTMLString:clauseModel.detail_content baseURL:nil];
    }
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headIdentifier=@"headIdentifier";
    QuestionHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (!header) {
        header=[[QuestionHeaderView alloc]initWithReuseIdentifier:headIdentifier];
    }
    header.titleLabel.text=[headArray objectAtIndex:section];
    return header;
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
