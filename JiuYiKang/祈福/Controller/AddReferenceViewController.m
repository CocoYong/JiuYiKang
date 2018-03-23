//
//  AddReferenceViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AddReferenceViewController.h"
#import "AddReferenceCell.h"
#import "AddReferenceModel.h"
#import "TakePhotoOrLibraryView.h"
#import "WeiXinPayManager.h"
#import "WXApi.h"
#import "MineBlessViewController.h"
@interface AddReferenceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *addReferenceTable;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyButt;

@property (weak, nonatomic) IBOutlet UIView *relationPickerBgView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView; //


@property(nonatomic,strong)AddReferenceModel *markModel;
@property(nonatomic,copy)NSString *markRelation;
@property(nonatomic,strong)NSMutableArray *updateArray;
@property(nonatomic,strong)NSMutableArray *pickerDataArray;
@end

@implementation AddReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatBackNavigationItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(success) name:@"paySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(success) name:@"payFailed" object:nil];

    
    //创建上传service的datamodel
    _updateArray=[NSMutableArray arrayWithCapacity:15];
        AddReferenceModel *model=[[AddReferenceModel alloc]init];
        [_updateArray addObject:model];
    //创建pickerView的数据源
    _pickerDataArray=[NSMutableArray arrayWithCapacity:10];
    for (BlessTypeRelationModel *model in self.beginModel.bless_user_relation_list) {
        [_pickerDataArray addObject:model.name];
    }
    //设置tableview
    self.addReferenceTable.rowHeight=523;
    self.addReferenceTable.estimatedRowHeight=UITableViewAutomaticDimension;
    self.footerView.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(self.payMoneyButt.frame)+20);
    
    [self.payMoneyButt setTitle:[NSString stringWithFormat:@"微信支付保证金:%@",self.beginModel.bless_type.money] forState:UIControlStateNormal];
}
#pragma mark - ---------->>>>>>>>>>tableview代理方法<<<<<<<<<<----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        AddReferenceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddReferenceCell"];
        cell.showRelationButt.tag=indexPath.row*4+0;
        [cell.showRelationButt addTarget:self action:@selector(showRelationPickerView:) forControlEvents:UIControlEventTouchUpInside];
        cell.personnalPhotoButt.tag=indexPath.row*4+1;
        [cell.personnalPhotoButt addTarget:self action:@selector(takePhotoOrSelectPhotoFromPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
        cell.cidPhotoButt.tag=indexPath.row*4+2;
        cell.deleteButt.tag=indexPath.row*4+3;
        [cell.cidPhotoButt addTarget:self action:@selector(takePhotoOrSelectPhotoFromPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
        if (indexPath.row>0) {
            cell.deleteButt.hidden=NO;
        }else
        {
            cell.deleteButt.hidden=YES;
        }
        [cell.deleteButt addTarget:self action:@selector(deleteCellAndModel:) forControlEvents:UIControlEventTouchUpInside];
        cell.numLabel.text=[NSString stringWithFormat:@"第%ld位证明人",indexPath.row+1];
        cell.cellModel=[self.updateArray objectAtIndex:indexPath.row];
        [cell configeCellDataWith:[self.updateArray objectAtIndex:indexPath.row]];
        return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.updateArray.count;
}
#pragma mark - ---------->>>>>>>>>>buttAction<<<<<<<<<<----------


-(void)deleteCellAndModel:(UIButton*)butt
{
    [self.updateArray removeObjectAtIndex:butt.tag/4];
    [self.addReferenceTable reloadData];
}
-(IBAction)showRelationPickerView:(UIButton*)butt
{
    self.markModel=[self.updateArray objectAtIndex:butt.tag/4];
    AddReferenceCell *cell=[self.addReferenceTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:butt.tag/4 inSection:0]];
    [cell.telephoneNumField resignFirstResponder];
    [cell.providenceWordTextView resignFirstResponder];
    TakePhotoOrLibraryView *pickerView=[[TakePhotoOrLibraryView alloc]initWithFrame:CGRectZero andDataSource:self.pickerDataArray andCallBackBlock:^(NSString *passData, NSError *error) {
        self.markModel.user_relative=passData;
        cell.relationLabel.textColor=[UIColor blackColor];
        [pickerView removeFromSuperview];
        [self.addReferenceTable reloadData];
    }];
    [pickerView showView];
}

-(void)takePhotoOrSelectPhotoFromPhotoLibrary:(UIButton*)butt
{
    self.markModel=[self.updateArray objectAtIndex:butt.tag/4];
    AddReferenceCell *cell=[self.addReferenceTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:butt.tag/4 inSection:0]];
    [cell.telephoneNumField resignFirstResponder];
    [cell.providenceWordTextView resignFirstResponder];
    TakePhotoOrLibraryView *photoView=[[TakePhotoOrLibraryView alloc]initWithFrame:CGRectZero andController:self andCallBackBlock:^(UIImage *editImage,NSString *imageURI,NSError *error) {
        [butt setImage:editImage forState:UIControlStateNormal];
        if (butt.tag%4==1) {
            self.markModel.face_uri=imageURI;
            self.markModel.faceImage=editImage;
        }else  if (butt.tag%4==2)
        {
          self.markModel.id_card_image=imageURI;
            self.markModel.showCIDImage=editImage;
        }
        [photoView removeFromSuperview];
    }];
    [photoView showView];
}
//继续添加证明人
- (IBAction)continueAddButtAction:(UIButton *)sender
{
    AddReferenceModel *model=[[AddReferenceModel alloc]init];
    [self.updateArray addObject:model];
    [self.addReferenceTable reloadData];
}
//支付保证金
- (IBAction)payMoneyButtAction:(UIButton *)sender
{
    for (int i=0; i<self.updateArray.count; i++) {
        AddReferenceModel *model=[self.updateArray objectAtIndex:i];
        if (![model chechInfomationIsOK])
        {
            NSString *tempString=[NSString stringWithFormat:@"第%d个证明人的%@",i+1,[model checkPropertyIsEmpty]];
            [MBProgressHUD show:tempString view:self.view time:3];
            return;
        }
    }
    NSString *user_name=[self getAllStringBy:self.updateArray andPropertyName:@"user_name"];
    NSString *user_mobile=[self getAllStringBy:self.updateArray andPropertyName:@"user_mobile"];
    NSString *user_relative=[self getAllStringBy:self.updateArray andPropertyName:@"user_relative"];
    NSString *face_uri=[self getAllStringBy:self.updateArray andPropertyName:@"face_uri"];
    NSString *id_card_image=[self getAllStringBy:self.updateArray andPropertyName:@"id_card_image"];
    NSString *other_images=[self getAllStringBy:self.updateArray andPropertyName:@"other_images"];
    NSString *desc=[self getAllStringBy:self.updateArray andPropertyName:@"desc"];
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"bless_id":self.typeID,@"user_name":user_name,@"user_mobile":user_mobile,@"user_relative":user_relative,@"face_uri":face_uri,@"id_card_image":id_card_image,@"other_images":other_images,@"desc":desc};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/add_reterence" params:paramsDic block:^(NSObject *result) {
        NSDictionary *tempDic=(NSDictionary*)result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self payMoneyForProtectMoney:[tempDic objectForKey:@"data"]];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)payMoneyForProtectMoney:(NSDictionary*)dic
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
-(NSString*)getAllStringBy:(NSMutableArray*)dataArray andPropertyName:(NSString*)propertyName
{
    NSMutableString *newString=[[NSMutableString alloc]initWithCapacity:10];
    for (int i=0; i<dataArray.count; i++) {
        AddReferenceModel *model=[dataArray objectAtIndex:i];
        [newString appendFormat:@"%@,",[model valueForKey:propertyName]];
    }
    return  [newString substringWithRange:NSMakeRange(0, newString.length-1)];
}



#pragma mark - ---------->>>>>>>>>>请求网络<<<<<<<<<<----------
-(void)success
{
    MineBlessViewController *mineBlessListController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"MineBlessViewController"];
    mineBlessListController.fromType=@"addReference";
    [self showViewController:mineBlessListController sender:nil];
}
@end
