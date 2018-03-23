//
//  BabyProjectViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BabyProjectViewController.h"
#import "BabyProjectModel.h"
#import "BabyProjectOneCell.h"
#import "BabyProjectTwoCell.h"
#import "BabyProjectThreeCell.h"
#import "BabyProjectFourCell.h"
#import "BabyProjectFiveCell.h"
#import "JoinDesciptionViewController.h"
#import "RootTabBarController.h"
#import "MembershipViewController.h"
#import "HealthRequireViewController.h"
#import "UIImageView+WebCache.h"
#import "BabyHeaderView.h"
#import "PlanCauseViewController.h"
@interface BabyProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *headerArray;
    __block CGFloat imageCellOneHeight;
    __block CGFloat imageCellThreeHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *babyTableView;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalPeopleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeDaysNumLabel;
@property (strong, nonatomic)  UIImageView *calHeightOne;
@property (strong, nonatomic)  UIImageView *calHeightTwo;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;
@property (weak, nonatomic) IBOutlet UIView *backGrayView;
@property (weak, nonatomic) IBOutlet UIView *telephoneAlertView;
@property (weak, nonatomic) IBOutlet UIView *weChatAlertView;

@property(nonatomic,strong) BabyProjectModel *babyModel;// tochange....
@end

@implementation BabyProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.telephoneAlertView.layer.cornerRadius=5;
    self.weChatAlertView.layer.cornerRadius=5;
    //操蛋的需要用个imageview来做容器计算两个图片的高度。。。
    _calHeightOne=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_calHeightOne];
    _calHeightTwo=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_calHeightTwo];
    
    [self creatBackNavigationItem];
    [self requestDataFromService];
    headerArray=[NSMutableArray arrayWithObjects:@"",@"互助规则",@"服务保障",@"常见问题",@"",@"", nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView) name:@"refreshBabyControler" object:nil];
}
-(void)refreshTableView
{
    [self.babyTableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TABBARCONTROLLER.tabBarView.hidden=YES;
}

#pragma mark
#pragma mark  -----------requestService
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"id":self.projectID};
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_detail" params:paramsDic block:^(NSObject *result) {
        _babyModel=[BabyProjectModel mj_objectWithKeyValues:result];
         dispatch_async(dispatch_get_main_queue(), ^{
        [self.firstImageView setImageWithURL:[NSURL URLWithString:_babyModel.product.detail_image_top relativeToURL:[NSURL URLWithString:KBaseURL]]];
        self.totalPeopleNumLabel.text=[NSString stringWithFormat:@"%ld",[_babyModel.product.count_join_demo integerValue]+[_babyModel.product.count_join integerValue]];
        self.threeDaysNumLabel.text=[NSString stringWithFormat:@"%ld",[_babyModel.product.count_join_3_days_demo integerValue]+[_babyModel.product.count_join_3_days integerValue]];
        //计算image高度
        [self.calHeightOne sd_setImageWithURL:[NSURL URLWithString:_babyModel.product.detail_image_about relativeToURL:[NSURL URLWithString:KBaseURL]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            CGFloat imagewith=CGImageGetWidth(image.CGImage);
            imageCellOneHeight=SCREENWIDTH/(imagewith/CGImageGetHeight(image.CGImage));
             [self.babyTableView reloadData];
        }];
        [self.calHeightTwo sd_setImageWithURL:[NSURL URLWithString:_babyModel.product.detail_image_service relativeToURL:[NSURL URLWithString:KBaseURL]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                 CGFloat imagewith=CGImageGetWidth(image.CGImage);
                 imageCellThreeHeight=SCREENWIDTH/(imagewith/CGImageGetHeight(image.CGImage));
            [self.babyTableView reloadData];
             }];
        [headerArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"了解%@",_babyModel.product.name]];
        [self.babyTableView reloadData];
         });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma mark
#pragma mark---------- buttAction
- (IBAction)invitePeopleJoin:(UIButton *)sender {
    [TABBARCONTROLLER selectedTabNum:3];
}
- (IBAction)joinRightNowAction:(UIButton *)sender {
    JoinDesciptionViewController *joinDescriptionController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"JoinDesciptionViewController"];
    joinDescriptionController.projectID=self.projectID;
    [self showViewController:joinDescriptionController sender:nil];
}




