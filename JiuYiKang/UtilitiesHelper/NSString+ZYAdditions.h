//
//  NSString+ZYAdditions.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZYAdditions)
+(NSArray*)calculateStringIndexOfOriginalString:(NSString*)originalString andCalculateString:(NSString*)calString;
+(NSInteger)calculateContainStringNumsInString:(NSString*)originalString andContainString:(NSString*)string;
@end
