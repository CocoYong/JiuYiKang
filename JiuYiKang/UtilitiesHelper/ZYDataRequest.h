//
//  ZYDataRequest.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/16.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionLoad)(NSObject *result);
typedef void(^CompletionLoadData)(NSData *data,NSURL *filePathUrl);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^NoNetWork)(NSString *noNetWorking);
@interface ZYDataRequest : NSObject<NSURLSessionTaskDelegate>

/**
 download Document request

 @param url  a string be added to baseURL
 @param successblock successCallBack
 @param errorBlock ErrorCallBack
 @param noNetworking noNetworkingCallBack
 */
+(void)requestWithDownLoadURL:(NSString*)url
                      block:(CompletionLoadData)successblock
                 errorBlock:(ErrorBlock)errorBlock
               noNetWorking:(NoNetWork)noNetworking;

/**
 常规请求接口

 @param url url参数用于拼接到baseurl后面
 @param params 请求参数 默认请求方式为post
 @param successblock successblock请求成功回到block 返回为json
 @param errorBlock errorBlock错误回调
 @param noNetworking noNetworking没有网络回调
 */
+ (void)requestWithURL:(NSString *)url
                  params:(NSDictionary *)params
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking;


/**
 发起一个网页请求

 @param url url参数用于拼接到baseurl后面
 @param params 请求参数
 @param successblock successblock成功回调
 @param errorBlock errorBlock错误回调
 @param noNetworking noNetworking无网络回调
 */
+(void)requestHTMLString:(NSString*)url
                  params:(NSDictionary *)params
        andRequestMethod:(NSString*)requestType
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking;


/**
 上传图片接口

 @param url 参数用于拼接到baseurl后面的
 @param fileName 图片对应的参数名
 @param name 图片名
 @param fileData 图片对应的data
 @param parameters 参数列表
 @param successblock 成功回调
 @param errorBlock 错误回调
 @param noNetworking 无网络回调
 */
+(void)uploadFileToServiceWithUrl:(NSString*)url
                     andFileNamed:(NSString*)fileName
                          andName:(NSString*)name
                      andFileData:(NSData*)fileData
                           params:(NSDictionary *)parameters
                            block:(CompletionLoad)successblock
                       errorBlock:(ErrorBlock)errorBlock
                     noNetWorking:(NoNetWork)noNetworking;
@end
