//
//  ChangeAddressController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ChangeAddressController.h"
#import "UniversalModel.h"
#import "AdressPickerView.h"
#import "RootTabBarController.h"
#import "MineAddressModel.h"
@interface ChangeAddressController ()
{
    UniversalModel *commonModel;
    MineAddressModel *addressModel;
}
//修改地址
@property (weak, nonatomic) IBOutlet UIView *locationBgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailDressTextField;
@property (weak, nonatomic) IBOutlet UITextField *postCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@end

@implementation ChangeAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.provinceLabel.layer.cornerRadius=5;
    self.provinceLabel.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"].CGColor;
    self.provinceLabel.layer.borderWidth=0.5;
    UITapGestureRecognizer *tapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyBoard)];
      [self.locationBgView addGestureRecognizer:tapGestureController];
    [self  requestDataFromService];
}
-(void)resignKeyBoard
{
    for (UIView *view in self.locationBgView.subviews) {
        if ([view isMemberOfClass:[UITextField class]]) {
            [view resignFirstResponder];
        }
    }
}
- (IBAction)provinceButtAction:(UIButton *)sender
{
    TABBARCONTROLLER.tabBarView.hidden=YES;
   AdressPickerView *addressPicker=[[AdressPickerView alloc]initWithFrame:CGRectZero andPickerBlock:^(NSDictionary *pickerDic) {
       self.provinceLabel.text=[NSString stringWithFormat:@"%@%@%@",[pickerDic objectForKey:@"sheng"],[pickerDic objectForKey:@"shi"],[pickerDic objectForKey:@"xian"]];
       self.provinceLabel.textColor=[UIColor darkGrayColor];
   }];
    [self.view addSubview:addressPicker];
}

-(IBAction)saveAdressButtAction:(UIButton*)sender
{
    if (self.nameTextField.text==nil||[self.nameTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"收件人不能为空" view:self.view time:1.5];
        return;
    }
    if (self.telephoneNumTextField.text==nil||[self.telephoneNumTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"收件人手机号不能为空" view:self.view time:1.5];
        return;
    }
    if (![[UtilitiesHelper shareHelper] validatePhoneMobile:self.telephoneNumTextField.text]) {
        [MBProgressHUD show:@"手机号码格式不正确" view:self.view time:1.5];
        return;
    }

    if (self.provinceLabel.text==nil||[self.provinceLabel.text isEqualToString:@""]) {
        [MBProgressHUD show:@"所在省不能为空" view:self.view time:1.5];
        return;
    }
    if (self.detailDressTextField.text==nil||[self.detailDressTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"详细地址不能为空" view:self.view time:1.5];
        return;
    }
    if (self.postCodeTextField.text==nil||[self.postCodeTextField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"邮编不能为空" view:self.view time:1.5];
        return;
    }
    NSDictionary *paramsDic=@{@"mobile":self.telephoneNumTextField.text,@"user_name":self.nameTextField.text,@"province_city_district":self.provinceLabel.text,@"address_detail":self.detailDressTextField.text,@"post_code":self.postCodeTextField.text,@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/address" params:paramsDic block:^(NSObject *result) {
        commonModel=[UniversalModel mj_objectWithKeyValues:result];
        if ([commonModel.code isEqualToString:@"0"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
               [MBProgressHUD show:@"修改地址成功" view:self.view time:1.5];
                [self performSelector:@selector(backToFrontViewContrller) withObject:nil afterDelay:3];
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
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/address" params:paramsDic block:^(NSObject *result) {
        addressModel=[MineAddressModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameTextField.text=addressModel.user_name;
            self.telephoneNumTextField.text=addressModel.mobile;
            self.provinceLabel.text=addressModel.province_city_district;
            self.provinceLabel.textColor=[UIColor blackColor];
            self.detailDressTextField.text=addressModel.address_detail;
            self.postCodeTextField.text=addressModel.post_code;
        });
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
