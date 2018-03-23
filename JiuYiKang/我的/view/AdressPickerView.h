//
//  AdressPickerView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PickerViewBlock) (NSDictionary *pickerDic);
@interface AdressPickerView : UIView

/**
 default-init

 @param frame 建议frame大小给屏幕大小
 @param pickerBlock 回调block
 @return instance need added to your view
 */
-(instancetype)initWithFrame:(CGRect)frame andPickerBlock:(PickerViewBlock)pickerBlock;
//+(instancetype)pickerWithBlock:(PickerViewBlock)pickerBlock;
//-(void)show;
@end
