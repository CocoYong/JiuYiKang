//
//  LoginViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPassWordViewController.h"
#import "RegisterViewController.h"
#import "ZYDataRequest.h"
#import "LoginModel.h"
#import "RootTabBarController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong,nonatomic) LoginModel *loginModel;
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIView *backBigView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UITapGestureRecognizer *tapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyBoard)];
    [self.backBigView addGestureRecognizer:tapGestureController];
}

-(void)resignKeyBoard
{
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma buttonAction
- (IBAction)loginButtonAction:(UIButton *)sender
{
    if (self.phoneNumTextField.text==nil||[self.phoneNumTextField.text isEqualToString:@""])
    {
        [MBProgressHUD show:@"手机号码不能为空" view:self.view time:1.5];
        return;
    }
    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.phoneNumTextField.text]) {
        [MBProgressHUD show:@"手机号码格式不正确" view:self.view time:1.5];
        return;
    }
    if (self.passwordTextField.text==nil||[self.passwordTextField.text isEqualToString:@""])
    {
        [MBProgressHUD show:@"密码不能为空" view:self.view time:1.5];
        return;
    }
    [MBProgressHUD showHudInView:self.view hint:@"正在登录"];
    NSDictionary *paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text};
    [ZYDataRequest requestWithURL:@"AppApi/Account/login" params:paramsDic block:^(NSObject *result)
    {
            _loginModel=[LoginModel mj_objectWithKeyValues:result];
            if ([_loginModel.code isEqualToString:@"0"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:_loginModel.loginData.token forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] isEqualToString:_loginModel.loginData.token])
                {
                dispatch_async(dispatch_get_main_queue(), ^{
                RootTabBarController *rootTabbarController=[[RootTabBarController alloc]init];
                [UIApplication sharedApplication].delegate.window.rootViewController=rootTabbarController;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
                });
            }
        }else
        {
            [MBProgressHUD show:_loginModel.msg view:self.view time:1.5];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)registerButtAction:(UIButton *)sender
{
    RegisterViewController *registerController= [STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController showViewController:registerController sender:nil];
}
- (IBAction)forgetPasswordButtAction:(UIButton *)sender
{
   ForgetPassWordViewController *forgetPassController= [STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ForgetPassWordViewController"];
    [self.navigationController showViewController:forgetPassController sender:nil];
}
-(void)backToFrontViewContrller
{
    RootTabBarController *rootTabbarController=[[RootTabBarController alloc]init];
    [UIApplication sharedApplication].delegate.window.rootViewController=rootTabbarController;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
