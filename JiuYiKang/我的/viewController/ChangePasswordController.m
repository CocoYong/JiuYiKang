//
//  ChangePasswordController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ChangePasswordController.h"
#import "UniversalModel.h"
#import "LoginNavController.h"
#import "CountNumView.h"
@interface ChangePasswordController ()
{
    BOOL  keyboardStatus;
    UniversalModel *commonModel;
}
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIView *passwordBgView;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *telephoneNumLabel;
@property(strong,nonatomic) CountNumView *countNumView;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    self.telephoneNumLabel.text=self.telephoneNum;
    //倒计时
    _countNumView=[[CountNumView alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, CGRectGetMidY(self.verifyCodeTextField.frame)-20, 90, 40) andCallBack:^(UILabel *textLabel, UIButton *butt) {
        [self getVerifyCodeAction:butt];
    }];
    [self.passwordBgView addSubview:_countNumView];
    
    UITapGestureRecognizer *tapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyBoard)];
    [self.passwordBgView addGestureRecognizer:tapGestureController];
}

-(void)resignKeyBoard
{
    for (UIView *view in self.passwordBgView.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}
- (void)getVerifyCodeAction:(UIButton *)sender {
    NSDictionary *paramsDic=@{@"mobile":self.telephoneNumLabel.text};
    [ZYDataRequest requestWithURL:@"Api/Sms/resetPsd" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([commonModel.code isEqualToString:@"0"]) {
                [_countNumView creatAndStartTimer];
                [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
            }else
            {
                [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
                
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

- (IBAction)changePasswordAction:(UIButton *)sender {
    if (self.verifyCodeTextField.text==nil||[self.verifyCodeTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"验证码不能为空" view:self.view time:1.5];
        return;
    }
    if (self.passwordTextField.text==nil||[self.passwordTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"密码不能为空" view:self.view time:1.5];
        return;
    }
    if (![self.verifyPasswordTextField.text isEqualToString:self.passwordTextField.text]||self.verifyPasswordTextField.text==nil||[self.verifyPasswordTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"两次输入密码不一致" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic=@{@"mobile":self.telephoneNumLabel.text,@"password":self.passwordTextField.text,@"verification":self.verifyCodeTextField.text};
    [ZYDataRequest requestWithURL:@"/Api/Account/resetPsd" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        if ([commonModel.code isEqualToString:@"0"])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                LoginNavController *login=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
                [UIApplication sharedApplication].delegate.window.rootViewController=login;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            });
        }else
        {
            [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
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
