//
//  ZYDataRequest.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/16.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "ZYDataRequest.h"
#import "AFNetworking.h"
@implementation ZYDataRequest
//downloadDocuments
+(void)requestWithDownLoadURL:(NSString*)url
                        block:(CompletionLoadData)successblock
                   errorBlock:(ErrorBlock)errorBlock
                 noNetWorking:(NoNetWork)noNetworking
{
    static AFURLSessionManager *sessionManager=nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager=[[AFURLSessionManager alloc]init];
    });
    sessionManager.reachabilityManager=[AFNetworkReachabilityManager manager];
    NSURLRequest *requestUrl=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
     NSURLSessionDownloadTask *datatask= [sessionManager downloadTaskWithRequest:requestUrl progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
     NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
     return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
     } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
         if (error!=nil&&errorBlock!=nil) {
             NSLog(@"errorOperation===%@", error.description);
             errorBlock(error);
         }else
         {
             NSData  *data=[[NSData alloc]initWithContentsOfURL:filePath];
             NSLog(@"filepath===%@", filePath);
             successblock(data,filePath);
         }
     }];
    if (sessionManager.reachabilityManager.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
        noNetworking(@"没有网络连接!");
    }
    datatask.priority=NSURLSessionTaskPriorityHigh;
    [datatask resume];
}
//normalRequest+return+json
+ (void)requestWithURL:(NSString *)url
                  params:(NSDictionary *)params
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking
{
    static AFHTTPSessionManager *sessionManager=nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    sessionManager=[[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KBaseURL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
     sessionManager.reachabilityManager=[AFNetworkReachabilityManager manager];
     NSURLSessionDataTask *datatask= [sessionManager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"json====%@",responseObject);
             if ([[responseObject objectForKey:@"code"] isEqualToString:@"20001"]) {
              [MBProgressHUD show:@"登录令牌过期，请重新登录" view:[UIApplication sharedApplication].delegate.window time:2];
              [UIApplication sharedApplication].delegate.window.rootViewController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"LoginNavController"];
             }
            if (responseObject != nil) {
                successblock(responseObject);
            }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (error != nil) {
               NSLog(@"errorOperation===%@", error.userInfo);
               errorBlock(error);
           }
       }];
    if (sessionManager.reachabilityManager.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
        noNetworking(@"没有网络连接!");
    }
    datatask.priority=NSURLSessionTaskPriorityHigh;
    if (datatask.response==nil) {
        NSLog(@"datataskDescription====%@",datatask.description);
        NSLog(@"datataskDescription====%@",datatask.currentRequest);
        NSLog(@"datataskerror====%@",datatask.error);
        NSLog(@"datataskerror====%ld",(long)datatask.state);
    }
}
//downloadHTMLString..
+(void)requestHTMLString:(NSString*)url
                  params:(NSDictionary *)params
        andRequestMethod:(NSString*)requestType
                   block:(CompletionLoad)successblock
              errorBlock:(ErrorBlock)errorBlock
            noNetWorking:(NoNetWork)noNetworking
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    static AFHTTPSessionManager *sessionManager=nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager=[[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    sessionManager.reachabilityManager=[AFNetworkReachabilityManager manager];
    sessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *request;
    NSMutableString *urlString=[NSMutableString stringWithFormat:@"%@/%@?",KBaseURL,url];
    NSMutableString *parasString=[NSMutableString string];
    NSArray *keyArray=[params allKeys];
    for (int i=0; i<keyArray.count; i++)
    {
        NSString *paramsString=[NSString stringWithFormat:@"%@=%@&",[keyArray objectAtIndex:i],[params objectForKey:[keyArray objectAtIndex:i]]];
        [parasString appendString:paramsString];
    }
    if ([requestType isEqualToString:@"GET"]) {
        [urlString appendString:parasString];
        NSString *newString=[urlString substringToIndex:(urlString.length-1)];
        NSURL *tempUrl=[NSURL URLWithString:newString];
        request=[NSMutableURLRequest requestWithURL:tempUrl];
    }else
    {
        request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
        request.timeoutInterval=30;
        request.HTTPMethod=@"POST";
        NSString *newString=[parasString substringToIndex:(parasString.length-1)];
        request.HTTPBody=[newString dataUsingEncoding:NSUTF8StringEncoding];
    }
    NSLog(@"request===%@",request);
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error!=nil) {
            errorBlock(error);
        } else {
            NSString *dataString=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"dataString=== %@", dataString);
            successblock(dataString);
        }
    }];
    if (sessionManager.reachabilityManager.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
        noNetworking(@"没有网络连接!");
    }
    dataTask.priority=NSURLSessionTaskPriorityHigh;
    [dataTask resume];
}
+(void)uploadFileToServiceWithUrl:(NSString*)url
                     andFileNamed:(NSString*)fileName
                          andName:(NSString*)name
                      andFileData:(NSData*)fileData
                           params:(NSDictionary *)parameters
                            block:(CompletionLoad)successblock
                       errorBlock:(ErrorBlock)errorBlock
                     noNetWorking:(NoNetWork)noNetworking
{
    static AFHTTPSessionManager *sessionManager=nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager=[[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KBaseURL] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    sessionManager.reachabilityManager=[AFNetworkReachabilityManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    
   NSURLSessionDataTask *dataTask =  [sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fileName fileName:name mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] isEqualToString:@"0"]) {
            successblock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            errorBlock(error);
        }
    }];
    if (sessionManager.reachabilityManager.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
        noNetworking(@"没有网络连接!");
    }
    dataTask.priority=NSURLSessionTaskPriorityHigh;
    [dataTask resume];
}
@end
