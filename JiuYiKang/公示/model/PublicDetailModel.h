//
//  PublicDetailModel.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PublicDetailDataModel : NSObject
@property(nonatomic,copy)NSString *age;
@property(nonatomic,copy)NSString *auth;
@property(nonatomic,copy)NSString *count_join;
@property(nonatomic,copy)NSString *creat_time;
@property(nonatomic,copy)NSString *date_enabled;
@property(nonatomic,copy)NSString *date_join;
@property(nonatomic,copy)NSString *date_money_collect;
@property(nonatomic,copy)NSString *date_pay;
@property(nonatomic,copy)NSString *date_public;
@property(nonatomic,copy)NSString *datetime_money_collect_infact;
@property(nonatomic,copy)NSString *face_uri;
@property(nonatomic,copy)NSString *detailID;
@property(nonatomic,copy)NSString *id_str;
@property(nonatomic,copy)NSString *is_disabled;
@property(nonatomic,copy)NSString *join_id;
@property(nonatomic,copy)NSString *money_collect;
@property(nonatomic,copy)NSString *money_each;
@property(nonatomic,copy)NSString *money_need;
@property(nonatomic,copy)NSString *product_id;
@property(nonatomic,copy)NSString *product_name;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *update_time;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,assign) CGFloat cellHeight;
@end


@interface PublicFileListModel : NSObject
@property(nonatomic,copy)NSString *image_uri;
@property(nonatomic,copy)NSString *name;
@end

@interface PublicDetailListModel : NSObject
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,assign) CGFloat cellHeight;
@end

@interface PublicReportListModel : NSObject
@property(nonatomic,copy)NSString *short_des;
@property(nonatomic,assign) CGFloat cellHeight;
@end

@interface PublicReportThreeListModel : NSObject
@property(nonatomic,copy)NSString *file_uri;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)UIImage *smallImage;
@property(nonatomic,copy)NSURL *fileUrl;
@end



@interface PublicDetailModel : NSObject
@property(nonatomic,copy)NSString *product_public_desc;
@property(nonatomic,strong)NSArray *publicDetailList;
@property(nonatomic,strong)NSArray *publicFileList;
@property(nonatomic,strong)NSArray *publicReportThreeList;
@property(nonatomic,strong)NSArray *publicReportList;
@property(nonatomic,strong)PublicDetailDataModel *dataModel;
@end
