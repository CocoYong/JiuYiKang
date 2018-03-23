//
//  AddressModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/** 地区的ID */
@property (nonatomic,strong)NSString *area_id;

/** 地区的pid */
@property (nonatomic,strong)NSString *area_pid;

/** 地区的名字 */
@property (nonatomic,strong)NSString *area_district;

/** area_level */
@property (nonatomic,strong)NSString *area_level;

/** 地区的子地区 */
@property (nonatomic,strong)NSMutableArray *son;

@end
