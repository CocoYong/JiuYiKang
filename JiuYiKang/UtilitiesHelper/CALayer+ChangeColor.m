//
//  CALayer+ChangeColor.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "CALayer+ChangeColor.h"

@implementation CALayer (ChangeColor)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor=color.CGColor;
}
@end