#pragma mark
#pragma mark------ tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 2:
        case 4:
           return 1;
            break;
        case 1:
            return self.babyModel.product_rule_list.count;
            break;
        case 3:
            return self.babyModel.fast_qa_list.count;
            break;
        case 5:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return imageCellOneHeight;
        }
            break;
        case 1:
        {
            RuleListModel *model=[self.babyModel.product_rule_list objectAtIndex:indexPath.row];
            if (model.expand) {
                return  model.expandHeight;
            }else
            {
                return  model.normalHeight;
            }
        }
            break;
        case 2:
        {
            return imageCellThreeHeight;
        }
            break;
        case 3:
        {
            FastQList *model=[self.babyModel.fast_qa_list objectAtIndex:indexPath.row];
            if (model.expand) {
                return model.expandHeight;
            }else
            {
                return model.normalHeight;
            }
        }
            break;
        case 4:
        {
            return 44;
        }
            break;
        case 5:
        {
            return 44;
        }
            break;
            
        default:
        {
            return 0;
   
        }
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
        BabyProjectTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectTwoCell" forIndexPath:indexPath];
        [cell.baoZhangImageView setImageWithURL:[NSURL URLWithString:_babyModel.product.detail_image_about relativeToURL:[NSURL URLWithString:KBaseURL]]];
            return cell;
        }
            break;
        case 1:
        {
            BabyProjectOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectOneCell" forIndexPath:indexPath];
            RuleListModel *ruleModel=[self.babyModel.product_rule_list objectAtIndex:indexPath.row];
            cell.helpModel=ruleModel;
            cell.titleLabel.text=ruleModel.name;
            [cell.webView loadHTMLString:ruleModel.detail_content baseURL:nil];
            cell.webView.delegate=cell;
            cell.titleDetailLabel.text=ruleModel.short_des;
            //        cell.detaillabel.text=ruleModel.detail_content;
            return cell;
        }
            break;

        case 2:
        {
            BabyProjectTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectTwoCell" forIndexPath:indexPath];
            
            [cell.baoZhangImageView setImageWithURL:[NSURL URLWithString:_babyModel.product.detail_image_service relativeToURL:[NSURL URLWithString:KBaseURL]]];
            return cell;
        }
            break;

        case 3:
        {
            BabyProjectFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectFiveCell" forIndexPath:indexPath];
            FastQList *qlistModel=[self.babyModel.fast_qa_list objectAtIndex:indexPath.row];
            cell.commonModel=qlistModel;
            cell.titleLabel.text=qlistModel.name;
            [cell.webView loadHTMLString:qlistModel.detail_content baseURL:nil];
            cell.webView.delegate=cell;
            //        cell.detaillabel.text=qlistModel.detail_content;
            return cell;
  
        }
            break;

        case 4:
        {
            BabyProjectThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectThreeCell" forIndexPath:indexPath];
            [cell.phoneButt addTarget:self action:@selector(telephoneButtAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.weChatButt addTarget:self action:@selector(showWeChatViewButtAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;

        case 5:
        {
            BabyProjectFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BabyProjectFourCell" forIndexPath:indexPath];
            if (indexPath.row==0) {
                cell.titleLabel.text=@"《会员公约》";
            }else if (indexPath.row==1)
            {
                if ([self.babyModel.product.name isEqualToString:@"宝宝计划"]) {
                    cell.titleLabel.text=@"《宝贝计划条款》";
                }else if ([self.babyModel.product.name isEqualToString:@"银丝计划"])
                {
                    cell.titleLabel.text=@"《银丝计划条款》";
                }else
                {
                    cell.titleLabel.text=@"《大病互助计划条款》";
                }
                
            }else
            {
                cell.titleLabel.text=@"《健康要求》";
            }
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==5&&indexPath.row==0) {
        MembershipViewController *membershipController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MembershipViewController"];
        [self showViewController:membershipController sender:nil];
    } if (indexPath.section==5&&indexPath.row==1)
    {
        PlanCauseViewController *planCauseController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"PlanCauseViewController"];
        planCauseController.productID=self.projectID;
        [self showViewController:planCauseController sender:nil];
    }if(indexPath.section==5&&indexPath.row==2)
    {
        HealthRequireViewController *healthRequireController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"HealthRequireViewController"];
        [self showViewController:healthRequireController sender:nil];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==4) {
        return 0;
    }
    if (section==5) {
        return 10;
    }
    return 43;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    static NSString *headIdentifier=@"BabyHeaderView";
    BabyHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (!header) {
        header=[[BabyHeaderView alloc]initWithReuseIdentifier:headIdentifier];
    }
    if (section==5) {
        header.mainTitleLabel.hidden=YES;
        header.hongSeLine.hidden=YES;
        header.huiseLine.hidden=YES;
    }else
    {
        header.mainTitleLabel.hidden=NO;
        header.hongSeLine.hidden=NO;
        header.huiseLine.hidden=NO;
    }
    if (section==0) {
        header.hongSeLine.frame=CGRectMake(10, 40, 104, 2);
    }else
    {
       header.hongSeLine.frame=CGRectMake(10, 40, 70, 2);
    }
    header.mainTitleLabel.text=[headerArray objectAtIndex:section];
    return header;
}



#pragma mark
#pragma mark-------callButtAction
-(void)telephoneButtAction:(UIButton*)dealTelephonNum
{
    
    self.backGrayView.hidden=NO;
    self.telephoneAlertView.hidden=NO;
}
- (IBAction)cancelButtAction:(UIButton *)sender {
    self.backGrayView.hidden=YES;
    self.telephoneAlertView.hidden=YES;
}
- (IBAction)sureButtAction:(UIButton *)sender {
    self.backGrayView.hidden=YES;
    self.telephoneAlertView.hidden=YES;
    [[UtilitiesHelper shareHelper] dialTelephoneNum:@"4006010550"];
}

#pragma mark
#pragma mark-------weChatButtAction
-(void)showWeChatViewButtAction:(UIButton*)weChatButt
{
    self.weChatAlertView.hidden=NO;
    self.backGrayView.hidden=NO;
}
- (IBAction)closedButtAction:(id)sender {
    self.backGrayView.hidden=YES;
    self.weChatAlertView.hidden=YES;
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
