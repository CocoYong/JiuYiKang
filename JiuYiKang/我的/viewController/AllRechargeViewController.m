//
//  AllRechargeViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AllRechargeViewController.h"
#import "AllRechargeCell.h"
#import "AllRechargeModel.h"
#import "UILabel+Universal.h"
#import "PlanCauseViewController.h"
#import "MembershipViewController.h"
#import "HealthRequireViewController.h"
#import "WeiXinPayModel.h"
#import "WeiXinPayManager.h"
@interface AllRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    AllRechargeModel *allRechargeModel;
    UIButton *markButt;
    NSInteger selectRowNum;
    CGFloat moneyNum;
    WeiXinPayModel *payModel;
    ConfigeListModel*markListModel;
}
@property (weak, nonatomic) IBOutlet UITableView *allChargeTableView;
@property (weak, nonatomic) IBOutlet UIView *noProjectBgView;
@property(strong,nonatomic)UIView *footerView;
@property(nonatomic,strong)UIButton *checkButt;

@end

@implementation AllRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectRowNum=0;
     [self creatBackNavigationItem];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestDataFromService];
}


-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/recharge" params:paramsDic block:^(NSObject *result) {
        allRechargeModel=[AllRechargeModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (allRechargeModel.joinListArray.count==0) {
                self.noProjectBgView.hidden=NO;
                self.allChargeTableView.hidden=YES;
            }else
            {
             self.noProjectBgView.hidden=YES;
             self.allChargeTableView.hidden=NO;
            self.allChargeTableView.tableFooterView=self.footerView;
             [self.allChargeTableView reloadData];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(UIView*)footerView
{
    if (_footerView==nil)
    {
        _footerView=[[UIView alloc]init];
        //灰色条
        UIImageView *grayTiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        grayTiao.image=[UIImage imageNamed:@"huisetiao"];
        [_footerView addSubview:grayTiao];
        
        //说明label
        UILabel *introLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREENWIDTH, 21)];
        introLabel.attributedText=[UILabel createAttributStringWithOriginalString:[NSString stringWithFormat:@"已选0个计划，每个计划充值0元"] specialTextArray:@[@"0",@"0"] andAttributs:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        introLabel.tag=33345;
        [_footerView addSubview:introLabel];
        
        //创建按钮backView
        UIView *buttBackView=[[UIView alloc]init];
        [_footerView addSubview:buttBackView];
        
        //创建按钮
        CGFloat buttWidth=(SCREENWIDTH-40)/3;
        NSInteger  rowNum=floor((allRechargeModel.configeListArray.count-1)/3)+1;
        if (allRechargeModel.configeListArray.count!=0)
        {
            for (int i=0; i<rowNum; i++)
            {
                NSInteger tempMark;
                if (i==rowNum-1) {
                    tempMark=allRechargeModel.configeListArray.count-(rowNum-1)*3;
                }else
                {
                    tempMark=3;
                }
                for (int j=0; j<tempMark; j++)
                {
                     ConfigeListModel*listModel=[allRechargeModel.configeListArray objectAtIndex:i*3+j];
                    UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
                    butt.frame=CGRectMake((buttWidth+10)*j+10, 10+50*i, buttWidth, 40);
                    [butt setBackgroundImage:[UIImage imageNamed:@"btn_6"] forState:UIControlStateNormal];
                     [butt setBackgroundImage:[UIImage imageNamed:@"btn_5"] forState:UIControlStateSelected];
                    [butt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                    [butt setTitle:[NSString stringWithFormat:@"%@元",listModel.money] forState:UIControlStateNormal];
                    [butt setTitle:[NSString stringWithFormat:@"%@元",listModel.money] forState:UIControlStateSelected];
                    butt.tag=(i*3+j)+700;
                    [butt addTarget:self action:@selector(moneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                    [buttBackView addSubview:butt];
                }
            }
        }
        buttBackView.frame=CGRectMake(0, 40, SCREENWIDTH, rowNum*50+10);
        
        
        
        //灰色条
        UIImageView *huiseTiao=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttBackView.frame), SCREENWIDTH, 10)];
        huiseTiao.image=[UIImage imageNamed:@"huisetiao"];
        [_footerView addSubview:huiseTiao];
        
        _checkButt=[UIButton buttonWithType:UIButtonTypeCustom];
        [_checkButt setBackgroundImage:[UIImage imageNamed:@"xz_icon"] forState:UIControlStateNormal];
        [_checkButt setBackgroundImage:[UIImage imageNamed:@"xz_icon2"] forState:UIControlStateSelected];
        _checkButt.frame=CGRectMake(10, CGRectGetMaxY(huiseTiao.frame)+30, 20, 20);
        [_checkButt addTarget:self action:@selector(agreeProtocolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_checkButt];
        
        UILabel *agreeLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMidY(_checkButt.frame)-10, 43, 21)];
        agreeLabel.font=[UIFont systemFontOfSize:14];
        agreeLabel.text=@"我同意";
        [_footerView addSubview:agreeLabel];
        
        
        UIButton *jiankangyaoqiu=[UIButton buttonWithType:UIButtonTypeCustom];
        jiankangyaoqiu.frame=CGRectMake(CGRectGetMaxX(agreeLabel.frame)-8, CGRectGetMidY(_checkButt.frame)-15, 86, 30);
        jiankangyaoqiu.tag=111;
        [jiankangyaoqiu setTitle:@"《健康要求》" forState:UIControlStateNormal];
        jiankangyaoqiu.titleLabel.font=[UIFont systemFontOfSize:14];
        [jiankangyaoqiu setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [jiankangyaoqiu addTarget:self action:@selector(threeProtocolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:jiankangyaoqiu];
        
        UIButton *huiyuangongyue=[UIButton buttonWithType:UIButtonTypeCustom];
        huiyuangongyue.frame=CGRectMake(CGRectGetMaxX(jiankangyaoqiu.frame)-12, CGRectGetMidY(_checkButt.frame)-15, 86, 30);
        huiyuangongyue.tag=222;
        [huiyuangongyue setTitle:@"《会员公约》" forState:UIControlStateNormal];
        huiyuangongyue.titleLabel.font=[UIFont systemFontOfSize:14];
        [huiyuangongyue setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

        [huiyuangongyue addTarget:self action:@selector(threeProtocolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:huiyuangongyue];
        
        UILabel *jiLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(huiyuangongyue.frame)-8, CGRectGetMidY(huiyuangongyue.frame)-10, 15, 21)];
        jiLabel.font=[UIFont systemFontOfSize:14];
        jiLabel.text=@"及";
        [_footerView addSubview:jiLabel];


        UIButton *jihuatiaokuan=[UIButton buttonWithType:UIButtonTypeCustom];
        jihuatiaokuan.frame=CGRectMake(CGRectGetMaxX(jiLabel.frame)-8, CGRectGetMidY(_checkButt.frame)-15, 86, 30);
        jihuatiaokuan.tag=333;
        [jihuatiaokuan setTitle:@"《计划条款》" forState:UIControlStateNormal];
        [jihuatiaokuan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

        jihuatiaokuan.titleLabel.font=[UIFont systemFontOfSize:14];
        [jihuatiaokuan addTarget:self action:@selector(threeProtocolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:jihuatiaokuan];

        
        UIButton *submitButt=[UIButton buttonWithType:UIButtonTypeCustom];
        submitButt.frame=CGRectMake(10, CGRectGetMaxY(_checkButt.frame)+30, SCREENWIDTH-20,40);
        submitButt.tag=12345;
        [submitButt setTitle:@"用微信支付0元" forState:UIControlStateNormal];
        [submitButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitButt setBackgroundImage:[UIImage imageNamed:@"btn_8"] forState:UIControlStateNormal];
        [submitButt addTarget:self action:@selector(submittButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        submitButt.titleLabel.font=[UIFont systemFontOfSize:20];
        [_footerView addSubview:submitButt];
        
        _footerView.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(submitButt.frame)+40);
    }
    return _footerView;
}


#pragma mark
#pragma mark -----buttAction
- (IBAction)joinProjectButtAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//钱数按钮。。。。。
- (void)moneyButtonAction:(UIButton *)butt {
    markButt.selected=NO;
    butt.selected=YES;
    markButt=butt;
    NSString *titleString=butt.titleLabel.text;
    moneyNum=[titleString floatValue];
    markListModel=[allRechargeModel.configeListArray objectAtIndex:butt.tag-700];
    UILabel *stateLabel=(UILabel*)[self.footerView viewWithTag:33345];
    NSString *selectItemNumString=[NSString stringWithFormat:@"%ld",selectRowNum];
    NSString *selectMoneyString=[NSString stringWithFormat:@"%.2f",moneyNum];
    NSString *originalString=[NSString stringWithFormat:@"已选%@个计划，每个计划充值%@元",selectItemNumString,selectMoneyString];
    stateLabel.attributedText=[UILabel createAttributStringWithOriginalString:originalString specialTextArray:@[selectItemNumString,selectMoneyString] andAttributs:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIButton *tempButt=(UIButton*)[self.footerView viewWithTag:12345];
    [tempButt setTitle:[NSString stringWithFormat:@"用微信支付%.2f元", moneyNum*selectRowNum] forState:UIControlStateNormal];
    
}
- (void)threeProtocolButtonAction:(UIButton *)sender
{
    if (sender.tag==111) {
        HealthRequireViewController *healthRequireController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"HealthRequireViewController"];
        [self showViewController:healthRequireController sender:nil];
    }
    if (sender.tag==222) {
        MembershipViewController *membershipController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MembershipViewController"];
        [self showViewController:membershipController sender:nil];
    }if (sender.tag==333){
        PlanCauseViewController *planCauseController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"PlanCauseViewController"];
        planCauseController.productID=@"1";
        [self showViewController:planCauseController sender:nil];
    }

}
- (void)agreeProtocolButtonAction:(UIButton *)sender {
    sender.selected=!sender.selected;
}
- (void)submittButtonAction:(UIButton *)sender {
    if (!self.checkButt.selected) {
        [MBProgressHUD show:@"请同意并勾选协议" view:self.view time:1.5];
        return;
    }
    if (markListModel==nil) {
        [MBProgressHUD show:@"请选择充值金额" view:self.view time:1.5];
        return;
    }
    NSMutableString *idString=[NSMutableString string];
    for (int i=0; i<allRechargeModel.joinListArray.count; i++) {
         JoinListModel *listModel=[allRechargeModel.joinListArray objectAtIndex:i];
        if (listModel.selected) {
            [idString appendFormat:@"%@,",listModel.listID];
        }
    }
    if (idString.length==0) {
        [MBProgressHUD show:@"请至少选择一个充值计划" view:self.view time:1.5];
        return;
    }
    NSString *newString=[idString substringToIndex:idString.length-1];
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"join_ids":newString,@"money_recharge_id":markListModel.configeID};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/join_recharge" params:paramsDic block:^(NSObject *result) {
        payModel=[WeiXinPayModel mj_objectWithKeyValues:result];
        NSDictionary *tempDic=(NSDictionary*)result;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([payModel.code isEqualToString:@"0"]) {
                [self payJumpToWeiXin:[tempDic objectForKey:@"data"]];
            }else
            {
                [MBProgressHUD show:payModel.msg view:self.view time:1.5];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

-(void)payJumpToWeiXin:(NSDictionary*)dic
{
    [[WeiXinPayManager sharedManager] payForWeiXin:dic andDelegateController:self andCallBackBlock:^(BOOL result) {
        if (result) {
            [MBProgressHUD show:@"支付成功" view:self.view time:1.5];
            [self performSelector:@selector(backToFrontViewContrller) withObject:nil afterDelay:3];
        }else
        {
            [MBProgressHUD show:@"支付失败" view:self.view time:1.5];
        }
    }];
}
-(void)backToFrontViewContrller
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//cell上的按钮点击
-(void)changeModelState:(UIButton*)butt
{
    butt.selected=!butt.selected;
    JoinListModel *listModel=[allRechargeModel.joinListArray objectAtIndex:butt.tag];
    if (butt.selected) {
        selectRowNum=selectRowNum+1;
        listModel.selected=YES;
    }else
    {
        selectRowNum=selectRowNum-1;
        listModel.selected=NO;
    }
    UILabel *stateLabel=(UILabel*)[self.footerView viewWithTag:33345];
    NSString *selectItemNumString=[NSString stringWithFormat:@"%ld",selectRowNum];
    NSString *selectMoneyString=[NSString stringWithFormat:@"%.2f",moneyNum];
    NSString *originalString=[NSString stringWithFormat:@"已选%@个计划，每个计划充值%@元",selectItemNumString,selectMoneyString];
    stateLabel.attributedText=[UILabel createAttributStringWithOriginalString:originalString specialTextArray:@[selectItemNumString,selectMoneyString] andAttributs:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    UIButton *tempButt=(UIButton*)[self.footerView viewWithTag:12345];
    [tempButt setTitle:[NSString stringWithFormat:@"用微信支付%.2f元", moneyNum*selectRowNum] forState:UIControlStateNormal];
}


#pragma mark
#pragma mark--------tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allRechargeModel.joinListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllRechargeCell" forIndexPath:indexPath];
    JoinListModel *listModel=[allRechargeModel.joinListArray objectAtIndex:indexPath.row];
    cell.nameLabel.text=listModel.join_user_name;
    cell.projectNameLabel.text=listModel.product_name;
    cell.mayBeMoneyLabel.text=listModel.money;
    cell.moneyLabel.text=listModel.money; //缺少一个字段值
    cell.checkButt.selected=listModel.selected;
    cell.checkButt.tag=indexPath.row;
    [cell.checkButt addTarget:self action:@selector(changeModelState:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
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
