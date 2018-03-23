//
//  JoinCellModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/13.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JoinCellModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *relationName;
@property(nonatomic,copy)NSString *codeNum;
@property(nonatomic,copy)NSString *taoCanName;
@property(nonatomic,copy)NSString *taoCanID;
-(instancetype)init;
@end
