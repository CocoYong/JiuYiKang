//
//  PublicListModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PublicDataModel : NSObject
@property(nonatomic,copy)NSString *date_join;
@property(nonatomic,copy)NSString *face_uri;
@property(nonatomic,copy)NSString *publicID;
@property(nonatomic,copy)NSString *money_need;
@property(nonatomic,copy)NSString *product_name;
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,assign)BOOL expand;
@property(nonatomic,assign) CGFloat expandHeight;
@property(nonatomic,assign) CGFloat normalHeight;
@end

@interface PublicListModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSArray *public_list;
@property(nonatomic,copy)NSString *detail_content;
@end
