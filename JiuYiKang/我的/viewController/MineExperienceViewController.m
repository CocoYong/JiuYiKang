//
//  MineExperienceViewController.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/12/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MineExperienceViewController.h"
#import "WriteUserDataViewController.h"
#import "RootTabBarController.h"
@interface MineExperienceViewController ()<UIWebViewDelegate>
{
    NSString *blessID;
}
@property (weak, nonatomic) IBOutlet UIView *getBgView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;

@end

@implementation MineExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    blessID=[[NSUserDefaults standardUserDefaults] objectForKey:@"blessID"];
    if ([self.showType integerValue]==0)
    {
        self.getBgView.hidden=NO;
    }else
    {
        self.getBgView.hidden=YES;
        self.bottomHeightConstraint.constant=0;
        [self.view layoutIfNeeded];
    }
    [self uploadUserDataForGetExperienceProduct];
}
- (IBAction)getExperienceProduct:(UIButton *)sender
{
    WriteUserDataViewController *writeController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"WriteUserDataViewController"];
    [self showViewController:writeController sender:nil];
}

#pragma mark  - ---requestService
-(void)uploadUserDataForGetExperienceProduct
{
    [self.webView clearsContextBeforeDrawing];
    NSString *urlString;
    if ([self.fromController isEqualToString:@"WriteUserDataViewController"]) {
        urlString=[NSString stringWithFormat:@"Account/free_product/%@?bless_id=%@",self.model.user_id,blessID];
    }else
    {
        urlString=[NSString stringWithFormat:@"Account/free_product/%@",self.model.user_id];
    }
    [ZYDataRequest requestHTMLString:urlString params:nil andRequestMethod:@"GET" block:^(NSObject *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadHTMLString:(NSString*)result baseURL:nil];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [self backToDetailController];
    }
    return YES;
 
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
-(void)backToFrontViewContrller
{
    if ([self.fromController isEqualToString:@"WriteUserDataViewController"]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [TABBARCONTROLLER selectedTabNum:4];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)backToDetailController
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:NSClassFromString(@"BlessDetailViewController")]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
@end
