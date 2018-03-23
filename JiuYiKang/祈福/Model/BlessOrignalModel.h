//
//  BlessOrignalModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/20.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BlessTypeModel:NSObject
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *typeID;
@property(nonatomic,copy)NSString *image_uri;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *bless_for_user_name_vi_name;
@property(nonatomic,copy)NSString *bless_reason_vi_name;
@end


@interface BlessOrignalModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *bless_desc;
@property(nonatomic,strong)NSArray *bless_type_list;
@end

