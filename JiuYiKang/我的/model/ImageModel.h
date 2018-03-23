//
//  ImageModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/6.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic,strong)UIImage *originalImage;
@property(nonatomic,strong)UIImage *cutImage;
@property(nonatomic,strong)NSData *cutImageData;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageUri;
@end
