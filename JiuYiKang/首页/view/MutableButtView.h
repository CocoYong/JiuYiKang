//
//  MutableButtView.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtCallBackBlock) (UIButton* butt,NSInteger buttIndex);
@interface MutableButtView : UIView
@property(nonatomic,assign)NSInteger selectButtIndex;
@property(nonatomic,copy)ButtCallBackBlock buttBlock;
-(instancetype)initWithFrame:(CGRect)frame andButtonTitleArray:(NSArray *)titleArray andButtSelectColor:(UIColor *)selectColor andButtNormalColor:(UIColor *)normalColor andNormalImage:(UIImage*)nromalImage andSelectedIamge:(UIImage*)selectedIamge andButtCount:(NSInteger)buttNum;

@end
