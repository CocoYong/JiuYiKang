//
//  JoinCellModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/13.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JoinCellModel.h"

@implementation JoinCellModel
-(instancetype)init
{
    self=[super init];
    if (!self) {
        return nil;
    }
    self.name=@"";
    self.relationName=@"选择会员与您的关系";
    self.codeNum=@"";
    self.taoCanName=@"请选择充值套餐";
    self.taoCanID=@"";
    return self;
}
@end
