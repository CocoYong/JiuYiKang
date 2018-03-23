//
//  AboutUsViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//  关于我们

#import "AboutUsViewController.h"
#import "NSString+ZYAdditions.h"
@interface AboutUsViewController ()<UIWebViewDelegate>
{
    NSString *headerString;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    [self configeWebViewBackground];
    headerString=[NSString stringWithFormat:@"<head><style>img{max-width:%.0fpx!important;}</style></head>",SCREENWIDTH-16];
    [self requestDataFromService];
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
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ushow/about/1" params:paramsDic  block:^(NSObject *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *tempDic=(NSDictionary *)result;
            NSString *htmlString=[[[tempDic objectForKey:@"data"] objectForKey:@"about"] objectForKey:@"detail_content"];
            NSString *finalString=[htmlString stringByAppendingString:headerString];
          [self.webView loadHTMLString:finalString baseURL:nil];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    webView.scalesPageToFit=YES;
//    [webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');""script.type = 'text/javascript';""script.text = \"function ResizeImages() { ""var myimg,oldwidth,oldheight;""var maxwidth=320;""for(i=0;i  maxwidth){""myimg.width = maxwidth;""}""}""}\";""document.getElementsByTagName('head'[0].appendChild(script);"];
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
