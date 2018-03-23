//
//  MineExperienceViewController.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/12/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoModel.h"
@interface MineExperienceViewController : BaseViewController
@property(nonatomic,strong)UserInfoModel *model;
@property(nonatomic,copy)NSString *showType;
@property(nonatomic,copy)NSString *fromController;
@end
