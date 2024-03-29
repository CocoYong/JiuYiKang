//
//  TakePhotoOrLibraryView.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/28.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhotoCallBackBlock) (UIImage*editImage,NSString *imageURI,NSError *error);
typedef void (^PickerDataBlock) (NSString *passData,NSError *error);
@interface TakePhotoOrLibraryView : UIView
//弹出照相
-(instancetype)initWithFrame:(CGRect)frame andController:(id)showPhotoController andCallBackBlock:(PhotoCallBackBlock)block;

//弹出选择框
-(instancetype)initWithFrame:(CGRect)frame andDataSource:(NSArray*)dataArray andCallBackBlock:(PickerDataBlock)block;
-(void)showView;
@end
