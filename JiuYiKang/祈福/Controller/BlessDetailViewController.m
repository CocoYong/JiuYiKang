//
//  BlessDetailViewController.m
//  JiuYiKang
//
//  Created by yong zhang on 2017/11/19.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BlessDetailViewController.h"
#import "BlessDetailCell.h"
#import "BlessDetailModel.h"
#import "BlessDetailSectionHeaderView.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Universal.h"
#import "LoginViewController.h"
#import "RootTabBarController.h"
#import "RegisterViewController.h"
#import "MineBlessViewController.h"
#import "RootTabBarController.h"
#import "UIButton+AFNetworking.h"
#import "HUPhotoBrowser.h"

//微信分享
#import "WXApi.h"
#import "WXApiObject.h"

#import "QQApiInterface.h"
#import "QQApiInterfaceObject.h"
#import "TencentOAuth.h"

#import "WeiXinPayManager.h"
@interface BlessDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *headerArray;
    NSMutableArray *showImagesArray;
}
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property(nonatomic,strong)BlessDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIView *popAlertView;
@property (weak, nonatomic) IBOutlet UIView *grayBgView;

@property (weak, nonatomic) IBOutlet UIButton *joinHelpButt;
@property (weak, nonatomic) IBOutlet UIButton *wantBlessButt;
@property (weak, nonatomic) IBOutlet UIButton *loveStarButt;


@property (weak, nonatomic) IBOutlet UIView *sendLoveStarBgView;
@property (weak, nonatomic) IBOutlet UIView *payBgView;
@property (weak, nonatomic) IBOutlet UIButton *payButt;

@property (weak, nonatomic) IBOutlet UIView *alertBgView;
@property (weak, nonatomic) IBOutlet UIView *shareAlertBgView;
@property (weak, nonatomic) IBOutlet UIView *erWeiMaBgView;


//分享链接
@property(nonatomic,copy)NSString *shareURLString;

@end

@implementation BlessDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    self.alertBgView.layer.cornerRadius=10;
    self.alertBgView.clipsToBounds=YES;
    self.shareAlertBgView.layer.cornerRadius=10;
    self.joinHelpButt.layer.cornerRadius=5;
    self.wantBlessButt.layer.cornerRadius=5;
    
    UITapGestureRecognizer *dismissController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissSelf)];
    [self.grayBgView addGestureRecognizer:dismissController];
    headerArray=@[@"😀",@"证明人",@"证明材料",@"为Ta祈福",@"其他祈福信息"];
    showImagesArray=[NSMutableArray arrayWithCapacity:10];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToMineBlessListController) name:@"paySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToMineBlessListController) name:@"payFailed" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestGetShowDataFromService:self.productID];
}
- (IBAction)sendLoveStarButt:(UIButton *)sender
{
    if ([self judgeLoginStatus]) {
        self.popAlertView.hidden=NO;
        self.shareAlertBgView.hidden=YES;
        self.erWeiMaBgView.hidden=YES;
    }else
    {
        [self sendLoveStarRequest];
        self.popAlertView.hidden=YES;
    }
}
- (IBAction)closeErWeiMaButtAction:(UIButton *)sender {
    self.popAlertView.hidden=YES;
}

- (IBAction)closeButtAction:(UIButton *)sender {
    self.popAlertView.hidden=YES;
}
- (IBAction)sureButtAction:(UIButton *)sender {
    self.popAlertView.hidden=YES;
    //保存blessid
    [[NSUserDefaults standardUserDefaults] setObject:self.detailModel.bless.blessID forKey:@"blessID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    RegisterViewController *registerController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    registerController.fromType=@"detailControleler";
    registerController.tickit=self.detailModel.free_product_ticket;
    [self showViewController:registerController sender:nil];
}
- (IBAction)cancelButtAction:(UIButton *)sender {
    self.popAlertView.hidden=YES;
}
- (IBAction)addHelpEachOtherButtAction:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [TABBARCONTROLLER selectedTabNum:0];
}


- (IBAction)wantBlessButt:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [TABBARCONTROLLER selectedTabNum:1];
}
- (IBAction)shareDataWithOthers:(UIButton *)sender
{
    [self shareViewCall];
}



