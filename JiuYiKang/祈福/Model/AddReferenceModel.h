//
//  AddReferenceModel.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/28.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddReferenceModel : NSObject
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *user_mobile;
@property(nonatomic,copy)NSString *user_relative;
@property(nonatomic,copy)NSString *face_uri;
@property(nonatomic,copy)NSString *id_card_image;
@property(nonatomic,copy)NSString *other_images;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)UIImage *faceImage;
@property(nonatomic,strong)UIImage *showCIDImage;
@property(nonatomic,strong)UIImage *otherImage;
-(NSString*)checkPropertyIsEmpty;
-(BOOL)chechInfomationIsOK;

@end
