//
//  CommonDefines.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#ifndef CommonDefines_h
#define CommonDefines_h



//#define KIOS_TESTSERVER //是否为测试版本
#ifndef KIOS_TESTSERVER //正式服务器
#define KBaseURL @"http://healthy.muhang.net" //正式服务器(先用着)
#else
#define KBaseURL @"http://jiuyikang.qqloveqq.com" //测试服务器
#endif
//支付宝key
#define PARTNERID @"2088021108964900"
#define SELLERID @"wid@51mhome.com"
//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"
//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"5i8o2w6387p5cv8vwvppi1myfesvmov6"
#define PartnerPrivateKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMrVCI8O407azA7jhhI9Nlr5b3Bsxl0axqitd848QfyVxJs2EqfoFehuw3x/Jd+GCsA3lQCIrYqWVoGbiox0ees4ObNpR0oKTBO4IvlRz3XngNS8FS9Z7pxqmAzb7x8/CgpGO+bqzaU25oNDUGSsu24ybnts/sNZZGj7pMpHE3xFAgMBAAECgYEArr7mxsle0Hr0PweKZIBUKgCoH8W3CFOfP4djpkyH1SL65XWqkPoEleGHjeTFLlP/QycfufwG91UaZkMpFGTs+07bGmkeSU1CgMexs+1RMx0vaUFqI3V1x+tpdU/L/IasT+HSJeBq9p1shPZAffgUVBHs04TOQQaJIdYMjYKKrAECQQDtLHkKpG243PE3q1dgwddMcAHt//pyT4WyOXmAVZVsia3tvvifmNqK/930yddI/yxe4sdNBhNodozJnKXRUfvFAkEA2u63pMrgQXUFDpau7CRsec+RW3AzVntTwshJoQAtmOW62iuE8EuVhZxLieWFXJ2Y7s8sIhEy7z3knUJ6qjkGgQJBAIaKeOuBlUCODUQwLXQU4gZZb67MTA02cThGBFe5tPcKLyEz+SPH+Qlq1kU7jqW5Izl8WeSmsrHKtljURPg2EqUCQQDPd7LN1ndncFZHeeHv46BsWpgbt5re1GYOyrCDguCy6NkGEIGdGXNrNy6aUcfseWhIvkjLS9MhxlxT7oDBuOKBAkBG8aLHyWgG90x0P7FjrghPxPFIDuQESrTzIbjb6cbSCWVBDW6tzEe/c5uUpE/gJWqD3OGCRexuqZ8IPm451ahy"





#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

#define IOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

//NSUserDefault 存取
#define MYSETNSUSERDEFAULTSDEFINE(a,b) [[NSUserDefaults standardUserDefaults]setObject:(a) forKey:(b)]
#define MYGETNSUSERDEFAULTSDEFINE(a) [[NSUserDefaults standardUserDefaults]objectForKey:(a)]

#define STORYBOARDOBJECT(a) [UIStoryboard storyboardWithName:(a) bundle:[NSBundle mainBundle]]

//标题统一Font
#define TITLEFONTDEFINE(a) [UIFont systemFontOfSize:(a)]
//状态栏高度
#define STATUS_BAR_HEIGHT 20.0f
//NavgationBar高度
#define NAVIGATION_BAR_HEIGHT 44.0f
//tabbar高度
#define TAB_BAR_HEIGHT 49.0f


#define UTILITYCOLOR(a) [UtilityHelper colorWithHexString:(a)]
//大标题颜色黑色
#define BIGTITLECOLOR UTILITYCOLOR(@"#000000")
//普通文字颜色
#define NORMALWORDCOLOR UTILITYCOLOR(@"#656667")
//分割线颜色深灰色
#define SEPARATORCOLOR UTILITYCOLOR(@"#B1B2B3")
//浅红色
#define LIGHTREDCOLOR UTILITYCOLOR(@"#FB484D")



#ifndef weakify
#define weakify(o) __typeof__(o) __weak o##__weak_ = o;
#define strongify(o) __typeof__(o##__weak_) __strong o =    o##__weak_;
#endif
#define TABBARCONTROLLER ((RootTabBarController*)[UIApplication sharedApplication].delegate.window.rootViewController)

#define DETAILFONTSIZE 16
#endif /* CommonDefines_h */
