//
//  AddReferenceViewController.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BaseViewController.h"
#import "BeginBlessModel.h"
@interface AddReferenceViewController : BaseViewController
@property(nonatomic,strong)BeginBlessModel *beginModel;
@property(nonatomic,copy)NSString *typeID;
@end
