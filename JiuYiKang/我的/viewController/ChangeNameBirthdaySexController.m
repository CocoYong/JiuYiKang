//
//  ChangeNameBirthdaySexController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//修改用户名 生日和性别

#import "ChangeNameBirthdaySexController.h"
#import "NSDate+FSExtension.h"
#import "UniversalModel.h"
#import "RootTabBarController.h"
@interface ChangeNameBirthdaySexController ()<UIActionSheetDelegate,UITextFieldDelegate>
{
    UniversalModel *model;
    NSDate *pickerSelectDate;
}
@property (weak, nonatomic) IBOutlet UIView *userNameBgView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;


@property (weak, nonatomic) IBOutlet UIView *sexBgView;
@property (weak, nonatomic) IBOutlet UIButton *manButt;
@property (weak, nonatomic) IBOutlet UIButton *womanButt;


@property (weak, nonatomic) IBOutlet UIView *birthdayBgView;
@property (weak, nonatomic) IBOutlet UIView *datePickerBackView;
@property (weak, nonatomic) IBOutlet UILabel *showDateLabel;


@end

@implementation ChangeNameBirthdaySexController
- (void)viewDidLoad {
    [super viewDidLoad];
   [self creatBackNavigationItem];
    self.showDateLabel.layer.cornerRadius=5;
    self.showDateLabel.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"].CGColor;
    self.showDateLabel.layer.borderWidth=0.5;
    if ([self.pageIdentifier isEqualToString:@"用户名"]) {
        self.sexBgView.hidden=YES;
        self.birthdayBgView.hidden=YES;
        self.userNameBgView.hidden=NO;
        self.userNameTextField.text=self.universalString;
    }else if ([self.pageIdentifier isEqualToString:@"生日"])
    {
        self.sexBgView.hidden=YES;
        self.birthdayBgView.hidden=NO;
        self.userNameBgView.hidden=YES;
        self.showDateLabel.text=[NSString stringWithFormat:@"  %@",self.universalString];
    }else
    {
        self.sexBgView.hidden=NO;
        self.birthdayBgView.hidden=YES;
        self.userNameBgView.hidden=YES;
        if ([self.universalString isEqualToString:@"男"]) {
            self.manButt.selected=YES;
        }else
        {
            self.womanButt.selected=YES;
        }
    }
}
#pragma mark
#pragma   mark---------changeBirthday
- (IBAction)showDatePickerViewButtAction:(UIButton *)sender
{
    self.datePickerBackView.hidden=NO;
    TABBARCONTROLLER.tabBarView.hidden=YES;
}
- (IBAction)datePickerAction:(UIDatePicker *)sender
{
    pickerSelectDate=sender.date;
}
- (IBAction)datePickerSureButtAction:(UIButton *)sender
{
    self.datePickerBackView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
    NSDateFormatter  *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.showDateLabel.text=[NSString stringWithFormat:@"   %@",[formatter stringFromDate:pickerSelectDate]];
}
- (IBAction)datePickerCancelButtAction:(UIButton *)sender
{
    pickerSelectDate=nil;
    self.datePickerBackView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
}
- (IBAction)birthdayButtAction:(UIButton *)sender
{
    NSString *dateString=[self.showDateLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self requestDataFromServiceWithUrl:@"AppApi/Ucenter/profile_birthday" andChangeItem:dateString==nil?@"":dateString andItemKey:@"birthday"];
}

#pragma mark
#pragma mark------- changeUserName
- (IBAction)saveUserNameAction:(UIButton *)sender
{
     [self requestDataFromServiceWithUrl:@"AppApi/Ucenter/profile_user_name" andChangeItem:self.userNameTextField.text==nil?@"":self.userNameTextField.text andItemKey:@"user_name"];

}
#pragma mark
#pragma mark--------changeSex
- (IBAction)manbuttAction:(UIButton *)sender {
    sender.selected=YES;
    self.womanButt.selected=NO;
}
- (IBAction)womanButtAction:(UIButton *)sender {
    sender.selected=YES;
    self.manButt.selected=NO;
}
- (IBAction)saveSexButtAction:(UIButton *)sender
{
    [self requestDataFromServiceWithUrl:@"AppApi/Ucenter/profile_sex" andChangeItem:self.manButt.selected?@"1":@"2" andItemKey:@"sex"];
}
#pragma mark
#pragma  mark------postDataToService
-(void)requestDataFromServiceWithUrl:(NSString *)urlString andChangeItem:(NSString*)item andItemKey:(NSString*)paramsKey
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),paramsKey:item};
    [ZYDataRequest requestWithURL:urlString params:paramsDic block:^(NSObject *result) {
        model=[UniversalModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([model.code isEqualToString:@"0"])
            {
                [self performSelector:@selector(backToFrontViewContrller) withObject:nil];
            }else
            {
                [MBProgressHUD show:model.msg view:self.view time:1.5];
            }
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
