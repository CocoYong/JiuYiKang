//
//  NSDate+ZYAdditions.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZYAdditions)

/**
 日期字符串换格式输出

 @param dateString 原始字符串
 @param formaterString 原始字符串格式
 @param newDateFormater 需要日期字符串格式
 @return 转换后的日期格式字符串
 */
+(NSString *)dateWithOriginalString:(NSString *)dateString andOriginalDateFormater:(NSString *)formaterString newDateFormater:(NSString*)newDateFormater;

/**
 计算两个日期之间相差多少天

 @param dateOne 第一个date
 @param dateTwo 第二个date
 @return 返回天数
 */
+(NSInteger)daysBetweenDateOne:(NSDate*)dateOne andDateTwo:(NSDate*)dateTwo;
@end
