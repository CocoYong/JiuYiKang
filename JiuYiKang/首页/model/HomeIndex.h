//
//  HomeIndex.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/8.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Bannsers : NSObject
@property(nonatomic,strong)NSString *image_uri;
@end

@interface ProductList : NSObject
@property(nonatomic,strong)NSString *age_limite;
@property(nonatomic,copy)NSString *productID;
@property(nonatomic,copy)NSString *list_image;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,copy)NSString *money_max;
@property(nonatomic,copy)NSString *to_des;
@end




@interface HomeIndex : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,strong)NSArray *banners;
@property(nonatomic,assign)NSNumber* count_join;
@property(nonatomic,copy)NSArray *product_list;
@property(nonatomic,copy)NSString *msg;
@end


