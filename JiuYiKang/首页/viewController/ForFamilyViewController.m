//
//  ForFamilyViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//为家人加入

#import "ForFamilyViewController.h"
#import "BabyProjectViewController.h"
#import "HomeIndex.h"
#import "ForFamilyCell.h"
@interface ForFamilyViewController ()
{
    HomeIndex *homeModel;
}
@property(nonatomic,weak)IBOutlet UITableView *familyTableView;
@end

@implementation ForFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.familyTableView.rowHeight=130;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self requestDataFromService];
}

-(void)requestDataFromService
{
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_list" params:nil block:^(NSObject *result) {
        homeModel=[HomeIndex mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.familyTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma ButtonAction
- (IBAction)forBabyProjectAction:(UIButton *)sender {
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
     
    [self showViewController:babyProjectController sender:nil];
}
- (IBAction)forFatherMotherProjectAction:(UIButton *)sender {
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
    [self showViewController:babyProjectController sender:nil];
}
- (IBAction)forFamilyProjectAction:(UIButton *)sender {
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
    [self showViewController:babyProjectController sender:nil];
}

#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ForFamilyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForFamilyCell" forIndexPath:indexPath];
    ProductList *listModel=[homeModel.product_list objectAtIndex:indexPath.row];
    cell.projectNameLabel.text=listModel.name;
    cell.ageLimitLabel.text=listModel.age_limite;
    cell.descLabel.text=listModel.short_des;
    cell.maxGetMoneyLabel.text=listModel.money_max;
    cell.frontLabel.text=listModel.to_des;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
    ProductList *listModel=[homeModel.product_list objectAtIndex:indexPath.row];
    babyProjectController.projectID=listModel.productID;
    [self showViewController:babyProjectController sender:nil];
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
