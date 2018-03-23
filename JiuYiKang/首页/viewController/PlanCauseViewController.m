//
//  PlanCauseViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//计划条款

#import "PlanCauseViewController.h"
@interface PlanCauseViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PlanCauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    [self configeWebViewBackground];
    if ([self.clauseType isEqualToString:@"bless"]) {
        [self requestBlessClauseFromService];
    }else
    {
    [self requestDataFromService];
    }
    
    // Do any additional setup after loading the view.
}
-(void)configeWebViewBackground
{
    _webView.backgroundColor=[UIColor clearColor];
    for (UIView *_aView in [_webView subviews])
    {
        if ([_aView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
        }
    }
}
-(void)requestDataFromService
{
    NSString *urlString=[NSString stringWithFormat:@"Account/product_member/%@",self.productID];
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
- (void)requestBlessClauseFromService {
    NSString *urlString=[NSString stringWithFormat:@"Home/Account/bless_rule/%@",self.productID];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
