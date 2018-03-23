//
//  ChangeTelephoneNumController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/7.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ChangeTelephoneNumController.h"
#import "CountNumView.h"
#import "UniversalModel.h"
@interface ChangeTelephoneNumController ()
{
    UniversalModel *commonModel;
}
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumField;
@property (weak, nonatomic) IBOutlet UITextField *verifyNumField;
@property(nonatomic,strong)CountNumView*countNumView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ChangeTelephoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    CGFloat verifFieldY=self.verifyNumField.frame.origin.y;
    _countNumView=[[CountNumView alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, verifFieldY, 90, 40) andCallBack:^(UILabel *textLabel,UIButton *butt) {
        [self getVerifyCodeAction];
    }];
    [self.backView addSubview:_countNumView];
}
-(void)getVerifyCodeAction
{
    if (self.telephoneNumField.text==nil||[self.telephoneNumField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"请输入手机号" view:self.view time:1.5];
        return;
    }
    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.telephoneNumField.text]) {
        [MBProgressHUD show:@"手机号码格式不正确" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic=@{@"mobile":self.telephoneNumField.text};
    [ZYDataRequest requestWithURL:@"Api/Sms/register" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        if ([commonModel.code isEqualToString:@"0"]) {
            [_countNumView creatAndStartTimer];
            [MBProgressHUD show:@"验证码已经发送成功" view:self.view time:1.5];
        }else{
            [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (IBAction)changePhoneNumAction:(UIButton *)sender {
    if (self.telephoneNumField.text==nil||[self.telephoneNumField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"请输入手机号" view:self.view time:1.5];
        return;
    }
 
    if (self.verifyNumField.text==nil||[self.verifyNumField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"请输入手机收到的验证码" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic=@{@"mobile":self.telephoneNumField.text,@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"mobile_sms_code":self.verifyNumField.text};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/profile_mobile" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        if ([commonModel.code isEqualToString:@"0"]) {
            [MBProgressHUD show:@"修改手机号成功" view:self.view time:1.5];
            [self performSelector:@selector(backToFrontViewContrller) withObject:nil afterDelay:3];
        }else{
            [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接" view:self.view time:1.5];
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