#pragma mark - ---------->>>>>>>>>>特殊cell特殊定制方法<<<<<<<<<<----------
-(UIView*)createImageViewForCell:(NSArray*)dataArray
{
    //材料view背景view
    UIView *bgOneView=[[UIView alloc]init];
    CGFloat buttWidth=(SCREENWIDTH-50)/4;
    NSInteger rowNum=floor((dataArray.count-1)/4)+1;
    for (int i=0; i<rowNum; i++)
    {
        NSInteger tempMark;
        if (i==rowNum-1)
        {
            tempMark=dataArray.count-(rowNum-1)*4;
        }else
        {
            tempMark=4;
        }
        for (int j=0; j<tempMark; j++) {
            ImageListModel *listModel=[dataArray objectAtIndex:i*4+j];
            //imageView
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i, buttWidth, buttWidth)];
            imageView.tag=(i*4+j)+600;
//            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBaseURL,listModel.image_uri_thumb]] placeholderImage:[UIImage imageNamed:@"pic1"] options:SDWebImageRefreshCached];
            UILabel *imageTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i+buttWidth+10, buttWidth, 20)];
            imageTitleLabel.text=listModel.name;
            imageTitleLabel.tag=(i*4+j)+500;
            imageTitleLabel.font=[UIFont systemFontOfSize:13];
            imageTitleLabel.textAlignment=NSTextAlignmentCenter;
            
            UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
            butt.frame=CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i, buttWidth, buttWidth);
            [butt setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBaseURL,listModel.image_uri_thumb]]];
            butt.tag=(i*3+j)+400;
            [butt addTarget:self action:@selector(showImageInBrower:) forControlEvents:UIControlEventTouchUpInside];
            
            [bgOneView addSubview:butt];
            [bgOneView addSubview:imageView];
            [bgOneView addSubview:imageTitleLabel];
        }
    }
    bgOneView.frame=CGRectMake(0, 10, SCREENWIDTH, rowNum*(buttWidth+40)+10);
    return bgOneView;
}
-(UIView*)creatGreenViewWith:(NSArray*)textArray
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(100, 31, SCREENWIDTH-130, textArray.count*25+5)];
    for (int i=0; i<textArray.count; i++) {
        UIImageView *greenImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, i*25, 20, 20)];
        greenImage.image=[UIImage imageNamed:@"icon_fxa2"];
        [view addSubview:greenImage];
        
        UILabel *greenTextLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, i*25, CGRectGetWidth(view.frame)-40, 20)];
        greenTextLabel.text=[textArray objectAtIndex:i];
        greenTextLabel.font=[UIFont systemFontOfSize:13];
        greenTextLabel.textAlignment=NSTextAlignmentLeft;
        greenTextLabel.textColor=[UtilitiesHelper colorWithHexString:@"#53B262"];
        [view addSubview:greenTextLabel];
    }
    return view;
}
-(UIView*)createGrayView:(NSArray*)stringArray
{
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:stringArray];
    [tempArray removeObjectAtIndex:0];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(100, 26, SCREENWIDTH-130, tempArray.count*27+5)];
    
    for (int i=0; i<tempArray.count; i++) {
        UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, i*25, CGRectGetWidth(view.frame), 22)];
        textLabel.text=[stringArray objectAtIndex:i];
        textLabel.font=[UIFont systemFontOfSize:13];
        textLabel.textAlignment=NSTextAlignmentLeft;
        textLabel.textColor=[UIColor darkGrayColor];
        [view addSubview:textLabel];
    }
    return view;
}
-(UIView*)createImageView:(NSArray*)dataArray
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectZero];
    
    CGFloat iamgeViewWidth=(SCREENWIDTH-60)/6;
    if (dataArray.count<=6) {
        view.frame=CGRectMake(0, 0, SCREENWIDTH, iamgeViewWidth+20);
    }else
    {
        view.frame=CGRectMake(0, 0, (iamgeViewWidth+10)*dataArray.count, iamgeViewWidth+20);
    }
    for (int i=0; i<dataArray.count; i++) {
        UIImageView *greenImage=[[UIImageView alloc]initWithFrame:CGRectMake(5+i*(iamgeViewWidth+10), 10, iamgeViewWidth, iamgeViewWidth)];
        greenImage.clipsToBounds=YES;
        greenImage.layer.cornerRadius=iamgeViewWidth/2;
        BlessLoveListModel *tempModel=dataArray[i];
        NSString *urlString;
        if ([tempModel.face_uri hasPrefix:@"http://"]) {
            urlString=tempModel.face_uri;
        }else
        {
         urlString=[NSString stringWithFormat:@"%@%@",KBaseURL,tempModel.face_uri];
        }
        [greenImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"tx"] options:SDWebImageRefreshCached];
        [view addSubview:greenImage];
    }
    return view;
}
-(void)showImageInBrower:(UIButton*)butt
{
    BlessDetailCell *cell=[self.detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    UIImageView *tempImageView=[cell.contentView viewWithTag:butt.tag+200];
    [HUPhotoBrowser showFromImageView:tempImageView withURLStrings:showImagesArray atIndex:butt.tag-400];
}
#pragma mark - ---------->>>>>>>>>>tableview代理方法<<<<<<<<<<----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     BlessDetailCell *cell;
     if (indexPath.section==0) {
         switch (indexPath.row) {
             case 0:
             {
              cell=[tableView dequeueReusableCellWithIdentifier:@"BlessDetailHeaderOne"];
                 NSMutableAttributedString *calString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_money_desc andLineVerticalSpacing:5 andFirstIndent:0];
                 CGFloat introDetailHeight=[calString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                 cell.introDetailLabel.attributedText=calString;
                 cell.introDetailLabel.frame=CGRectMake(100, CGRectGetMidY(cell.headImageView.frame)-introDetailHeight/2, SCREENWIDTH-130, introDetailHeight);
             }
                 break;
             case 1:
             {
                 cell=[tableView dequeueReusableCellWithIdentifier:@"BlessDetailTitleCell"];
                 NSMutableAttributedString *calString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless.name andLineVerticalSpacing:5 andFirstIndent:0];
                 CGFloat introDetailHeight=[calString boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                 cell.mainTitleLabel.attributedText=calString;
                 cell.mainTitleLabel.frame=CGRectMake(10, 20, SCREENWIDTH-20, introDetailHeight);
             }
                 break;
             case 2:
             {
              cell=[tableView dequeueReusableCellWithIdentifier:@"BlessDetailHeaderTwo"];
                NSString *faceUrl=[NSString stringWithFormat:@"%@%@",KBaseURL,self.detailModel.bless.face_uri];
                 [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString: faceUrl] placeholderImage:[UIImage imageNamed:@"tx2"] options:SDWebImageRefreshCached];
                 cell.nameLabel.text=self.detailModel.bless.creator_user_name;
//                 if ([self.detailModel.bless.bless_stat_str isEqualToString:@"审核中"]||[self.detailModel.bless.bless_stat_str isEqualToString:@"待支付"]) {
//                 }else
//                 {
//
//                 }
                 cell.dateLabel.text=self.detailModel.bless.date_show;
                 cell.projectLabel.text=self.detailModel.bless.bless_type_name;
                 cell.statusLabel.text=self.detailModel.bless.bless_stat_str;
//                 cell.needStarNumLabel.text=self.detailModel.bless.count_bless_love;
                 cell.haveRecieveStarLabel.text=[NSString stringWithFormat:@"%@颗", self.detailModel.bless.count_bless_love];
             }
                 break;
             case 3:
             {
               cell=[tableView dequeueReusableCellWithIdentifier:@"BlessDetailHeaderThree"];
                 NSMutableAttributedString *attributString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless.desc andLineVerticalSpacing:5 andFirstIndent:0];
                 CGFloat descHeight=[attributString boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                 cell.detailLabel.attributedText=attributString;
                 cell.detailLabel.frame=CGRectMake(10, 40, SCREENWIDTH-20, descHeight);
             }
                 break;
             case 4:
             {
                cell=[tableView dequeueReusableCellWithIdentifier:@"BlessDetailHeaderFour"];
                 for (UIView *view in cell.contentView.subviews) {
                     [view removeFromSuperview];
                 }         
                 if (self.detailModel.bless_images_list!=nil&&self.detailModel.bless_images_list.count!=0) {
                   [cell.contentView addSubview:[self createImageViewForCell:self.detailModel.bless_images_list]];
                 }
             }
                 break;
             default:
                 break;
         }
         
     }
   else if (indexPath.section==1) {
      cell=[tableView dequeueReusableCellWithIdentifier:@"BlessCellOne"];
        ReferencDataModel *referenceModel=[self.detailModel.bless_reterence_list objectAtIndex:indexPath.row];
        [cell.referencePhotoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KBaseURL,referenceModel.face_uri]] placeholderImage:[UIImage imageNamed:@"tx"] options:SDWebImageRefreshCached];
        cell.referenceNameLabel.text=referenceModel.user_name;
        cell.referenceWordsLabel.text=referenceModel.desc;
       cell.predenceLabel.text=([referenceModel.pass_stat integerValue]==2)?@"已认证":@"未认证";
        cell.referenceRelationLabel.text=referenceModel.user_relative;
        
    }else if (indexPath.section==2)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"BlessCellTwo"];
        for (UIView *view in cell.cellTwoBackView.subviews) {
            if ([view isMemberOfClass:[UIView class]]) {
                [view removeFromSuperview];
            }
        }
        if (indexPath.row==0)
        {
            cell.mainWordLabel.text=self.detailModel.bless_for_user_name_vi_name;
            cell.infoLabel.text=self.detailModel.bless.bless_for_user_name;
            [cell.cellTwoBackView addSubview:[self creatGreenViewWith:self.detailModel.bless.bless_for_user_name_images]];
        }else if (indexPath.row==1)
        {
            cell.mainWordLabel.text=self.detailModel.bless_reason_vi_name;
            cell.infoLabel.text=self.detailModel.bless.bless_reason;
            [cell.cellTwoBackView addSubview:[self creatGreenViewWith:self.detailModel.bless.bless_reason_images]];
        }else if (indexPath.row==2)
        {
            cell.mainWordLabel.text=@"增补信息";
            cell.infoLabel.text=@"";
            if (self.detailModel.bless.bless_reason_desc_more!=nil) {
                UIView *tempView=[self creatGreenViewWith:self.detailModel.bless.bless_reason_desc_more];
                CGFloat ypoint=tempView.frame.origin.y-20;
                tempView.frame=CGRectMake(tempView.origin.x, ypoint, tempView.frame.size.width, tempView.frame.size.height);
             [cell.cellTwoBackView addSubview:tempView];
            }
//            for (int i=0; i<self.detailModel.bless.bless_reason_desc_more.count; i++) {
//                [cell.cellTwoBackView addSubview:[self creatGreenViewWith:[self.detailModel.bless.bless_reason_desc_more objectAtIndex:i] andFrame:CGRectMake(100, 30+i*30, SCREENWIDTH-130, 30) andType:2]];
//            }
        }else if(indexPath.row==3)
        {
            cell.mainWordLabel.text=@"发起人承诺";
            NSMutableAttributedString *tempString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_type_chengnuo andLineVerticalSpacing:5 andFirstIndent:0];
            cell.infoLabel.attributedText=tempString;
            CGRect  secondLabelRect=[tempString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            cell.infoLabel.frame=CGRectMake(100, 8, SCREENWIDTH-130, secondLabelRect.size.height);
        }else
        {
            cell.mainWordLabel.text=@"平台声明";
            NSMutableAttributedString *tempString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_type_shenming andLineVerticalSpacing:5 andFirstIndent:0];
            cell.infoLabel.attributedText=tempString;
            CGRect  secondLabelRect=[tempString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            cell.infoLabel.frame=CGRectMake(100, 8, SCREENWIDTH-130, secondLabelRect.size.height);
        }
        return cell;
    }
    else if (indexPath.section==3)
    {
         cell=[tableView dequeueReusableCellWithIdentifier:@"BlessCellThree"];
        [cell.scrollView addSubview:[self createImageView:self.detailModel.bless_love_list]];
        CGFloat iamgeViewWidth=(SCREENWIDTH-60)/6;
        CGFloat contentSizeWidth=(iamgeViewWidth+10)*self.detailModel.bless_love_list.count;
        cell.scrollView.contentSize=CGSizeMake(contentSizeWidth, (SCREENWIDTH-60)/6+20);
    }else
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"BlessCellFour"];
        OtherBlessListModel *model=[self.detailModel.other_bless_list objectAtIndex:indexPath.row];
        cell.descLabel.text=model.name;
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                if (self.detailModel.bless_money_desc!=nil) {
            NSMutableAttributedString *calString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_money_desc andLineVerticalSpacing:5 andFirstIndent:0];
            CGFloat introDetailHeight=[calString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                    return introDetailHeight+20<=100?120:introDetailHeight+40;
                }else
                {
                    return 0;
                }
                
            }
                break;
            case 1:
            {
                NSMutableAttributedString *calString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless.name andLineVerticalSpacing:5 andFirstIndent:0];
                CGFloat introDetailHeight=[calString boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                return introDetailHeight<=30?40:introDetailHeight+20;
            }
                break;
            case 2:
            {
                return 155;
                
            }
                break;
            case 3:
            {
                if (self.detailModel.bless.desc!=nil) {
                    NSMutableAttributedString *calString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless.desc andLineVerticalSpacing:5 andFirstIndent:0];
                    CGFloat introDetailHeight=[calString boundingRectWithSize:CGSizeMake(SCREENWIDTH-20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                    return introDetailHeight<=35?60:introDetailHeight+40;
                }else
                {
                    return 0;
                }
                
            }
                break;
            case 4:
            {
                if (self.detailModel.bless_images_list!=nil&&self.detailModel.bless_images_list.count!=0) {
                    CGFloat buttWidth=(SCREENWIDTH-50)/4;
                    NSInteger rowNum=floor((self.detailModel.bless_images_list.count-1)/4)+1;
                    return rowNum*(buttWidth+40)+10;
                }else
                {
                    return 0;
                }
                
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section==1) {
        return 101;
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0) //姓名
        {
            return 48+(25*self.detailModel.bless.bless_for_user_name_images.count);
        }
        else if (indexPath.row==1) //所患疾病
        {
            if (self.detailModel.bless_reason_vi_name!=nil) {
//                NSMutableAttributedString *attributString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_reason_vi_name andLineVerticalSpacing:5 andFirstIndent:0];
//                CGFloat  height=[attributString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
                return 48+(self.detailModel.bless.bless_reason_images.count*25);
            }else
            {
                return 0;
            }
            
        }
        else if (indexPath.row==2) //增补信息
        {
            if (self.detailModel.bless.bless_reason_desc_more!=nil) {
                return    22+(self.detailModel.bless.bless_reason_desc_more.count*25);
            }else
            {
                return 0;
            }
        }else if (indexPath.row==3)//发起人承诺
        {
            if (self.detailModel.bless_type_chengnuo!=nil) {
                NSMutableAttributedString *attributString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_type_chengnuo andLineVerticalSpacing:5 andFirstIndent:0];
                CGRect  secondLabelRect=[attributString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
                return secondLabelRect.size.height+26;
            }else
            {
                return 0;
            }
        }else   //平台声明
        {
            if (self.detailModel.bless_type_shenming!=nil) {
                NSMutableAttributedString *attributString=[UILabel getAttributStringWithOrignalString:self.detailModel.bless_type_shenming andLineVerticalSpacing:5 andFirstIndent:0];
                CGRect  secondLabelRect=[attributString boundingRectWithSize:CGSizeMake(SCREENWIDTH-130, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
                return secondLabelRect.size.height+26;
            }else
            {
                return 0;
            }
            
        }
    }
    else if (indexPath.section==3)
    {
        CGFloat imageHeight=(SCREENWIDTH-60)/6;
        return imageHeight+20;
        
    }else
    {
        return 44;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
    }
    else if (section==1) {
        return self.detailModel.bless_reterence_list.count;
    }else if (section==2)
    {
        return 5;
    }else if (section==3)
    {
        return 1;
    }else
    {
        return self.detailModel.other_bless_list.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.fromController isEqualToString:@"listController"]) {
        return 5;
    }else
    {
        if ([self.detailModel.bless.bless_stat_str isEqualToString:@"审核中"]||[self.detailModel.bless.bless_stat_str isEqualToString:@"待支付"]) {
            return 2;
        }else
        {
            return 4;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *reuseIdentifier=@"headerIdentifier";
    BlessDetailSectionHeaderView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!header) {
        header=[[BlessDetailSectionHeaderView alloc]initWithReuseIdentifier:reuseIdentifier];
    }
    header.titleLabel.text=[headerArray objectAtIndex:section];
    CGSize  labelSize=[header.titleLabel sizeThatFits:CGSizeMake(SCREENWIDTH, 22)];
    header.titleLabel.frame=CGRectMake(10, 20, labelSize.width, 22);
    header.redLineView.frame=CGRectMake(10, CGRectGetMaxY(header.titleLabel.frame)+10, labelSize.width, 1);
    header.lineImage.frame=CGRectMake(10, CGRectGetMaxY(header.titleLabel.frame)+10, SCREENWIDTH-20, 1);
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==4) {
        [showImagesArray removeAllObjects];
        OtherBlessListModel *otherModel=[self.detailModel.other_bless_list objectAtIndex:indexPath.row];
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
        [self  requestGetShowDataFromService:otherModel.blessID];
    }
}

