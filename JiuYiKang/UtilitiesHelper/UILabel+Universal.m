//
//  UILabel+Universal.m
//  test
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "UILabel+Universal.h"
#import "SDWebImageManager.h"
@implementation UILabel (Universal)
+(CGFloat)calculateLabelHeightWithContent:(NSString *)contentString andFontSize:(NSInteger)fontSize  andRectSize:(CGSize)rectSize
{
    CGRect  rect=[contentString boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.height;
}
//创建特殊带颜色的字符串
+(NSMutableAttributedString*)createAttributStringWithOriginalString:(NSString*)originalString specialTextArray:(NSArray*)textArray andAttributs:(NSDictionary*)attibuts
{
    NSMutableAttributedString *attributString=[[NSMutableAttributedString alloc]initWithString:originalString];
    for (int i=0; i<textArray.count; i++) {
        NSRange textRange=[originalString rangeOfString:[textArray objectAtIndex:i]];
        [attributString setAttributes:attibuts range:textRange];
    }
    return attributString;
}

/**
 将html类型String转成UIlabel可以显示的string

 @param htmlString 原始的htmlString
 @return 返回UILabel可用的String
 */
+(NSMutableAttributedString*)changeHTMLstyleStringToUsingString:(NSString*)htmlString textFont:(UIFont*)font
{
    NSMutableAttributedString *componets=[[NSMutableAttributedString alloc] initWithString:htmlString attributes:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                                                                                                                   NSFontAttributeName:font}];
    return componets;
}
+(NSMutableAttributedString*)getAttributStringWithOrignalString:(NSString*)orignalString andLineVerticalSpacing:(CGFloat)spacing andFirstIndent:(CGFloat)firstIndent
{
    if (orignalString==nil) {
        return nil;
    }
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    style.lineSpacing=spacing;
    style.firstLineHeadIndent=firstIndent;
    NSMutableAttributedString *attributString=[[NSMutableAttributedString alloc]initWithString:orignalString attributes:@{NSParagraphStyleAttributeName:style}];
    [attributString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, orignalString.length)];
    return attributString;
}
@end
