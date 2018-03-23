//
//  DepositViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "DepositViewController.h"
#import "UniversalModel.h"
@interface DepositViewController ()
@property (weak, nonatomic) IBOutlet UITextField *moneyNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *acountNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankLocalNameTextField;

@end

@implementation DepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.moneyNumTextField.text=self.despositMoney;

}


-(void)requestDataFromService
{
    if (self.moneyNumTextField.text==nil||[self.moneyNumTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"可提现金额不能为空" view:self.view time:1.5];
        return;
    }
    if ([self.moneyNumTextField.text floatValue]>[self.despositMoney floatValue]) {
        [MBProgressHUD show:@"填写金额大于可提现金额了" view:self.view time:1.5];
        return;
    }
    if (self.bankNameTextField.text==nil||[self.bankNameTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"银行不能为空" view:self.view time:1.5];
        return;
    }
    if (self.bankLocalNameTextField.text==nil||[self.bankLocalNameTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"开户行不能为空" view:self.view time:1.5];
        return;
    }
    if (self.acountNumberTextField.text==nil||[self.acountNumberTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"银行卡账号不能为空" view:self.view time:1.5];
        return;
    }
    if (self.nameTextField.text==nil||[self.nameTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"持卡人姓名不能为空" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"money":self.moneyNumTextField.text,@"bank_name":self.bankNameTextField.text,@"bank_name_sub":self.bankLocalNameTextField.text,@"use_bank":self.acountNumberTextField.text,@"bank_card_user_name":self.nameTextField.text,};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/withdraw" params:paramsDic block:^(NSObject *result) {
        UniversalModel *model=[UniversalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
       [MBProgressHUD showError:model.msg toView:self.view];
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
}
#pragma buttonAction
- (IBAction)commitButtAction:(UIButton *)sender
{
    [self requestDataFromService];
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
