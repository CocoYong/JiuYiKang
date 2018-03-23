//
//  PublicDetailModel.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicDetailModel.h"
#import "UILabel+Universal.h"
@implementation PublicDetailModel
//-(void)setProduct_public_desc:(NSString *)product_public_desc
//{
//    _product_public_desc=product_public_desc;
//    self.cellHeight=[UILabel calculateLabelHeightWithContent:product_public_desc andFontSize:DETAILFONTSIZE andRectSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX)]+51;
//}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"dataModel":@"data.public_detail",
             @"publicReportList":@"data.public_report_list",
             @"publicReportThreeList":@"data.public_report_3rd_list",
             @"publicFileList":@"data.public_file_list",
             @"publicDetailList":@"data.public_detail_list",
             @"product_public_desc":@"data.product_public_desc"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"publicDetailList":[PublicDetailListModel class],
             @"publicFileList":[PublicFileListModel class],
             @"publicReportList":[PublicReportListModel class],
             @"publicReportThreeList":[PublicReportThreeListModel class]};
}
@end
@implementation PublicDetailDataModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"detailID":@"id"};
}
-(void)setShort_des:(NSString *)short_des
{
    _short_des=short_des;
     self.cellHeight=[UILabel calculateLabelHeightWithContent:short_des andFontSize:DETAILFONTSIZE andRectSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX)]+20;
}
@end
@implementation PublicDetailListModel
-(void)setShort_des:(NSString *)short_des
{
    _short_des=short_des;
     self.cellHeight=[UILabel calculateLabelHeightWithContent:_short_des andFontSize:DETAILFONTSIZE andRectSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX)]+20;
    
}
@end

@implementation PublicFileListModel
-(void)setImage_uri:(NSString *)image_uri
{
    if (![image_uri hasPrefix:@"http:"]) {
        _image_uri=[NSString stringWithFormat:@"%@%@",KBaseURL,image_uri];
    }
}


@end
@implementation PublicReportListModel
-(void)setShort_des:(NSString *)short_des
{
    _short_des=short_des;
    self.cellHeight=[UILabel calculateLabelHeightWithContent:_short_des andFontSize:DETAILFONTSIZE andRectSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX)]+20;    
}
@end
@implementation PublicReportThreeListModel

-(void)setFile_uri:(NSString *)file_uri
{
    if (![file_uri hasPrefix:@"http"]) {
        _file_uri=[NSString stringWithFormat:@"%@%@",KBaseURL,file_uri];
    }
}
@end
