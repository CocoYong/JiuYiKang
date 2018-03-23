//
//  JoinDesciptionViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JoinDesciptionViewController.h"
#import "JoinViewController.h"
#import "JoinDescriptionCell.h"
#import "ProjectDescriptionModel.h"
#import "JoinDescriptionTwoCell.h"
#import "LoginViewController.h"
#import "UILabel+Universal.h"
@interface JoinDesciptionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ProjectDescriptionModel *descriptionModel;
}
@property (weak, nonatomic) IBOutlet UITableView *desciptionTableView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *backGrayView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation JoinDesciptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    [self requestDataFromService];
    self.alertView.layer.cornerRadius=5;
    self.desciptionTableView.estimatedRowHeight=100;
    self.desciptionTableView.rowHeight=UITableViewAutomaticDimension;
    
}

-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"id":self.projectID};
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_join_article" params:paramsDic block:^(NSObject *result) {
        descriptionModel=[ProjectDescriptionModel mj_objectWithKeyValues:result];
         dispatch_async(dispatch_get_main_queue(), ^{
        self.projectNameLabel.text=descriptionModel.articleModel.product_name;
             CGFloat headerHeight=[descriptionModel.articleModel.short_desc boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
        self.descriptionLabel.text=descriptionModel.articleModel.short_desc;
             self.descriptionLabel.top=10;
        self.headerView.frame=CGRectMake(20, 35, SCREENWIDTH-20, headerHeight+60);
             self.descriptionLabel.frame=CGRectMake(10, 10, SCREENWIDTH-20, 20);
        [self.desciptionTableView reloadData];
         });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma buttonAction
- (IBAction)cancelButtonAction:(UIButton *)sender{
    self.backGrayView.hidden=NO;
    self.alertView.hidden=NO;
}
- (IBAction)canJoinButtonAction:(UIButton *)sender
{
    if ([self judgeLoginStatus])
    {
        LoginViewController *loginController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self showViewController:loginController sender:nil];
    }else
    {
        JoinViewController *joinController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"JoinViewController"];
        joinController.productID=self.projectID;
        [self showViewController:joinController sender:nil];
    }
}
- (IBAction)closeButtAction:(id)sender {
    self.backGrayView.hidden=YES;
    self.alertView.hidden=YES;
}
- (IBAction)lookOtherProjectButtAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return descriptionModel.joinItemList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row==0) {
//       JoinDescriptionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinDescriptionTwoCell" forIndexPath:indexPath];
//        cell.informationLabel.text=@"    加入互助计划，您需要确认申请人是否符合加入条件，如不符合不能参与该计划。若您未如实告知其中任何一项情况，互助计划将由运营方按规定拒绝您的申请。";
//        return cell;
//    }else
//    {
        JoinDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinDescriptionCell" forIndexPath:indexPath];
        JoinItemModel *iteModel=[descriptionModel.joinItemList objectAtIndex:indexPath.row];
//    cell.numLabel.attributedText=[self getStringWithOrignalString:iteModel.name];
//     CGFloat nameHeight=[[self getStringWithOrignalString:iteModel.name] boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    cell.numLabel.frame=CGRectMake(10, 10, SCREENWIDTH-20, nameHeight);
//
//     CGFloat contentHeight=[[UILabel getAttributStringWithOrignalString:iteModel.detail_content andLineVerticalSpacing:5 andFirstIndent:20] boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    cell.infomationLabel.attributedText=[UILabel getAttributStringWithOrignalString:iteModel.detail_content andLineVerticalSpacing:5 andFirstIndent:20];
//    cell.infomationLabel.frame=CGRectMake(10, CGRectGetMaxY(cell.numLabel.frame)+5, SCREENWIDTH-20, contentHeight);
    cell.numLabel.text=iteModel.name;
    cell.infomationLabel.text=iteModel.detail_content;
        return cell;
//    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JoinItemModel *iteModel=[descriptionModel.joinItemList objectAtIndex:indexPath.row];
//    CGFloat nameHeight=[[self getStringWithOrignalString:iteModel.name] boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    CGFloat contentHeight=[[UILabel getAttributStringWithOrignalString:iteModel.detail_content andLineVerticalSpacing:5 andFirstIndent:20] boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
//    return nameHeight+contentHeight+25;
//}



-(NSMutableAttributedString*)getStringWithOrignalString:(NSString*)orignalString
{
    if (orignalString==nil) {
        return nil;
    }
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    style.lineSpacing=5;
    style.firstLineHeadIndent=20;
    NSMutableAttributedString *attributString=[[NSMutableAttributedString alloc]initWithString:orignalString attributes:@{NSParagraphStyleAttributeName:style}];
    
    [attributString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, attributString.length)];
    return attributString;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BabyProjectViewController *babyProjectController=[STORYBOARDOBJECT instantiateViewControllerWithIdentifier:@"BabyProjectViewController"];
//    self.hidesBottomBarWhenPushed=YES;
//    [self showViewController:babyProjectController sender:nil];
//    if (indexPath.row==0) {
//        
//    }else if (indexPath.row==1)
//    {
//        
//    }else
//    {
//        
//    }
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
