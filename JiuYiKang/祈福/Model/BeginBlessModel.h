//
//  BeginBlessModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/25.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BeginBlessTypeModel:NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image_uri;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *bless_reason_vi_name;
@property(nonatomic,copy)NSString *money;
@end


@interface BlessTypeImageModel:NSObject
@property(nonatomic,copy)NSString *imageID; //上传图片要用到
@property(nonatomic,copy)NSString *name; //显示信息
@property(nonatomic,copy)NSString *is_required; //是否必须
@property(nonatomic,strong)UIImage *originalImage;
@property(nonatomic,strong)UIImage *cutImage;
@property(nonatomic,strong)NSData *cutImageData;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageUri;
@end
@interface BlessTypeRelationModel:NSObject
@property(nonatomic,copy)NSString *name; //关系
@end

@interface BeginBlessModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *bless_type_chengnuo;
@property(nonatomic,strong)BeginBlessTypeModel *bless_type; //类型model
@property(nonatomic,strong)NSArray *bless_type_image_list;  //需要照片数组
@property(nonatomic,strong)NSArray *bless_user_relation_list; //关系数组
@property(nonatomic,strong)NSArray *bless_days; //祈福时间数组
@end
