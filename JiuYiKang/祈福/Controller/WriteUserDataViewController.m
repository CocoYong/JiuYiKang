//
//  WriteUserDataViewController.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/12/4.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "WriteUserDataViewController.h"
#import "TakePhotoOrLibraryView.h"
#import "MineExperienceViewController.h"
#import "UserInfoModel.h"
@interface WriteUserDataViewController ()
{
    UserInfoModel *userModel;
    NSArray *typeArray;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *cardIDField;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhengJianTypeButt;


@end

@implementation WriteUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    typeArray=@[@"身份证",@"出生证"];
    _zhengJianTypeButt.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"].CGColor;
    _zhengJianTypeButt.layer.borderWidth=0.5;
    _zhengJianTypeButt.layer.cornerRadius=5;
    
}
- (IBAction)cardTypeAction:(UIButton *)sender {
    [self hideKeyBoard];
    TakePhotoOrLibraryView *pickerView=[[TakePhotoOrLibraryView alloc]initWithFrame:CGRectZero andDataSource:typeArray andCallBackBlock:^(NSString *passData, NSError *error) {
        self.cardTypeLabel.text=passData;
        self.cardTypeLabel.textColor=[UIColor blackColor];
    }];
    [pickerView showView];
}
- (IBAction)getExperiencButtAction:(UIButton *)sender
{
    if (self.nameField.text==nil||[self.nameField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"姓名未填写" view:self.view time:3];
        return;
    }
    if (self.cardIDField.text==nil||[self.cardIDField.text isEqualToString:@""]) {
        [MBProgressHUD show:@"证件号码未填写" view:self.view time:3];
        return;
    }
    if ([self.cardTypeLabel.text isEqualToString:@"身份证"]) {
     [self uploadUserDataForGetExperienceProduct:self.nameField.text andCardId:@"0" andCardNum:self.cardIDField.text];
    }else
    {
       [self uploadUserDataForGetExperienceProduct:self.nameField.text andCardId:@"1" andCardNum:self.cardIDField.text];
    }
    
}

-(void)hideKeyBoard
{
    [self.nameField resignFirstResponder];
    [self.cardIDField resignFirstResponder];
}

#pragma mark  - ---requestService
-(void)uploadUserDataForGetExperienceProduct:(NSString*)userName andCardId:(NSString*)cardID andCardNum:(NSString*)cardNum
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"user_name":userName,@"card_type":cardID,@"card_number":cardNum};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/get_free_product" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"]integerValue]==0) {
            [self requestDataFromService];
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
            MineExperienceViewController *experienceController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"MineExperienceViewController"];
            experienceController.model=userModel;
            experienceController.showType=@"1";
            experienceController.fromController=@"WriteUserDataViewController";
            [self showViewController:experienceController sender:nil];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
@end
