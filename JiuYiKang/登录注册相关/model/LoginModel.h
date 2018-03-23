//
//  LoginModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/16.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginData : NSObject
@property(nonatomic,copy)NSString *face_uri;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *user_name;
@end

@interface LoginModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)LoginData *loginData;
@end
