//
//  PublicDetailViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/15.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "PublicDetailViewController.h"
#import "PublicDetailOneCell.h"
#import "PublicDetailTwoCell.h"
#import "PublicDetailThreeCell.h"
#import "RootTabBarController.h"
#import "PublicDetailModel.h"
#import "PublicHeaderFooterView.h"
#import "HUPhotoBrowser.h"
#import "UIButton+AFNetworking.h"
#import <QuickLook/QuickLook.h>
@interface PublicDetailViewController ()<UITableViewDelegate,UITableViewDataSource,QLPreviewControllerDataSource>
{
    PublicDetailModel *detailModel;
    NSMutableArray *imageArray;
    NSArray *headArray;
    PublicReportThreeListModel *markModel;
}
@property (weak, nonatomic) IBOutlet UITableView *publicDetailTableView;
@property (weak, nonatomic) IBOutlet UIView *publicHeaderView;
@property (weak, nonatomic) IBOutlet UIView *publicFooterView;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIWebView *alertWebView;

@end

@implementation PublicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    imageArray=[NSMutableArray arrayWithCapacity:10];
    headArray=@[@"基础资料",@"事件情况",@"调查过程",@"互助详情"];
    self.publicDetailTableView.tableHeaderView=self.publicHeaderView;
    self.publicDetailTableView.tableFooterView=self.publicFooterView;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TABBARCONTROLLER.tabBarView.hidden=YES;
    [self requestDataFromService];

}
#pragma mark
#pragma mark--------------requestData
-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"id":self.publicID};
    NSLog(@"paradic=====%@",paramsDic);
    [ZYDataRequest requestWithURL:@"AppApi/Public/product_public_detail" params:paramsDic block:^(NSObject *result) {
        detailModel=[PublicDetailModel mj_objectWithKeyValues:result];
        for (PublicFileListModel *model in detailModel.publicFileList) {
            [imageArray addObject:model.image_uri];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text=detailModel.dataModel.user_name;
            self.sexLabel.text=[detailModel.dataModel.sex integerValue]==2?@"女":@"男";
            [self.photoImageView setImageWithURL:[NSURL URLWithString:detailModel.dataModel.face_uri relativeToURL:[NSURL URLWithString:KBaseURL]]];
            self.ageLabel.text=[NSString stringWithFormat:@"%@岁",detailModel.dataModel.age];
            [self.publicDetailTableView reloadData];
            //刷新完列表再执行下载请求。。
            for (PublicReportThreeListModel *model in detailModel.publicReportThreeList) {
                [self requestPdfFileDataFromService:model];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)requestPdfFileDataFromService:(PublicReportThreeListModel*)threeModel
{
    [ZYDataRequest requestWithDownLoadURL:threeModel.file_uri block:^(NSData *data, NSURL *filePathUrl) {
     threeModel.smallImage=[[UtilitiesHelper shareHelper] imageFromPDFWithDocumentRef:data];
        threeModel.fileUrl=filePathUrl;
        threeModel.smallImage=[UIImage imageNamed:@"pdf.png"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self creatImageViewAndLabelInFooterView];
            [self.publicDetailTableView reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD showError:@"没有网络连接" toView:self.view];
    }];
}
#pragma mark
#pragma mark-----------buttAction
- (IBAction)questionAlertButtAction:(UIButton *)sender {
      [self.alertWebView loadHTMLString:detailModel.product_public_desc baseURL:nil];
    self.alertView.hidden=NO;
}

- (IBAction)alertViewButtAction:(UIButton *)sender {
    self.alertView.hidden=YES;
}

#pragma mark
#pragma mark----------tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 8;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return detailModel.publicReportList.count;
            break;
        case 3:
            return detailModel.publicDetailList.count;
            break;
        default:
            return 0;
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }else
    {
        if (indexPath.section==1) {
            return detailModel.dataModel.cellHeight;
        }else if (indexPath.section==2)
        {
            PublicReportListModel *model=[detailModel.publicReportList objectAtIndex:indexPath.row];
            return model.cellHeight;
        }else
        {
            PublicDetailListModel *model=[detailModel.publicDetailList objectAtIndex:indexPath.row];
            return model.cellHeight;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
         PublicDetailOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicDetailOneCell" forIndexPath:indexPath];
        if (indexPath.row==7) {
            cell.huiseXian.hidden=YES;
        }
        [cell configeCellModel:detailModel.dataModel withIndexPath:indexPath];
        return cell;
    }else
    {
        if (indexPath.section==1) {
           PublicDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicDetailTwoCell" forIndexPath:indexPath];
            cell.radioImageView.hidden=YES;
            cell.detailLabel.hidden=YES;
            cell.bigerDetailLabel.hidden=NO;
            if (detailModel.dataModel.short_des!=nil) {
                NSAttributedString *attributString=[self getHeadIndentStringWithIndent:2 andString:detailModel.dataModel.short_des andLabel:cell.bigerDetailLabel];
                cell.bigerDetailLabel.attributedText=attributString;
            }
//            cell.bigerDetailLabel.text=detailModel.dataModel.short_des;
            return cell;
        }
       else if (indexPath.section==2) {
          PublicDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicDetailTwoCell" forIndexPath:indexPath];
            PublicReportListModel *reportListModel=[detailModel.publicReportList objectAtIndex:indexPath.row];
            cell.detailLabel.text=reportListModel.short_des;
           return cell;
        }else
        {
            PublicDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PublicDetailTwoCell" forIndexPath:indexPath];
            PublicDetailListModel *detailListModel=[detailModel.publicDetailList objectAtIndex:indexPath.row];
            cell.detailLabel.text=detailListModel.short_des;
            return cell;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headIdentifier=@"headerReuse";
    PublicHeaderFooterView *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    if (!header) {
        header=[[PublicHeaderFooterView alloc]initWithReuseIdentifier:headIdentifier];
    }
    header.nameLabel.text=[headArray objectAtIndex:section];
    return header;
}
#pragma mark
#pragma mark---------创建tableFooterView
-(void)creatImageViewAndLabelInFooterView
{
    //提交材料模块头
    UIImageView *tempImageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    tempImageview.image=[UIImage imageNamed:@"huisetiao"];
    [self.publicFooterView addSubview:tempImageview];
    
    UIImageView *xiangguanHonse=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 5, 20)];
    xiangguanHonse.image=[UIImage imageNamed:@"icon_titda"];
    [self.publicFooterView addSubview:xiangguanHonse];
    
    UILabel *titleOneLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, SCREENWIDTH, 21)];
    titleOneLabel.text=@"相关材料";
    titleOneLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.publicFooterView addSubview:titleOneLabel];
    
    
    UIImageView *lineOneImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 50, SCREENWIDTH, 1)];
    lineOneImageView.image=[UIImage imageNamed:@"huisexian"];
    lineOneImageView.hidden=YES;
    [self.publicFooterView addSubview:lineOneImageView];
    
    
    //材料view背景view
    UIView *bgOneView=[[UIView alloc]init];
    CGFloat buttWidth=(SCREENWIDTH-40)/3;
    NSInteger rowNum=floor((detailModel.publicFileList.count-1)/3)+1;
    if (detailModel.publicFileList.count!=0) {
        for (int i=0; i<rowNum; i++) {
            NSInteger tempMark;
            if (i==rowNum-1) {
                tempMark=detailModel.publicFileList.count-(rowNum-1)*3;
            }else
            {
                tempMark=3;
            }
            for (int j=0; j<tempMark; j++) {
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i, buttWidth, buttWidth)];
                imageView.tag=(i*3+j)+600;
                UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
                butt.frame=CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i, buttWidth, buttWidth);
                PublicFileListModel *listModel=[detailModel.publicFileList objectAtIndex:i*3+j];
                [butt setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:listModel.image_uri]];
                butt.tag=(i*3+j)+400;
                [butt addTarget:self action:@selector(showImageWithBrower:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *imageTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i+buttWidth+10, buttWidth, 20)];
                imageTitleLabel.text=listModel.name;
                imageTitleLabel.tag=(i*3+j)+500;
                imageTitleLabel.textAlignment=NSTextAlignmentCenter;
                [bgOneView addSubview:butt];
                [bgOneView addSubview:imageView];
                [bgOneView addSubview:imageTitleLabel];
            }
        }
        bgOneView.frame=CGRectMake(0, 62, SCREENWIDTH, rowNum*(buttWidth+50)+20);
        [self.publicFooterView addSubview:bgOneView];
    }
    CGFloat  pointY=rowNum*(buttWidth+40)+70;
    if (detailModel.publicFileList.count==0) {
        bgOneView.frame=CGRectMake(0, 62, 0, 0);
        pointY=50;
    }
    
    
    
    //第三方材料头
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, pointY, SCREENWIDTH, 10)];
    imageview.image=[UIImage imageNamed:@"huisetiao"];
    [self.publicFooterView addSubview:imageview];
    
    UIImageView *hongseImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, pointY+20, 5, 20)];
    hongseImage.image=[UIImage imageNamed:@"icon_titda"];
    [self.publicFooterView addSubview:hongseImage];
    
    UILabel *titleTwoLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, pointY+20, SCREENWIDTH, 21)];
    titleTwoLabel.text=@"第三方报告";
    titleTwoLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.publicFooterView addSubview:titleTwoLabel];
    
    
    UIImageView *lineTwoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, pointY+50, SCREENWIDTH, 1)];
    lineTwoImageView.image=[UIImage imageNamed:@"huisexian"];
    lineTwoImageView.hidden=YES;
    [self.publicFooterView addSubview:lineTwoImageView];
    
    
    //第三方材料背景view
    UIView *bgView=[[UIView alloc]init];
    rowNum=floor((detailModel.publicReportThreeList.count-1)/3)+1;
    if (detailModel.publicReportThreeList.count!=0) {
    for (int i=0; i<rowNum; i++) {
        NSInteger tempMark;
        if (i==rowNum-1) {
            tempMark=detailModel.publicReportThreeList.count-(rowNum-1)*3;
        }else
        {
            tempMark=3;
        }
        for (int j=0; j<tempMark; j++) {
            PublicReportThreeListModel *listModel=[detailModel.publicReportThreeList objectAtIndex:i*3+j];
            UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
            butt.frame=CGRectMake(((buttWidth+10)*j)+10, (buttWidth+10)*i, buttWidth, buttWidth);
            [butt setImage:listModel.smallImage forState:UIControlStateNormal];
            butt.tag=(i*3+j)+700;
            [butt addTarget:self action:@selector(showPDFDocument:) forControlEvents:UIControlEventTouchUpInside];
            
//            UILabel *imageTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(((buttWidth+10)*j)+10, (buttWidth+40)*i+buttWidth+10, buttWidth, 20)];
//            imageTitleLabel.text=listModel.name;
//            imageTitleLabel.tag=(i*3+j)+800;
//            imageTitleLabel.textAlignment=NSTextAlignmentCenter;
            [bgView addSubview:butt];
//            [bgView addSubview:imageTitleLabel];
        }
    }
    bgView.frame=CGRectMake(0, CGRectGetMaxY(lineTwoImageView.frame), SCREENWIDTH, rowNum*(buttWidth+50));
    [self.publicFooterView addSubview:bgView];
    }
    //判断第三方报告是否为空
    if (detailModel.publicReportThreeList.count==0) {
        bgView.frame=CGRectMake(0, CGRectGetMaxY(lineTwoImageView.frame), SCREENWIDTH, 0);
    }
    self.publicFooterView.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(bgView.frame));
}

