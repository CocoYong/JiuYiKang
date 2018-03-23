//
//  UILabel+Universal.h
//  test
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Universal)
+(CGFloat)calculateLabelHeightWithContent:(NSString*)contentString andFontSize:(NSInteger)fontSize andRectSize:(CGSize)rectSize;
+(NSMutableAttributedString*)createAttributStringWithOriginalString:(NSString*)originalString specialTextArray:(NSArray*)textArray andAttributs:(NSDictionary*)attibuts;
+(NSMutableAttributedString*)changeHTMLstyleStringToUsingString:(NSString*)htmlString textFont:(UIFont*)font;
//返回固定宽度的String
+(NSMutableAttributedString*)getAttributStringWithOrignalString:(NSString*)orignalString andLineVerticalSpacing:(CGFloat)spacing andFirstIndent:(CGFloat)firstIndent;
@end
