//
//  MyProtectCardController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/12.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "MyProtectCardController.h"
#import "UIImageView+WebCache.h"
@interface MyProtectCardController ()<UIWebViewDelegate>
{
    NSString *imageUrlString;
    CGFloat imageViewHeight;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MyProtectCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [self.view addSubview:_scrollView];
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    [_scrollView addSubview:_imageView];
    [self creatBackNavigationItem];
    [self requestDataFromService];
    
}
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    NSString *urlString=[NSString stringWithFormat:@"AppApi/Ushow/my_cer_image/%@",self.join_id];
    [ZYDataRequest requestWithURL:urlString params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[tempDic objectForKey:@"code"] isEqualToString:@"0"]) {
                imageUrlString=[[tempDic objectForKey:@"data"]objectForKey:@"image_src" ];
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (image) {
                    CGFloat imagewith=CGImageGetWidth(image.CGImage);
                    imageViewHeight=SCREENWIDTH/(imagewith/CGImageGetHeight(image.CGImage));
                    self.imageView.frame=CGRectMake(0, 0, SCREENWIDTH, imageViewHeight);
                    self.scrollView.contentSize=CGSizeMake(SCREENWIDTH, imageViewHeight);
                    }
                }];
            }else
            {
              [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:1.5];
            }
        });
    } errorBlock:^(NSError *error) {
       [MBProgressHUD show:error.description view:self.view time:1.5];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接" view:self.view time:1.5];
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
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
