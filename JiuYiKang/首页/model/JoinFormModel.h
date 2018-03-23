//
//  JoinFormModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/27.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListModel : NSObject
@property(nonatomic,copy)NSString *productID;
@property(nonatomic,copy)NSString *name;
@end

@interface RelationListModel : NSObject
@property(nonatomic,copy)NSString *name;
@end



@interface JoinFormModel : NSObject
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,strong)NSArray *productList;
@property(nonatomic,strong)NSArray *relationList;
@end