- (IBAction)payButtAction:(UIButton *)sender
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"bless_id":self.detailModel.bless.blessID};
    [ZYDataRequest requestWithURL:@"AppApi/Bless/pay" params:paramsDic block:^(NSObject *result) {
            NSDictionary *tempDic=(NSDictionary*)result;
            if ([[tempDic objectForKey:@"code"] integerValue]==0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self startPayAction:[[tempDic objectForKey:@"data"] objectForKey:@"app_params"]];
                });
            }else
            {
                [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:3];
            }
        } errorBlock:^(NSError *error) {
            [MBProgressHUD showError:error.description toView:self.view];
        } noNetWorking:^(NSString *noNetWorking) {
            [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
        }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    BlessDetailCell *cell=[self.detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    CGFloat iamgeViewWidth=(SCREENWIDTH-60)/6;
    CGFloat maxContentX=((iamgeViewWidth+10)*self.detailModel.bless_love_list.count)-SCREENWIDTH;
    if (scrollView==cell.scrollView) {
        if (cell.scrollView.contentOffset.x>=maxContentX) {
            cell.scrollView.contentOffset=CGPointMake(0, 0);
        }
    }
}

-(void)startPayAction:(NSDictionary*)dic
{
    [[WeiXinPayManager sharedManager] payForWeiXin:dic andDelegateController:self andCallBackBlock:^(BOOL result) {
        if (result) {
            [MBProgressHUD show:@"支付成功" view:self.view time:1.5];
        }else
        {
            [MBProgressHUD show:@"支付失败" view:self.view time:1.5];
        }
       
    }];
}
-(void)jumpToMineBlessListController
{
    MineBlessViewController *mineBlessListController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"MineBlessViewController"];
    mineBlessListController.fromType=@"detailController";
    [self showViewController:mineBlessListController sender:nil];
}


