//
//  InvitationController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "InvitationController.h"
#import "DepositViewController.h"
#import "JieSuanMoneyViewController.h"
#import "InvitedListViewController.h"
#import "InvitedRulesViewController.h"
#import "RootTabBarController.h"
#import "UserInfoModel.h"
#import "InvitedListModel.h"
#import "SDWebImageManager.h"

//微信分享
#import "WXApi.h"
#import "WXApiObject.h"

#import "QQApiInterface.h"
#import "QQApiInterfaceObject.h"
#import "TencentOAuth.h"
#import "LoginViewController.h"
@interface InvitationController ()<UIActionSheetDelegate,TencentSessionDelegate>
{
    UserInfoModel *userModel;
    InvitedListModel *invitModel;
    TencentOAuth *oAuth;
}
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *inviteNumLabel;//邀请码
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;//累计奖金
@property (weak, nonatomic) IBOutlet UIButton *desposiButton;

@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;//邀请人数
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (weak, nonatomic) IBOutlet UIButton *invitedButton;
@property (weak, nonatomic) IBOutlet UIView *popAlertView;
@property (weak, nonatomic) IBOutlet UIView *shareAlertBgView;
@property (weak, nonatomic) IBOutlet UIView *grayBgView;


@property(nonatomic,strong)NSString *shareURLString;

@end

@implementation InvitationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoImageView.layer.cornerRadius=40;
    [self.photoImageView setClipsToBounds:YES];
    self.shareAlertBgView.layer.cornerRadius=10;
    UITapGestureRecognizer *dismissController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelf)];
    [self.grayBgView addGestureRecognizer:dismissController];
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TABBARCONTROLLER.tabBarView.hidden=NO;
    [self requestUserInfoFromService];
    [self requestDataFromService];
}
-(void)createInvitedImageView
{
    CGFloat imageWidth=(SCREENWIDTH-60)/5;
    for (int i=0; i<5; i++)
    {
        UIImageView *photoView=[[UIImageView alloc]initWithFrame:CGRectMake(i*(imageWidth+10)+10, 10, imageWidth, imageWidth)];
        photoView.image=[UIImage imageNamed:@"tx1"];
        photoView.layer.cornerRadius=imageWidth/2;
        photoView.layer.borderWidth=2;
        photoView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"].CGColor;
        photoView.clipsToBounds=YES;
        photoView.tag=i+10;
        [_photoScrollView addSubview:photoView];
     
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*(imageWidth+10)+10, CGRectGetMaxY(photoView.frame)+10, imageWidth, 20)];
        nameLabel.textAlignment=NSTextAlignmentCenter;
                nameLabel.textColor=[UIColor darkGrayColor];
        nameLabel.font=[UIFont systemFontOfSize:16];
        [_photoScrollView addSubview:nameLabel];
        if (i<invitModel.pushListArray.count) {
            PushListModel *model=[invitModel.pushListArray objectAtIndex:i];
            [photoView setImageWithURL:[NSURL URLWithString:model.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]]];
            nameLabel.text=model.user_name;
        }else
        {
            nameLabel.text=[NSString stringWithFormat:@"第%d位",i+1];
        }
        _photoScrollView.contentSize=CGSizeMake(5*(imageWidth+10)+10, _photoScrollView.frame.size.height);
    }
   
}

-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/my_push_user" params:paramsDic block:^(NSObject *result) {
        invitModel=[InvitedListModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
                self.peopleNumLabel.text=invitModel.pushCount;
              [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:invitModel.share_img relativeToURL:[NSURL URLWithString:KBaseURL]] options:SDWebImageHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                  invitModel.shareImage=image;
              }];
                [self createInvitedImageView];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)requestUserInfoFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/my_info" params:paramsDic block:^(NSObject *result) {
        userModel=[UserInfoModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoImageView setImageWithURL:[NSURL URLWithString:userModel.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]]];
            self.inviteNumLabel.text=userModel.id_str;
            if ([userModel.sum_push_money_enabled floatValue]==0) {
                self.moneyLabel.textColor=[UIColor lightGrayColor];
                self.moneyLabel.text=@"您还没有获得奖金!";
                self.desposiButton.hidden=YES;
            }else
            {
                self.moneyLabel.textColor=[UIColor redColor];
                self.desposiButton.hidden=NO;
                self.moneyLabel.text=userModel.sum_push_money_enabled;
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}

#pragma buttonAction
- (IBAction)tixianButtonAction:(UIButton *)sender {
    DepositViewController *applyDespositController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"DepositViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    applyDespositController.despositMoney=userModel.sum_push_money_enabled;
    [self showViewController:applyDespositController sender:nil];

}
- (IBAction)jiangJinJIeSuanButtAction:(UIButton *)sender {
    JieSuanMoneyViewController *jieSuanController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"JieSuanMoneyViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    [self showViewController:jieSuanController sender:nil];
}

