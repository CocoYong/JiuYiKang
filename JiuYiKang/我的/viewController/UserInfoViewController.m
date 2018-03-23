//
//  UserInfoViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "ChangeNameBirthdaySexController.h"
#import "ChangeTelephoneNumController.h"
#import "ChangePasswordController.h"
#import "ChangeAddressController.h"
#import "UserInfoModel.h"
#import "LoginNavController.h"
#import "ImageModel.h"
#import "UniversalModel.h"
#import "UIImageView+WebCache.h"
#import "RootTabBarController.h"
#import "UIImageView+WebCache.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *titleArray;

}
@property(nonatomic,strong)UserInfoModel *userInfoModel;
@property (weak, nonatomic) IBOutlet UITableView *userinfoTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *photoAlertView;
@property (weak, nonatomic) IBOutlet UIView *logoutAlertView;
@property (weak, nonatomic) IBOutlet UIView *takePhotoAlertView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.photoImageView.layer.cornerRadius=40;
    self.photoImageView.layer.borderWidth=4;
    self.logoutAlertView.layer.cornerRadius=5;
    self.logoutAlertView.clipsToBounds=YES;
    self.photoImageView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#E4E5E6"].CGColor;
    [self.photoImageView setClipsToBounds:YES];
    titleArray=@[@"用户名",@"手机号",@"生日",@"年龄",@"性别",@"修改密码",@"收货地址",@"退出登录"];
    self.userinfoTableView.tableFooterView=[UIView new];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [self requestDataFromService];
}
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/my_info" params:paramsDic block:^(NSObject *result) {
        _userInfoModel=[UserInfoModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:_userInfoModel.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]] placeholderImage:[UIImage imageNamed:@"tx2"] options:SDWebImageRefreshCached];
            [self.userinfoTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
- (IBAction)cameraTakePhotoButtAction:(UIButton *)sender {
    self.photoAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        if (sender.tag==11) {
         imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
          imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
       [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (IBAction)cancelButtAction:(id)sender {
    self.photoAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
}
- (IBAction)sureLogoutButt:(UIButton *)sender {
   self.photoAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    LoginNavController *login=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
    [UIApplication sharedApplication].delegate.window.rootViewController=login;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}
- (IBAction)cancelLogoutButt:(UIButton *)sender {
    self.photoAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
}
- (IBAction)iamgeButtClicked:(UIButton *)sender
{
    self.photoAlertView.hidden=NO;
    self.takePhotoAlertView.hidden=NO;
    self.logoutAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=YES;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *imageEdit = [info objectForKey:UIImagePickerControllerEditedImage];
        ImageModel *imageObject = [[ImageModel alloc] init];

        imageObject.originalImage =imageOriginal;
        imageObject.cutImage =imageEdit;
        
        imageObject.cutImageData=UIImageJPEGRepresentation(imageObject.cutImage, 0);
        NSString *urlString = [NSString stringWithFormat:@"%@",[info objectForKey:UIImagePickerControllerReferenceURL]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *newTempUrl = @"";
        NSRange range = [urlString rangeOfString:@"PNG"];
        if (range.length) {
            newTempUrl = [NSString stringWithFormat:@"%@.png",str];
            imageObject.type=@"image/png";
        }else{
            newTempUrl = [NSString stringWithFormat:@"%@.jpg",str];
            imageObject.type=@"image/jpg";
        }
        imageObject.imageName = newTempUrl;
        [self uploadImageToService:imageObject];
    }];
}
-(void)uploadImageToService:(ImageModel*)imageModel
{
    NSDictionary *parames=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"upload_file":imageModel.imageName};
    [ZYDataRequest uploadFileToServiceWithUrl:@"AppApi/Org/upload"  andFileNamed:@"upload_file"
                                      andName:imageModel.imageName andFileData:imageModel.cutImageData params:parames block:^(NSObject *result) {
                                          NSDictionary *dict=(NSDictionary*)result;
                                          NSString *imageUrl=[[dict objectForKey:@"data"] objectForKey:@"file"];
                                          [self sythesizeImageToService:imageUrl];
                                      } errorBlock:^(NSError *error) {
                                          
                                      } noNetWorking:^(NSString *noNetWorking) {
                                          
                                      }];
    
}
-(void)sythesizeImageToService:(NSString*)imageUrl
{
    NSDictionary *parames=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"face_uri":imageUrl};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/profile_face_uri" params:parames block:^(NSObject *result) {
        UniversalModel *model=[UniversalModel mj_objectWithKeyValues:result];
        if ([model.code isEqualToString:@"0"]) {
            [self viewWillAppear:YES];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
#pragma tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text=[titleArray objectAtIndex:indexPath.row];
    if (indexPath.row<5) {
        if (indexPath.row==0) {
            cell.infoLabel.text=_userInfoModel.user_name;
        }else if (indexPath.row==1)
        {
           cell.infoLabel.text=_userInfoModel.mobile;
        }else if (indexPath.row==2)
        {
           cell.infoLabel.text=_userInfoModel.birthday;
        }else if (indexPath.row==3)
        {
           cell.infoLabel.text=_userInfoModel.age;
        }else
        {
           cell.infoLabel.text=[_userInfoModel.sex isEqualToString:@"2"]?@"女":@"男";
        }
    }else{
        cell.infoLabel.text=@"";
    }
   
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ChangeNameBirthdaySexController *changeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ChangeNameBirthdaySexController"];
            changeController.pageIdentifier=@"用户名";
            changeController.universalString=_userInfoModel.user_name;
            [self showViewController:changeController sender:nil];
        }
            break;
        case 1:
        {
            ChangeTelephoneNumController *changeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ChangeTelephoneNumController"];
            [self showViewController:changeController sender:nil];
        }
            break;
        case 2:
        {
            ChangeNameBirthdaySexController *changeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ChangeNameBirthdaySexController"];
            changeController.pageIdentifier=@"生日";
            changeController.universalString=_userInfoModel.birthday;
            [self showViewController:changeController sender:nil];
        }
            break;
        case 4:
        {
            ChangeNameBirthdaySexController *changeController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ChangeNameBirthdaySexController"];
            changeController.pageIdentifier=@"性别";
            changeController.universalString=[_userInfoModel.sex isEqualToString:@"2"]?@"女":@"男";
            [self showViewController:changeController sender:nil];
        }
            break;
        case 5:
        {
            ChangePasswordController *changePasswordController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"ChangePasswordController"];
            changePasswordController.telephoneNum=_userInfoModel.mobile;
            [self showViewController:changePasswordController sender:nil];
        }
            break;
        case 6:
        {
            ChangeAddressController *recieveController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"ChangeAddressController"];
            [self showViewController:recieveController sender:nil];
        }
            break;
        case 7:
        {
            self.photoAlertView.hidden=NO;
            self.takePhotoAlertView.hidden=YES;
            self.logoutAlertView.hidden=NO;
            TABBARCONTROLLER.tabBarView.hidden=YES;
        }
            break;
            
        default:
            break;
    }
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
