//
//  UtilitiesHelper.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "UtilitiesHelper.h"
#define activityViewTag                0x401
#define aViewTag                0x402
@implementation UtilitiesHelper
+(instancetype)shareHelper
{
    static UtilitiesHelper *helper=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper=[[UtilitiesHelper alloc]init];
    });
    return helper;
}

+ (void)deleteImage
{
    NSFileManager * imageManager = [NSFileManager defaultManager];
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //NSLog(@"路径:%@",documentPath);
    //放图片的文件夹路径
    NSString * imageFloderPath = [[NSString alloc] initWithFormat:@"%@/img",documentPath];
    //遍历文件夹
    NSDirectoryEnumerator * dirEnum = [imageManager enumeratorAtPath:imageFloderPath];
    NSString * filePath;
    while (filePath = [dirEnum nextObject]) {
        //找出每条路径
        NSString * enumFielPath = [NSString stringWithFormat:@"%@/img/%@",documentPath,filePath];
        NSError * error1;
        //取出文件信息的字典
        NSDictionary *fileAttributes = [imageManager attributesOfItemAtPath:enumFielPath error:&error1];
        //获得修改时间
        NSDate * modifyDate = [fileAttributes objectForKey:NSFileModificationDate];
        NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        NSDateComponents *comps  = [calendar components:unitFlags fromDate:modifyDate];
        //文件的修改时间
        int modifyMonth = (int)[comps month];
        //NSLog(@"修改的%d月,%d分",modifyMonth,modifyMin);
        NSDateComponents *nowcomps  = [calendar components:unitFlags fromDate:[NSDate date]];
        //现在的时间
        int nowMonth = (int)[nowcomps month];
        //NSLog(@"现在的%d月,%d分",nowMonth,nowMin);
        NSError * error;
        if (nowMonth == 1 && modifyMonth == 11) {
            //[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if ([[NSFileManager defaultManager] removeItemAtPath:enumFielPath error:&error] != YES)
            {
                //NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            }else{
                //NSLog(@"Remove");
            }
            
        }else if (nowMonth == 2 && modifyMonth == 12) {
            //[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if ([[NSFileManager defaultManager] removeItemAtPath:enumFielPath error:&error] != YES)
            {
                //NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            }else{
                //NSLog(@"Remove");
            }
            
        }
        else{
            if (nowMonth - modifyMonth >= 2) {
                //[[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
                if ([[NSFileManager defaultManager] removeItemAtPath:enumFielPath error:&error] != YES)
                {
                    //NSLog(@"Unable to delete file: %@", [error localizedDescription]);
                }
            }else{
                //                NSLog(@"%@",enumFielPath);
                //                NSLog(@"Remove");
            }
        }
    }
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}
+ (BOOL) isFirstLaunchForSwipeView {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if (!documentsDirectory) {
        return NO;
    }
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"firstlaunch.plist"];
    // 文件目录存在检查
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!result) {
            return NO;
        }
    }
    else {
        return NO;
    }
    return YES;
}


