//
//  BlessDetailModel.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessDetailModel.h"

@implementation BlessDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bless":@"data.bless",
             @"bless_images_list":@"data.bless_images_list",
             @"my_count_send_love":@"data.my_count_send_love",
             @"my_can_send_love":@"data.my_can_send_love",
             @"bless_reterence_list":@"data.bless_reterence_list",
             @"bless_love_list":@"data.bless_love_list",
             @"other_bless_list":@"data.other_bless_list",
             @"bless_money_desc":@"data.bless_money_desc",
             @"bless_type_chengnuo":@"data.bless_type_chengnuo",
             @"bless_type_shenming":@"data.bless_type_shenming",
             @"name":@"data.bless_type.name",
             @"desc":@"data.bless_type.desc",
             @"image_uri":@"data.bless_type.image_uri",
             @"bless_for_user_name_vi_name":@"data.bless_type.bless_for_user_name_vi_name",
             @"bless_reason_vi_name":@"data.bless_type.bless_reason_vi_name",
             @"money":@"data.bless_type.money",
             @"bless_for_user_name_images":@"data.bless.bless_for_user_name_images",
             @"bless_reason_images":@"data.bless.bless_reason_images",
             @"bless_reason_desc_more":@"data.bless.bless_reason_desc_more",
             @"share_desc":@"data.share_desc",
             @"share_img":@"data.share_img",
             @"share_title":@"data.share_title",
             @"free_product_ticket":@"data.free_product_ticket"
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"other_bless_list":[OtherBlessListModel class],
             @"bless_images_list":[ImageListModel class],
             @"bless_love_list":[BlessLoveListModel class],
             @"bless_reterence_list":[ReferencDataModel class],
             };
}

@end
@implementation BlessModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"blessID":@"id",
             };
}
@end
@implementation OtherBlessListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"blessID":@"id",
             };
}
@end
@implementation ImageListModel

@end
@implementation ReferencDataModel

@end
@implementation BlessLoveListModel

@end
@implementation OtherDataModel

@end
//@implementation ClassNmae
//+(NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{
//             @"<#key#>":@"data.<#value#>",
//             @"<#key#>":@"data.<#value#>",
//             @"<#key#>":@"data.<#value#>"
//             };
//}
//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"<#key#>":[<#value#> class],
//             @"<#key#>":[<#value#> class]
//             };
//}
//@end

