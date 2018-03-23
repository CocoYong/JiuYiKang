//
//  MineController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineController.h"
#import "MineTableViewCellOne.h"
#import "UserInfoViewController.h"
#import "MineHelpEachViewController.h"
#import "MyCertifViewController.h"
#import "AboutUsViewController.h"
#import "AllRechargeViewController.h"
#import "MesssageCenterViewController.h"
#import "ApplyMoneyViewController.h"
#import "ForFamilyViewController.h"
#import "QuestionViewController.h"
#import "RootTabBarController.h"
#import "UserInfoModel.h"
#import "MineBlessViewController.h"
#import "MineExperienceViewController.h"
#import "UIImageView+WebCache.h"
@interface MineController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *iconArray;
    NSArray *titleArray;
    UserInfoModel *userModel;
}
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *mineTalbleView;
@property (weak, nonatomic) IBOutlet UIView *popAlertView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIButton *sureButt;

@property(nonatomic,assign)BOOL showExperienceCell;
@property(nonatomic,copy)NSString *showState;
@property(nonatomic,copy)NSString *hasJoin;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mineTalbleView.tableFooterView=[UIView new];
    self.photoImageView.layer.cornerRadius=40;
    self.photoImageView.layer.borderWidth=4;
    self.photoImageView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#E36864"].CGColor;
    [self.photoImageView setClipsToBounds:YES];
    self.alertView.layer.cornerRadius=5;
    self.alertView.clipsToBounds=YES;
    self.sureButt.layer.cornerRadius=5;
    iconArray=@[@"per_icon1",@"per_icon1",@"per_icon2",@"per_icon16",@"per_icon17",@"per_icon3",@"per_icon4",@"per_icon5",@"per_icon6",@"per_icon7",@"per_icon8",@"per_icon9",@"per_icon10"];
    titleArray=@[@"我的互助",@"我的保障卡",@"我的证书",@"我的祈福",@"我的体验产品",@"充值",@"为家人加入",@"邀请",@"申请互助金",@"了解久益康",@"常见问题",@"消息中心",@"联系客服"];
}
-(void)checkHasExperienceProduct
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/index" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"] integerValue]==0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *freeState=[[tempDic objectForKey:@"data"] objectForKey:@"has_free_product_stat"];
                if ((NSNull*)freeState==[NSNull null]) {
                   self.showExperienceCell=NO;
                }else
                {
                    if ([freeState integerValue]==0||[freeState integerValue]==1)
                    {
                        self.showExperienceCell=YES;
                        self.showState=[[tempDic objectForKey:@"data"] objectForKey:@"has_free_product_stat"];
                    }
                }
                self.hasJoin=[[tempDic objectForKey:@"data"] objectForKey:@"has_join"];
                [self.mineTalbleView reloadData];
            });
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/my_info" params:paramsDic block:^(NSObject *result) {
        userModel=[UserInfoModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:userModel.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]] placeholderImage:[UIImage imageNamed:@"tx2"] options:SDWebImageRefreshCached];
            self.nameLabel.text=userModel.user_name;
            [self.mineTalbleView reloadData];
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
    TABBARCONTROLLER.tabBarView.hidden=NO;
    [self requestDataFromService];
    [self checkHasExperienceProduct];
}

- (IBAction)photoButtAction:(UIButton *)sender
{
    UserInfoViewController *userInfoController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
    [self showViewController:userInfoController sender:nil];
}





#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCellOne *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCellOne" forIndexPath:indexPath];
    cell.iconImageView.image=[UIImage imageNamed:[iconArray objectAtIndex:indexPath.row]];
    cell.titleLabel.text=[titleArray objectAtIndex:indexPath.row];
    cell.introductionLabel.textAlignment=NSTextAlignmentRight;

    if (indexPath.row==0) {
        cell.introductionLabel.textColor=[UIColor redColor];
        cell.introductionLabel.text=userModel.product_join_money_msg;
        cell.introductionLabel.hidden=NO;
    }else if (indexPath.row==12)
    {
        cell.location=@"right";
        cell.introductionLabel.text=@"400-6010-550";
        [cell layoutIfNeeded];
        cell.introductionLabel.hidden=NO;
        cell.arrowImageView.hidden=YES;
    }else
    {
        cell.introductionLabel.hidden=YES;
        cell.arrowImageView.hidden=NO;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.showExperienceCell&&indexPath.row==4) {
        return 0;
    }else
    {
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        case 1:
        {
            MineHelpEachViewController *helpOtherController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MineHelpEachViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            helpOtherController.fromPage=@"mine";
            [self showViewController:helpOtherController sender:nil];
        }
            break;
        case 2:
        {
            if ((NSNull*)self.hasJoin==[NSNull null]) {
               self.popAlertView.hidden=NO;
                TABBARCONTROLLER.tabBarView.hidden=YES;
            }else
            {
                MyCertifViewController *myCerController=[[MyCertifViewController alloc]init];
                TABBARCONTROLLER.tabBarView.hidden=YES;
                myCerController.userID=userModel.user_id;
                [self showViewController:myCerController sender:nil];
            }
        }
            break;
        case 3:
        {
            MineBlessViewController *mineBlessController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"MineBlessViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:mineBlessController sender:nil];
        }
            break;
        case 4:
        {
            MineExperienceViewController *experienceController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"MineExperienceViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            experienceController.model=userModel;
            experienceController.showType=self.showState;
            experienceController.fromController=@"MineController";
            [self showViewController:experienceController sender:nil];
        }
            break;
        case 5:
        {
            AllRechargeViewController *allRechargeController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"AllRechargeViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:allRechargeController sender:nil];
        }
            break;
        case 6:
        {
            ForFamilyViewController *forFamilyController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ForFamilyViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:forFamilyController sender:nil];
        }
            break;
        case 7:
        {
            [TABBARCONTROLLER selectedTabNum:3];
        }
            break;
        case 8:
        {
            ApplyMoneyViewController *applyMoneyController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"ApplyMoneyViewController"];
            [self showViewController:applyMoneyController sender:nil];
        }
            break;
        case 9:
        {
            AboutUsViewController *aboutUsController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
            [self showViewController:aboutUsController sender:nil];
        }
            break;
        case 10:
        {
            QuestionViewController *questionController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"QuestionViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:questionController sender:nil];
        }
            break;
        case 11:
        {
            MesssageCenterViewController *messagerCenterController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"MesssageCenterViewController"];
            TABBARCONTROLLER.tabBarView.hidden=YES;
            [self showViewController:messagerCenterController sender:nil];
        }
            break;
        case 12:
        {
            [[UtilitiesHelper shareHelper] dialTelephoneNum:@"4006010550"];
        }
            break;
            
        default:
            break;
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}
- (IBAction)sureButtAction:(id)sender {
    self.popAlertView.hidden=YES;
     TABBARCONTROLLER.tabBarView.hidden=NO;
     [TABBARCONTROLLER selectedTabNum:0];
}
- (IBAction)cancelButtAction:(id)sender {
    self.popAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
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
