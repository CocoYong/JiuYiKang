//
//  BlessDetailCell.h
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlessDetailModel;
@interface BlessDetailCell : UITableViewCell<UIScrollViewDelegate>

//sectionOne

@property (weak, nonatomic) IBOutlet UIImageView *headImageView; //图片
@property (weak, nonatomic) IBOutlet UILabel *introDetailLabel; //动动小手送爱心




@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;  //集爱心主题
//sectionTwo
@property (weak, nonatomic) IBOutlet UIView *borderBgView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView; //图像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;   //名字
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;  //日期

@property (weak, nonatomic) IBOutlet UIView *typeBgView;
@property (weak, nonatomic) IBOutlet UILabel *projectLabel; //大病互助。天下微孝，

@property (weak, nonatomic) IBOutlet UIView *statusBgView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; //进行中  已完结  等
@property (weak, nonatomic) IBOutlet UILabel *needStarNumLabel;  //目标爱心
@property (weak, nonatomic) IBOutlet UILabel *haveRecieveStarLabel; //已收集爱心
//第一个收集爱心bgView
@property (weak, nonatomic) IBOutlet UIView *starNumOnevView;
//第二个收集爱心bgView
@property (weak, nonatomic) IBOutlet UIView *starNumTwoView;



//sectionThree
@property (weak, nonatomic) IBOutlet UILabel *detailLabel; //详情说明




//cellOne

@property (weak, nonatomic) IBOutlet UIView *cellOneBackView;
@property (weak, nonatomic) IBOutlet UIImageView *referencePhotoImageView; //证明人图像
@property (weak, nonatomic) IBOutlet UILabel *referenceNameLabel; //证明人姓名
@property (weak, nonatomic) IBOutlet UILabel *referenceWordsLabel;//证明人说的话
@property (weak, nonatomic) IBOutlet UIView *stateBgView;
@property (weak, nonatomic) IBOutlet UILabel *referenceRelationLabel;//证明人和祈福人的关系
@property (weak, nonatomic) IBOutlet UILabel *predenceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *footerGrayLine;//灰色线条

//cellTwo

@property (weak, nonatomic) IBOutlet UIView *cellTwoBackView;
@property (weak, nonatomic) IBOutlet UILabel *mainWordLabel; //增补信息，发起人承诺，平台申明
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;//详细说明


//cellThree
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


//cellFour
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end
