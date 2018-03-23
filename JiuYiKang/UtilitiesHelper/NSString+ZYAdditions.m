//
//  NSString+ZYAdditions.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "NSString+ZYAdditions.h"

@implementation NSString (ZYAdditions)
+(NSArray *)calculateStringIndexOfOriginalString:(NSString *)originalString andCalculateString:(NSString *)calString
{
    NSMutableArray *rangeArray=[NSMutableArray arrayWithCapacity:10];
    NSArray *calArray=[originalString componentsSeparatedByString:calString];
    for (int i=0; i<calArray.count; i++) {
        NSInteger stringLength=0;
            for (int j=0; j<i; j++) {
                NSString *objectTwoString=[calArray objectAtIndex:j];
                stringLength+=objectTwoString.length;
            }
        NSNumber *stringNumber=[NSNumber numberWithInteger:stringLength+i*calString.length];
        [rangeArray addObject:stringNumber];
        }
    return [rangeArray copy];
}
+(NSInteger)calculateContainStringNumsInString:(NSString*)originalString andContainString:(NSString*)string
{
    NSArray *calArray=[originalString componentsSeparatedByString:string];
    return calArray.count-1;
}
@end
