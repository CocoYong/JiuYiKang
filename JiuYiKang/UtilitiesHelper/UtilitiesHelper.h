//
//  UtilitiesHelper.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/2.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


#ifdef IOS6_OR_LATER // iOS6 and later
#   define kLabelAlignmentCenter    NSTextAlignmentCenter
#   define kLabelAlignmentLeft      NSTextAlignmentLeft
#   define kLabelAlignmentRight     NSTextAlignmentRight
#   define kLabelTruncationTail     NSLineBreakByTruncatingTail
#   define kLabelTruncationMiddle   NSLineBreakByTruncatingMiddle
#   define kLabelLineBreakModeWordWrap   NSLineBreakModeWordWrap
#else // older versions
#   define kLabelAlignmentCenter    UITextAlignmentCenter
#   define kLabelAlignmentLeft      UITextAlignmentLeft
#   define kLabelAlignmentRight     UITextAlignmentRight
#   define kLabelTruncationTail     UILineBreakModeTailTruncation
#   define kLabelTruncationMiddle   UILineBreakModeMiddleTruncation
#   define kLabelLineBreakModeWordWrap   UILineBreakModeWordWrap
#endif


#define ZY_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
#define ZY_BARBUTTON_TITLE(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define ZY_BARBUTTON_IMAGE(IMAGE, SELECTOR) 	[[UIBarButtonItem alloc] initWithImage:IMAGE style:UIBarButtonItemStylePlain target:self action:SELECTOR]
#define ZY_BARBUTTON_CUSTOMVIEW(customView)		[[UIBarButtonItem alloc] initWithCustomView:customView]
#define ZY_BARBUTTON_ITEM(ITEM, SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR]


#define ZY_BASIC_COLOR SF_COLOR(0.000000,0.533333,0.905882,1)



#define MERCATOR_OFFSET 268435456 //(total pixels at zoom level 20) / 2
#define MERCATOR_RADIUS 85445659.44705395

@interface UtilitiesHelper : NSObject{
    
}
+(instancetype)shareHelper;
+ (void)deleteImage;
+ (BOOL) isFirstLaunchForSwipeView;
+ (NSString *)applicationDocumentsDirectory;

+ (NSData *)Convert2Utf8:(NSData *)data;
//Map conversion methods
+ (double)longitudeToPixelSpaceX:(double)longitude;
+ (double)latitudeToPixelSpaceY:(double)latitude;
+ (double)pixelSpaceXToLongitude:(double)pixelX;
+ (double)pixelSpaceYToLatitude:(double)pixelY;
+ (void)callPhone:(NSString *)phoneNumber;

+ (NSString *)getComData:(NSString *)addTime;
+ (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage size:(CGSize)imageSize;
+ (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (NSString *)getCityName:(NSString *)cityInfo;
+ (UIImage *)imageWithColor:(UIColor *)color;
//获得两点之间的距离
+(CLLocationDistance)getDistanceLatitude:(NSString *)latitude longitude:(NSString *)longitude otherLatitude:(NSString *)otherLatitude otherLongitude:(NSString *)otherLongitude;



//计算时间 例如：刚刚、几秒钟前、几分钟前
+ (NSString *)calculateTime:(NSString *)dateString;
+ (NSString *)calculateTimeWithhour:(NSString *)dateString ;

+(NSString *)getChinaDate:(NSString *) dateString;

- (BOOL)validatePhoneMobile:(NSString *)mobileNum;
-(BOOL)validateIDCardNumber:(NSString *)value;
- (UIImage *)imageFromPDFWithDocumentRef:(NSData*)fileData;
-(void)dialTelephoneNum:(NSString*)telephoneNum;
@end



@interface UIView (UIViewUtils)
- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (void)removeAllSubviews;

@end
@interface UINavigationBar (customImage)
- (void)drawRect:(CGRect)rect;
@end
@interface UITabBar (customImage)
- (void)drawRect:(CGRect)rect;
@end
@interface UINavigationBar (JTDropShadow)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

@end
