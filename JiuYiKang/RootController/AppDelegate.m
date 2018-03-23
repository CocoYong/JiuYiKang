//
//  AppDelegate.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginNavController.h"
#import "WXApi.h"
#import "QQApiInterface.h"
#import "TencentOAuth.h"
@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        //微信注册
        [WXApi  registerApp:@"wx32db1f85a151bbdf"];
//        if (MYGETNSUSERDEFAULTSDEFINE(@"token")==nil||[MYGETNSUSERDEFAULTSDEFINE(@"token") isEqualToString:@""]) {
//            UINavigationController *navcontroller=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
//            self.window.rootViewController=navcontroller;
//        }else
//        {
    
            _tabbarController=[[RootTabBarController alloc]init];
            self.window.rootViewController=_tabbarController;
//        }
    [self.window makeKeyAndVisible];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if(url != nil && [[url host] isEqualToString:@"pay"]){
        //微信支付
        NSLog(@"微信支付");
        return [WXApi handleOpenURL:url delegate:self];
    }
    else{
        //其他
        [QQApiInterface handleOpenURL:url delegate:self];
        return  [TencentOAuth HandleOpenURL:url]||[WXApi handleOpenURL:url delegate:self];
    }

     return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"2url = %@   [url host] = %@",url,[url host]);
    
    //跳转支付宝钱包进行支付，处理支付结果
    //    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //        NSLog(@"result = %@",resultDic);
    //           }];
    /*
    if ([url.host isEqualToString:@"safepay"])
    {
        NSString *str = [self decodeString:url.absoluteString];
        NSRange range = [str rangeOfString:@"?"];
        NSString *resultStr = [str substringFromIndex:range.location+1];
        
        NSData *jsonData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(!err) {
            NSDictionary *memoDic = dic[@"memo"];
            NSString *ResultStatus = memoDic[@"ResultStatus"];
            [[AlertCenter defaultCenter]postAlertWithMessage:memoDic[@"memo"]];
            if ([ResultStatus isEqualToString:@"9000"]) {
                [[AlertCenter defaultCenter]postAlertWithMessage:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccessNotification object:nil];
                //                [self aliPayStatusSend:memoDic[@"result"]];
            }else {
                [[AlertCenter defaultCenter]postAlertWithMessage:StringValue(memoDic[@"memo"])];
            }
            return true;
        }
    }
     */
    if(url != nil && [[url host] isEqualToString:@"pay"]){//微信支付
        NSLog(@"微信支付");
        return [WXApi handleOpenURL:url delegate:self];
    }
    else{//其他
        if ([sourceApplication hasSuffix:@"tencent.xin"]) {
            return [WXApi handleOpenURL:url delegate:self];
        }else
            [[NSNotificationCenter defaultCenter]postNotificationName:@"tencent_QQ" object:nil userInfo:@{@"url":url}];
        return [TencentOAuth HandleOpenURL:url];
    }
}

//收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"payStatus" object:resp];
        switch (response.errCode) {
            case WXSuccess: {
                [MBProgressHUD show:@"支付成功" view:self.window time:3];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"paySuccess" object:resp];
                break;
            }
            case WXErrCodeUserCancel:
            {
                [MBProgressHUD show:@"用户取消支付" view:self.window time:3];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"payFailed" object:resp];
                break;
            }
            default: {
                [MBProgressHUD show:@"支付失败" view:self.window time:3];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"payFailed" object:resp];
                break;
            }
        }
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%d",resp.errCode];
        if ([str isEqualToString:@"0"]) {
            [MBProgressHUD show:@"分享成功" view:self.window time:3];
        }else
        {
            [MBProgressHUD show:@"分享失败" view:self.window time:3];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