+ (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage size:(CGSize)imageSize {
    UIImage *thumbnail = nil;
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
    {
        CGSize itemSize = CGSizeMake(imageSize.width, imageSize.height);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [srcImage drawInRect:imageRect];
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        thumbnail = srcImage;
    }
    return thumbnail;
}

+ (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale {
    UIImage *thumbnail = nil;
    //double oriScale = srcImage.size.width / srcImage.size.height;
    double thumbnailWidth = srcImage.size.width * imageScale;
    double thumbnailHeight = srcImage.size.height * imageScale;
    CGSize imageSize = CGSizeMake(thumbnailWidth, thumbnailHeight);
    if (srcImage.size.width != imageSize.width || srcImage.size.height != imageSize.height)
    {
        CGSize itemSize = CGSizeMake(imageSize.width, imageSize.height);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [srcImage drawInRect:imageRect];
        thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        thumbnail = srcImage;
    }
    return thumbnail;
}

+ (NSData *)Convert2Utf8:(NSData *)data {
    CFStringRef gbkStr = CFStringCreateWithBytes(NULL, [data bytes], [data length], kCFStringEncodingGB_18030_2000, false);
    if (NULL == gbkStr) {
        return nil;
    }
    else {
        NSString *gbkStrTmp = (__bridge NSString *)gbkStr;
        NSString *utf8NSString = [gbkStrTmp stringByReplacingOccurrencesOfString:@"encoding=\"GBK\""
                                                                      withString:@"encoding=\"UTF-8\""];
        CFRelease(gbkStr);
        //NSLog(@"%@", utf8NSString);
        return [utf8NSString dataUsingEncoding:NSUTF8StringEncoding];
    }
}


+ (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}


+(NSArray*)formatSortDictionary:(NSDictionary*)dictionary
{
    if (dictionary==nil) {
        return nil;
    }
    NSArray *keysArray=[dictionary allKeys];
    NSArray *sortedArray=[keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    return sortedArray;
    
}
+ (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

+ (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

+ (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

+ (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}
+ (void)callPhone:(NSString *)phoneNumber{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
        
    }];
}



+(NSString *)getComData:(NSString *)addTime{
    
    int month;//year,month,day,hour,minute,second;
    int comyear,commonth,comday,comhour,commin,comsec;
    
    NSArray *timeArray = [addTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    
    month = [[timeArray objectAtIndex:1] intValue];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSArray *nowTimeArray = [nowString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"- :"]];
    
    comyear =  [[nowTimeArray objectAtIndex:0] intValue]-[[timeArray objectAtIndex:0] intValue];
    commonth = [[nowTimeArray objectAtIndex:1] intValue]-[[timeArray objectAtIndex:1] intValue];
    comday = [[nowTimeArray objectAtIndex:2] intValue]-[[timeArray objectAtIndex:2] intValue];
    comhour = [[nowTimeArray objectAtIndex:3] intValue]-[[timeArray objectAtIndex:3] intValue];
    commin = [[nowTimeArray objectAtIndex:4] intValue]-[[timeArray objectAtIndex:4] intValue];
    comsec = [[nowTimeArray objectAtIndex:5] intValue]-[[timeArray objectAtIndex:5] intValue];
    
    if (comsec < 0) {
        comsec += 60;
        commin--;
    }
    if (commin < 0) {
        commin += 60;
        comhour--;
    }
    if (comhour < 0) {
        comhour += 24;
        comday--;
    }
    if (comday < 0) {
        switch (month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                comday += 31;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                comday += 30;
                break;
            case 2:
                if (([[nowTimeArray objectAtIndex:0] intValue]%4&&[[nowTimeArray objectAtIndex:0] intValue]%100 )|| [[nowTimeArray objectAtIndex:0] intValue]%400 ) {
                    comday += 29;
                }
                else{
                    comday += 28;
                }
                break;
                
            default:
                break;
        }
        commonth--;
    }
    if (commonth < 0) {
        commonth += 12;
        comyear--;
    }
    
    if (comyear<0) {
        return [NSString stringWithFormat:@"1秒前更新"];
    }
    
    if(comyear > 0){
        return [NSString stringWithFormat:@"%d年前更新",comyear];
    }
    if(commonth > 0){
        return [NSString stringWithFormat:@"%d月前更新",commonth];
    }
    if(comday > 0){
        return [NSString stringWithFormat:@"%d天前更新",comday];
    }
    if(comhour > 0){
        return [NSString stringWithFormat:@"%d小时前更新",comhour];
    }
    if(commin > 0){
        return [NSString stringWithFormat:@"%d分钟前更新",commin];
    }
    if(comsec > 0){
        return [NSString stringWithFormat:@"%d秒前更新",comsec];
    }
    else {
        return [NSString stringWithFormat:@"1秒前更新"];
    }
    
    
}

+(CLLocationDistance)getDistanceLatitude:(NSString *)latitude longitude:(NSString *)longitude otherLatitude:(NSString *)otherLatitude otherLongitude:(NSString *)otherLongitude {
    //	NSLog(@"获取距离..%@",[NSString stringWithFormat:@"%f km",[NeardyLocation distanceFromLocation:fromLocation]/1000]);
    CLLocation * location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    CLLocation * otherLocation = [[CLLocation alloc] initWithLatitude:[otherLatitude floatValue] longitude:[otherLongitude floatValue]];
    CLLocationDistance distance = [location distanceFromLocation:otherLocation];
    return distance;
}

//#define DEFAULT_VOID_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    //if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return ZY_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
}

+ (NSString *)getCityName:(NSString *)cityInfo {
    NSString *returnName = @"";
    NSString *cityName = @"";
    if ([cityInfo rangeOfString:@"市"].location != NSNotFound) {
        // NSRange range = [cityInfo rangeOfString:@"市"];
        cityName = [cityInfo substringToIndex:[cityInfo rangeOfString:@"市"].location];
        if ([cityName rangeOfString:@"省"].location == NSNotFound) {
            returnName = cityName;
        } else {
            returnName = [cityName substringFromIndex:[cityName rangeOfString:@"省"].location + 1];
        }
    }
    return returnName;
}










+ (NSString *)calculateTime:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    
    NSTimeInterval secondsInterval = [destDate timeIntervalSinceNow];
    NSInteger secondsInt = -secondsInterval;//目标时间距离当前有多少秒
    NSString *destDateString;
    if (secondsInt < 0) {
        destDateString = [NSString stringWithFormat:@"刚刚"];
        return destDateString;
    }
    if (secondsInt >= 24*60*60) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        destDateString = [dateFormatter stringFromDate:destDate];

    }else{
        NSInteger residualTimeHour = secondsInt/60/60;
        if (residualTimeHour == 0) {
            NSInteger residualTimeMinute = secondsInt/60;
            if (residualTimeMinute == 0) {
                NSInteger residualTimesecond = secondsInt;
                if (residualTimesecond == 0) {
                    destDateString = [NSString stringWithFormat:@"刚刚"];
                }else{
                    destDateString = [NSString stringWithFormat:@"%ld秒前",(long)residualTimesecond];
                }
                
            }else{
                destDateString = [NSString stringWithFormat:@"%ld分钟前",(long)residualTimeMinute];
            }
        }else{
            destDateString = [NSString stringWithFormat:@"%ld小时前",(long)residualTimeHour];
        }
        
    }
    return destDateString;
}

+ (NSString *)calculateTimeWithhour:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    
    NSTimeInterval secondsInterval = [destDate timeIntervalSinceNow];
    NSInteger secondsInt = -secondsInterval;//目标时间距离当前有多少秒
    NSString *destDateString;
    if (secondsInt < 0) {
        destDateString = [NSString stringWithFormat:@"刚刚"];
        return destDateString;
    }
    if (secondsInt >= 24*60*60) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        destDateString = [dateFormatter stringFromDate:destDate];

    }else{
        NSInteger residualTimeHour = secondsInt/60/60;
        if (residualTimeHour == 0) {
            NSInteger residualTimeMinute = secondsInt/60;
            if (residualTimeMinute == 0) {
                NSInteger residualTimesecond = secondsInt;
                if (residualTimesecond == 0) {
                    destDateString = [NSString stringWithFormat:@"刚刚"];
                }else{
                    destDateString = [NSString stringWithFormat:@"%ld秒前",(long)residualTimesecond];
                }
                
            }else{
                destDateString = [NSString stringWithFormat:@"%ld分钟前",(long)residualTimeMinute];
            }
        }else{
            destDateString = [NSString stringWithFormat:@"%ld小时前",(long)residualTimeHour];
        }
        
    }
    return destDateString;
}