#pragma mark -   分享相关代码
-(void)shareViewCall
{
    self.shareURLString=[NSString stringWithFormat:@"%@/%@%@",KBaseURL,@"bless/detail/",self.productID];
    self.popAlertView.hidden=NO;
    self.alertBgView.hidden=YES;
    self.erWeiMaBgView.hidden=YES;
    self.shareAlertBgView.hidden=NO;

}
-(void)dismissSelf
{
    self.popAlertView.hidden=YES;
}

- (IBAction)ButtonWeixin {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.bText = NO;
        req.scene = WXSceneSession;// 分享到会话
        WXMediaMessage *medMessage = [WXMediaMessage message];
        medMessage.title = self.detailModel.share_title; // 标题
        medMessage.description = self.detailModel.share_desc;// 描述
        WXWebpageObject *webPageObj = [WXWebpageObject object];
        [medMessage setThumbImage:self.detailModel.shareImage];// 缩略图
        webPageObj.webpageUrl = self.shareURLString;
        medMessage.mediaObject = webPageObj;
        req.message = medMessage;
        [WXApi sendReq:req];
    } else {
        [MBProgressHUD show:@"还没有安装微信" view:self.view time:1.5];
    }
    self.popAlertView.hidden=YES;
}
- (IBAction)WeixinFriendCircle {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.bText = NO;
        req.scene = WXSceneTimeline;// 分享到会话
        WXMediaMessage *medMessage = [WXMediaMessage message];
        medMessage.title = self.detailModel.share_title; // 标题
        medMessage.description = self.detailModel.share_desc;// 描述
        WXWebpageObject *webPageObj = [WXWebpageObject object];
        [medMessage setThumbImage:self.detailModel.shareImage];// 缩略图
        webPageObj.webpageUrl = self.shareURLString;
        medMessage.mediaObject = webPageObj;
        req.message = medMessage;
        [WXApi sendReq:req];
    } else {
        [MBProgressHUD show:@"还没有安装微信" view:self.view time:1.5];
    }
    self.popAlertView.hidden=YES;
}
#pragma mark  - ---requestService
-(void)requestGetShowDataFromService:(NSString*)typeID
{
    NSDictionary *paramsDic=@{@"bless_id":typeID,@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")==nil?@"":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Bless/detail" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"]integerValue]==0) {
            self.detailModel=[BlessDetailModel mj_objectWithKeyValues:result];
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:self.detailModel.bless.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]] options:SDWebImageHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                self.detailModel.shareImage=[UtilitiesHelper makeThumbnailFromImage:image size:CGSizeMake(300, 300)];
                for (ImageListModel * listModel in self.detailModel.bless_images_list) {
                    NSString *perfectUrlString=[NSString stringWithFormat:@"%@%@",KBaseURL,listModel.image_uri];
                    [showImagesArray addObject:perfectUrlString];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.detailModel.bless.bless_stat_str isEqualToString:@"审核中"]||[self.detailModel.bless.bless_stat_str isEqualToString:@"祈福结束"]) {
                    self.sendLoveStarBgView.hidden=YES;
                    self.payBgView.hidden=YES;
                    self.detailTable.frame=CGRectMake(0, 50, SCREENWIDTH, SCREENHEIGHT-114);
                }
               else if ([self.detailModel.bless.bless_stat_str isEqualToString:@"待支付"]) {
                   self.sendLoveStarBgView.hidden=YES;
                   self.payBgView.hidden=NO;
                [self.payButt setTitle:[NSString stringWithFormat:@"微信支付保证金:%@",self.detailModel.money] forState:UIControlStateNormal];
                }else
                {
                    self.sendLoveStarBgView.hidden=NO;
                    self.payBgView.hidden=YES;
                }
                if ([self.detailModel.my_can_send_love integerValue]>0) {
                    [self.loveStarButt setImage:[UIImage imageNamed:@"icon_xin2"] forState:UIControlStateNormal];
                }else
                {
                    [self.loveStarButt setImage:[UIImage imageNamed:@"icon_xin3"] forState:UIControlStateNormal];
                }
                [self.detailTable reloadData];
            });
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)animationForAddOne
{
    UIImageView *starImageView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-40, SCREENHEIGHT/2-20, 60, 60)];
    starImageView.image=[UIImage imageNamed:@"add_xin"];
    [self.view addSubview:starImageView];
    
    [UIView animateWithDuration:2 animations:^{
        starImageView.frame=CGRectMake(SCREENWIDTH/2-40, 0, 60, 60);
    } completion:^(BOOL finished) {
        [starImageView removeFromSuperview];
    }];
}
-(void)sendLoveStarRequest
{
    NSDictionary *paramsDic=@{@"bless_id":self.productID,@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/bless_send_love" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        if ([[tempDic objectForKey:@"code"]integerValue]==0) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self animationForAddOne];
                self.popAlertView.hidden=NO;
                self.shareAlertBgView.hidden=YES;
                self.alertBgView.hidden=YES;
                self.erWeiMaBgView.hidden=NO;
                BlessDetailCell *cell=[self.detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell.haveRecieveStarLabel.text=[NSString stringWithFormat:@"%d颗", [self.detailModel.bless.count_bless_love integerValue]+1];
                [self.loveStarButt setImage:[UIImage imageNamed:@"icon_xin3"] forState:UIControlStateNormal];
               [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:1.5];
            });
        }else
        {
            [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:1.5];
        }
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
@end
