//
//  TelephoneAlertView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/6.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonClickedBlock) (UIButton* butt);
@interface TelephoneAlertView : UIView
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property(nonatomic,copy)ButtonClickedBlock clickBlock;
+(instancetype)telephoneView;
@end
