//
//  RegisterViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterProtocolViewController.h"
#import "UniversalModel.h"
#import "CountNumView.h"
#import "LoginModel.h"
#import "RootTabBarController.h"
#import "ExperienceViewController.h"
@interface RegisterViewController ()
{
    BOOL  keyboardStatus;
    UniversalModel *commonModel;
}
@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIView *backBigView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageVerifyTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *yaoqingMaTextField;
@property (weak, nonatomic) IBOutlet UIButton *haveAcountButt;
@property (strong, nonatomic)CountNumView *countNumView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatBackNavigationItem];
    
    _countNumView=[[CountNumView alloc]initWithFrame:CGRectMake(SCREENWIDTH-100, CGRectGetMidY(self.messageVerifyTextField.frame)-20, 90, 40) andCallBack:^(UILabel *textLabel,UIButton *butt) {
        [self getVerifyCodeAction:butt];
    }];
    [self.backBigView addSubview:_countNumView];
    UITapGestureRecognizer *tapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyBoard)];
    [self.backBigView addGestureRecognizer:tapGestureController];
    if (SCREENHEIGHT==480){
        self.backgroundScrollView.contentSize=CGSizeMake(SCREENWIDTH, self.haveAcountButt.frame.origin.y+self.haveAcountButt.frame.size.height+100);
    }
    
}

-(void)resignKeyBoard
{
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.verifyPasswordTextfield resignFirstResponder];
    [self.messageVerifyTextField resignFirstResponder];
    [self.yaoqingMaTextField resignFirstResponder];
}



- (void)getVerifyCodeAction:(UIButton *)sender
{
    if (self.phoneNumTextField.text==nil||[self.phoneNumTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"请输入手机号" view:self.view time:1.5];
        return;
    }
//    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.phoneNumTextField.text]) {
//        [MBProgressHUD show:@"手机号码格式不正确" view:self.view time:1.5];
//        return;
//    }
    [MBProgressHUD showHudInView:self.view hint:@"正在发送验证码"];
    NSDictionary *paramsDic=@{@"mobile":self.phoneNumTextField.text};
    [ZYDataRequest requestWithURL:@"Api/Sms/register" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
        if ([commonModel.code isEqualToString:@"0"]) {
            [_countNumView creatAndStartTimer];
            [MBProgressHUD show:@"验证码已经发送成功" view:self.view time:1.5];
        }else{
            [MBProgressHUD show:commonModel.msg view:self.view time:1.5];
        }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (IBAction)registerAction:(UIButton *)sender
{
    if (self.phoneNumTextField.text==nil||[self.phoneNumTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"手机号码不能为空" view:self.view time:1.5];
        return;
    }
    if (self.messageVerifyTextField.text==nil||[self.messageVerifyTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"验证码不能为空" view:self.view time:1.5];
        return;
    }
    if (self.passwordTextField.text==nil||[self.passwordTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"密码不能为空" view:self.view time:1.5];
        return;
    }
    if (![self.verifyPasswordTextfield.text isEqualToString:self.passwordTextField.text]||self.verifyPasswordTextfield.text==nil||[self.verifyPasswordTextfield.text isEqualToString:@""]) {
        [MBProgressHUD show:@"两次输入密码不一致" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic;
    if ((self.yaoqingMaTextField.text!=nil&&![self.yaoqingMaTextField.text isEqualToString:@""])) {
        if (self.tickit==nil) {
paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text,@"mobile_sms_code":self.messageVerifyTextField.text,@"id_str":self.yaoqingMaTextField.text};
        }else
        {
paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text,@"mobile_sms_code":self.messageVerifyTextField.text,@"id_str":self.yaoqingMaTextField.text,@"free_product_ticket":self.tickit};
        }
    }else
    {
        if (self.tickit==nil) {
paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text,@"mobile_sms_code":self.messageVerifyTextField.text};
        }else
        {
paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text,@"mobile_sms_code":self.messageVerifyTextField.text,@"free_product_ticket":self.tickit};
        }
    }
    [ZYDataRequest requestWithURL:@"AppApi/Account/regist" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        if ([commonModel.code isEqualToString:@"0"]) {
           [self autoLoginAction];
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
- (IBAction)protocolAction:(UIButton *)sender {
    RegisterProtocolViewController *protocolController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"RegisterProtocolViewController"];
    [self showViewController:protocolController sender:nil];
}
- (IBAction)backLoginAction:(UIButton *)sender
{
    if ([self.fromType isEqualToString:@"detailControleler"]) {
        UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
        [UIApplication sharedApplication].delegate.window.rootViewController=navcontroller;
    }else
    {
     [self backToFrontViewContrller];
    }
    
}
-(void)autoLoginAction
{
    NSDictionary *paramsDic=@{@"mobile":self.phoneNumTextField.text,@"password":self.passwordTextField.text};
    [ZYDataRequest requestWithURL:@"AppApi/Account/login" params:paramsDic block:^(NSObject *result)
     {
         LoginModel *_loginModel=[LoginModel mj_objectWithKeyValues:result];
         if ([_loginModel.code isEqualToString:@"0"])
         {
             [[NSUserDefaults standardUserDefaults] setObject:_loginModel.loginData.token forKey:@"token"];
             [[NSUserDefaults standardUserDefaults] synchronize];
             if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] isEqualToString:_loginModel.loginData.token])
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if ([self.fromType isEqualToString:@"detailControleler"]) {
                         ExperienceViewController *experienceController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"ExperienceViewController"];
                         experienceController.token=_loginModel.loginData.token;
                         [self showViewController:experienceController sender:nil];
                     }else
                     {
                         RootTabBarController *rootTabbarController=[[RootTabBarController alloc]init];
                         [UIApplication sharedApplication].delegate.window.rootViewController=rootTabbarController;
                         [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
                     }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{    keyboardStatus=YES;
    self.backgroundScrollView.contentSize=CGSizeMake(SCREENWIDTH, SCREENHEIGHT+300);
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    keyboardStatus=NO;
    self.backgroundScrollView.contentSize=CGSizeMake(SCREENWIDTH, SCREENHEIGHT);
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (keyboardStatus) {
        self.backgroundScrollView.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-216);
    }else{
        self.backgroundScrollView.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    }
    [self.view layoutIfNeeded];
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