+(NSString *)getChinaDate:(NSString *) dateString{
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];//定义NSDateFormatter用来显示格式
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定格式
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    
    
    NSDate *todate = [dateformatter dateFromString:dateString];
    
    NSDate *today = [NSDate date];//得到当前时间
    //用来得到具体的时差
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [cal components:unitFlags fromDate:today toDate:todate options:0];
    
    if ([comps year]>0) {
        return [NSString stringWithFormat:@"%ld年%ld月%ld天",(long)[comps year],(long)[comps month],(long)[comps day]];
    }else if ([comps month]>0) {
        return [NSString stringWithFormat:@"%ld月%ld天%ld小时",(long)[comps month],(long)[comps day],(long)[comps hour]];
    }else if ([comps day]>0) {
        return [NSString stringWithFormat:@"%ld天%ld小时%ld分",(long)[comps day],(long)[comps hour],(long)[comps minute]];
    }else if ([comps hour]>0) {
        return [NSString stringWithFormat:@"%ld小时%ld分",(long)[comps hour],(long)[comps minute]];
    }else if ([comps minute]>0) {
        return [NSString stringWithFormat:@"%ld分钟",(long)[comps minute]];
    }else if ([comps second]>0){
        return @"1分";
    }else {
        return @"已过期";
    }
    
    
}
- (UIImage *)imageFromPDFWithDocumentRef:(NSData*)fileData {
    
    CFDataRef dataRef = (__bridge_retained CFDataRef)(fileData);
    CGDataProviderRef proRef = CGDataProviderCreateWithCFData(dataRef);
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithProvider(proRef);
    CGDataProviderRelease(proRef);
    CFRelease(dataRef);
    
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(pdfRef, 1);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    
    UIGraphicsBeginImageContext(pageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}
- (BOOL)validatePhoneMobile:(NSString *)mobileNum{
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)dialTelephoneNum:(NSString*)telephoneNum
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telephoneNum]] options:@{} completionHandler:^(BOOL success) {
         
    }];
}
-(BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}
@end

@implementation UIView (UIViewUtils)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = ceilf(width);
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = ceilf(height);
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

@implementation UINavigationBar (customImage)
- (void)drawRect:(CGRect)rect {
    
    UIImage *img = [[UIImage imageNamed: @"顶部栏.png" ] stretchableImageWithLeftCapWidth:320 topCapHeight:44];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}
@end

@implementation UITabBar (customImage)
- (void)drawRect:(CGRect)rect {
    
    UIImage *img = [UIImage imageNamed: @"bg_bottom.png"];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
}
@end

@implementation UINavigationBar (JTDropShadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    //self.layer.shadowColor = color.CGColor;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}

@end