//-(void)getSmallImageWithModel:(PublicReportThreeListModel*)threeModel
//{
//   UIImage *samllImage=[[UtilitiesHelper shareHelper] imageFromPDFWithDocumentRef:threeModel.file_uri];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",threeModel.name]];// 保存文件的名称
//    BOOL result = [UIImagePNGRepresentation(samllImage) writeToFile: filePath atomically:YES];
//    if (result) {
//        threeModel.localSmallImageUrl=filePath;
//    }
//}





#pragma imageBrowser
-(void)showImageWithBrower:(UIButton*)butt
{
    UIImageView *tempImageView=[self.publicFooterView viewWithTag:butt.tag+200];
    [HUPhotoBrowser showFromImageView:tempImageView withURLStrings:imageArray atIndex:butt.tag-400];
}
//pdfBrowser
-(void)showPDFDocument:(UIButton*)butt
{
    QLPreviewController *QLPVC = [[QLPreviewController alloc] init];
    QLPVC.title=@"第三方报告";
    QLPVC.dataSource = self;
    markModel=[detailModel.publicReportThreeList objectAtIndex:butt.tag-700];
    [self presentViewController:QLPVC animated:YES completion:nil];
}

#pragma mark
#pragma mark   -------------------QlookViewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return markModel.fileUrl;
}

//首行缩进
-(NSAttributedString*)getHeadIndentStringWithIndent:(NSInteger)indent andString:(NSString*)textString andLabel:(UILabel*)label
{
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = label.font.pointSize * indent;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:textString attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    return attrText;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
