//
//  NSDate+ZYAdditions.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/10.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "NSDate+ZYAdditions.h"

@implementation NSDate (ZYAdditions)
+(NSString *)dateWithOriginalString:(NSString *)dateString andOriginalDateFormater:(NSString *)originalDateformater newDateFormater:(NSString*)newDateFormater
{
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    formater.dateFormat=originalDateformater;
    NSDate  *originalDate=[formater  dateFromString:dateString];
    formater.dateFormat=newDateFormater;
    return [formater stringFromDate:originalDate];
}
+(NSInteger)daysBetweenDateOne:(NSDate*)dateOne andDateTwo:(NSDate*)dateTwo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned int unitFlags =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDate *newDateOne,*newDateTwo;
    if ([dateOne compare:dateTwo]!=NSOrderedSame) {
        NSDateComponents *daysOne= [calendar components:unitFlags fromDate:dateOne];
        NSDateComponents *daysTwo= [calendar components:unitFlags fromDate:dateTwo];
        newDateOne=[calendar dateFromComponents:daysOne];
        newDateTwo=[calendar dateFromComponents:daysTwo];
        NSTimeInterval interval = [newDateOne timeIntervalSinceDate:newDateTwo];
        NSInteger days=((NSInteger)interval)/(3600*24);
        return days>0?days:-days;
    }else
    {
        return 1;
    }
}
@end