- (IBAction)inviteJiLvButtonAction:(UIButton *)sender {
    InvitedListViewController *invitedListController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"InvitedListViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    invitedListController.totalMoney=userModel.sum_push_money;
    [self showViewController:invitedListController sender:nil];
}
- (IBAction)detailIntroductionButtAction:(UIButton *)sender {
    InvitedRulesViewController *invitedRulesController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"InvitedRulesViewController"];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    [self showViewController:invitedRulesController sender:nil];
}



#pragma shareUIMark
- (IBAction)shareButtAction:(UIButton *)sender {
    [self shareViewCall];
}


-(void)shareViewCall
{
    self.shareURLString=[NSString stringWithFormat:@"%@/%@?user_id=%@",KBaseURL,@"Home/Account/user_share",userModel.id_str];
    self.popAlertView.hidden=NO;
    TABBARCONTROLLER.tabBarView.hidden=YES;
}
-(void)dismissSelf
{
    self.popAlertView.hidden=YES;
    TABBARCONTROLLER.tabBarView.hidden=NO;
}

- (IBAction)ButtonWeixin {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.bText = NO;
        req.scene = WXSceneSession;// 分享到会话
        WXMediaMessage *medMessage = [WXMediaMessage message];
        medMessage.title = invitModel.share_title; // 标题
        medMessage.description = invitModel.share_desc;// 描述
        WXWebpageObject *webPageObj = [WXWebpageObject object];
        [medMessage setThumbImage:invitModel.shareImage];// 缩略图
        webPageObj.webpageUrl = self.shareURLString;
        medMessage.mediaObject = webPageObj;
        req.message = medMessage;
        [WXApi sendReq:req];
    } else {
        [MBProgressHUD show:@"还没有安装微信" view:self.view time:1.5];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ButtonWeixinFriendCircle {

    if ([WXApi isWXAppInstalled]) {
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneTimeline;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            medMessage.title = invitModel.share_title; // 标题
            medMessage.description = invitModel.share_desc;// 描述
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            [medMessage setThumbImage:invitModel.shareImage];// 缩略图
            webPageObj.webpageUrl = self.shareURLString;
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else {
            [MBProgressHUD show:@"还没有安装微信" view:self.view time:1.5];
        }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)ButtonQQFriend {
    if ([QQApiInterface isQQInstalled]) {
        oAuth = [[TencentOAuth alloc] initWithAppId:@"1106302185" andDelegate:self];
        NSData *imageData = UIImagePNGRepresentation(invitModel.shareImage);
        QQApiNewsObject *urlObj = [QQApiNewsObject
                                   objectWithURL:[NSURL URLWithString:self.shareURLString]
                                   title:invitModel.share_title
                                   description:invitModel.share_desc
                                   previewImageData:imageData];
        SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:urlObj];
        [QQApiInterface sendReq:request];
    } else {
        [MBProgressHUD show:@"" view:self.view time:1.5];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)ButtonQzone {

//    if ([QQApiInterface isQQInstalled]) {
//        oAuth = [[TencentOAuth alloc] initWithAppId:@"1104985206" andDelegate:self];
//        
//        NSString *path = [[[NSBundle mainBundle] resourcePath]
//                          stringByAppendingPathComponent:@"share_icon.png"];
//        NSData *imageData = [NSData dataWithContentsOfFile:path];
//        QQApiNewsObject *urlObj = [QQApiNewsObject
//                                   objectWithURL:[NSURL URLWithString:self.shareURLString]
//                                   title:@"极客工作"
//                                   description:@"你觉得工资够用吗？人才好找吗？赚钱/找人，竟如此简单！"
//                                   previewImageData:imageData];
//        SendMessageToQQReq *request = [SendMessageToQQReq reqWithContent:urlObj];
//        sent = [QQApiInterface SendReqToQZone:request];
//    } else {
//        [[AlertCenter defaultCenter]
//         postAlertWithMessage:@"没有安装QQ，请安装QQ"];
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
- (void)dealWithQQapi:(NSNotification *)notification {
    NSURL *url = [notification.userInfo objectForKey:@"url"];
    [QQApiInterface handleOpenURL:url delegate:self];
}

- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"QQ回调。。。。。。。。");
    if (resp.type == ESENDMESSAGETOQQRESPTYPE) {
        if ([resp.result boolValue] == 0) {
            [[AlertCenter defaultCenter] postAlertWithMessage:@"分享成功。"];
        } else {
            [[AlertCenter defaultCenter] postAlertWithMessage:@"分享失败。"];
        }
    }
}
- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
    NSLog(@"微信朋友圈分享回调");
    if (response.errCode == WXSuccess) {
        [[AlertCenter defaultCenter] postAlertWithMessage:@"分享成功。"];
    } else {
        [[AlertCenter defaultCenter] postAlertWithMessage:@"分享失败。"];
    }
}
*/
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
