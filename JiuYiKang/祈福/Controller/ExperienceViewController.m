//
//  ExperienceViewController.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/12/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ExperienceViewController.h"
#import "WriteUserDataViewController.h"
@interface ExperienceViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    [self uploadUserDataForGetExperienceProduct];
}

- (IBAction)getExperienceProductButtAction:(UIButton *)sender {
    WriteUserDataViewController *writeController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"WriteUserDataViewController"];
    [self showViewController:writeController sender:nil];
}



#pragma mark  - ---requestService
-(void)uploadUserDataForGetExperienceProduct
{
    NSDictionary *paramsDic=@{@"token":self.token};
    NSString *urlString=[NSString stringWithFormat:@"Account/free_product"];
    [ZYDataRequest requestHTMLString:urlString params:paramsDic andRequestMethod:@"GET" block:^(NSObject *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadHTMLString:(NSString*)result baseURL:nil];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];

}
-(void)backToFrontViewContrller
{
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(@"BlessDetailViewController")]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

@end
