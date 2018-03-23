//
//  JoinViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "JoinViewController.h"
#import "MembershipViewController.h"
#import "PlanCauseViewController.h"
#import "JoinProjectCell.h"
#import "HealthRequireViewController.h"
#import "MembershipViewController.h"
#import "JoinFormModel.h"
#import "JoinCellModel.h"
#import "UniversalModel.h"
#import "WeiXinPayModel.h"
#import "WeiXinPayManager.h"
#import "WXApi.h"
#import "MineHelpEachViewController.h"
@interface JoinViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,WXApiDelegate>
{
    JoinFormModel *formModel;
    NSMutableArray *joinSouceArray;
    NSInteger rowNum;
    BOOL isRelation;
    RelationListModel *markRelationModel;
    ProductListModel *markProductModel;
    WeiXinPayModel *payModel;
    
}
@property (weak, nonatomic) IBOutlet UITableView *joinProjectTableView;
//test
@property(nonatomic,assign)NSInteger cellNum;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic,copy)NSArray *relationSourceArray;
@property(nonatomic,copy)NSArray *taoCanSouceArray;
@end

@implementation JoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.joinProjectTableView.rowHeight=270;
    [self requestDataFromService];
    
    //设置第一个cell的model
    _cellNum=1;
    JoinCellModel *model=[[JoinCellModel alloc]init];
    joinSouceArray=[NSMutableArray arrayWithCapacity:20];
    [joinSouceArray addObject:model];
    
    
}


-(void)requestDataFromService
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token")};
    NSString *urlString=[NSString stringWithFormat:@"AppApi/Ushow/join/%@",self.productID];
    [ZYDataRequest requestWithURL:urlString params:paramsDic block:^(NSObject *result) {
        formModel=[JoinFormModel mj_objectWithKeyValues:result];
        _relationSourceArray=formModel.relationList;
        _taoCanSouceArray=formModel.productList;
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)payJumpToWeiXin:(NSDictionary*)dic
{
   [[WeiXinPayManager sharedManager] payForWeiXin:dic andDelegateController:self andCallBackBlock:^(BOOL result) {
      if (result) {
           [MBProgressHUD show:@"支付成功" view:self.view time:1.5];
          [self performSelector:@selector(jumpToMineHelpEachOtherController) withObject:nil afterDelay:3];
       }else
       {
           [MBProgressHUD show:@"支付失败" view:self.view time:1.5];
       }
   }];
}

#pragma mark ---------buttonAction
-(void)jumpToMineHelpEachOtherController
{
    MineHelpEachViewController *helpOtherController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MineHelpEachViewController"];
    helpOtherController.fromPage=@"join";
    [self showViewController:helpOtherController sender:nil];
}

- (IBAction)forFamilyAddCellAction:(UIButton *)sender {
    _cellNum++;
    
    JoinCellModel *model=[[JoinCellModel alloc]init];
    [joinSouceArray addObject:model];
    [self.joinProjectTableView reloadData];
}
-(void)deleteCellAction:(UIButton*)button
{
    _cellNum--;
    if (_cellNum<=1) {
        _cellNum=1;
    }
    [joinSouceArray removeObjectAtIndex:button.tag/4];
    [self.joinProjectTableView reloadData];
}
- (IBAction)commitButtAction:(UIButton *)sender
{
    for (int i=0; i<joinSouceArray.count; i++) {
        JoinCellModel *model=[joinSouceArray objectAtIndex:i];
        if (model.name==nil||model.relationName==nil||model.codeNum==nil||model.taoCanName==nil) {
            [MBProgressHUD show:@"资料填写不完整" view:self.view time:1.5];
            return;
        }if ([model.name isEqualToString:@""]||[model.relationName isEqualToString:@""]||[model.codeNum isEqualToString:@""]||[model.taoCanName isEqualToString:@""]) {
            [MBProgressHUD show:@"资料填写不完整" view:self.view time:1.5];
            return;
        }
    }
    
    NSMutableString *join_user_nameString=[NSMutableString string];
    NSMutableString *user_relationString=[NSMutableString string];
    NSMutableString *user_id_cardString=[NSMutableString string];
    NSMutableString *product_vip_idString=[NSMutableString string];
    NSString *joinUserName,*userRelationString,*userIDString,*productIDString;
    for (int i=0; i<joinSouceArray.count; i++) {
        JoinCellModel *model=[joinSouceArray objectAtIndex:i];
        [join_user_nameString appendFormat:@"%@,",model.name];
        [user_relationString appendFormat:@"%@,",model.relationName];
        [user_id_cardString appendFormat:@"%@,",model.codeNum];
        [product_vip_idString appendFormat:@"%@,",model.taoCanID];
    }
    joinUserName= [join_user_nameString substringToIndex:join_user_nameString.length-1];
    userRelationString=   [user_relationString substringToIndex:user_relationString.length-1];
    userIDString= [user_id_cardString substringToIndex:user_id_cardString.length-1];
    productIDString= [product_vip_idString substringToIndex:product_vip_idString.length-1];
    
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"id":self.productID,@"join_user_name":joinUserName,@"user_relation":userRelationString,@"user_id_card":userIDString,@"product_vip_id":productIDString};
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/join" params:paramsDic block:^(NSObject *result) {
        payModel=[WeiXinPayModel mj_objectWithKeyValues:result];
        NSDictionary *tempDic=(NSDictionary*)result;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([payModel.code isEqualToString:@"0"]) {
//                [self payJumpToWeiXin:payModel.prepayid];

                [self payJumpToWeiXin:[tempDic objectForKey:@"data"]];
            }else
            {
                [MBProgressHUD show:payModel.msg view:self.view time:1.5];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
- (IBAction)cancelButtAction:(UIButton *)sender {
    self.alertView.hidden=YES;
}
- (IBAction)sureButtAction:(UIButton *)sender {
    self.alertView.hidden=YES;
    JoinCellModel *tempModel=[joinSouceArray objectAtIndex:rowNum];
    if (isRelation) {
        tempModel.relationName=markRelationModel.name;
    }else
    {
        tempModel.taoCanName=markProductModel.name;
        tempModel.taoCanID=markProductModel.productID;
    }
    [self.joinProjectTableView reloadData];
    
}
-(void)selectRelationButtonAction:(UIButton*)butt
{
    self.alertView.hidden=NO;
    markRelationModel=[self.relationSourceArray objectAtIndex:0];
    isRelation=YES;
    rowNum=butt.tag/4;
    JoinCellModel *tempModel=[joinSouceArray objectAtIndex:rowNum];
    [self.pickerView reloadAllComponents];
   JoinProjectCell *cell=[self.joinProjectTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNum inSection:0]];
    if ([cell.nameTextField isFirstResponder]||[cell.certificatTextField isFirstResponder]) {
        [cell.nameTextField resignFirstResponder];
        [cell.certificatTextField resignFirstResponder];
        tempModel.name=cell.nameTextField.text;
        tempModel.codeNum=cell.certificatTextField.text;
    }
}
-(void)selectTaoCanButtonAction:(UIButton*)butt
{
    self.alertView.hidden=NO;
    markProductModel=[self.taoCanSouceArray objectAtIndex:0];
    isRelation=NO;
    rowNum=butt.tag/4;
    JoinCellModel *tempModel=[joinSouceArray objectAtIndex:rowNum];
    [self.pickerView reloadAllComponents];
    JoinProjectCell *cell=[self.joinProjectTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowNum inSection:0]];
    if ([cell.nameTextField isFirstResponder]||[cell.certificatTextField isFirstResponder]) {
        [cell.nameTextField resignFirstResponder];
        [cell.certificatTextField resignFirstResponder];
        tempModel.name=cell.nameTextField.text;
        tempModel.codeNum=cell.certificatTextField.text;
    }
}
- (IBAction)healthClauseAction:(UIButton *)sender {
    HealthRequireViewController *healthRequireController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"HealthRequireViewController"];
    [self showViewController:healthRequireController sender:nil];
}
- (IBAction)memberShipAction:(UIButton *)sender {
    MembershipViewController *memeberShipController=[STORYBOARDOBJECT(@"Main") instantiateViewControllerWithIdentifier:@"MembershipViewController"];
    [self showViewController:memeberShipController sender:nil];
}
- (IBAction)planClauseAction:(UIButton *)sender {
    PlanCauseViewController *planClauseController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"PlanCauseViewController"];
    planClauseController.productID=self.productID;
    [self showViewController:planClauseController sender:nil];
}
#pragma mark--------pickerViewDelegate---------
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (isRelation) {
        return self.relationSourceArray.count;
    }else
    {
        return self.taoCanSouceArray.count;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (isRelation) {
        RelationListModel *model=[self.relationSourceArray objectAtIndex:row];
        return model.name;
    }else
    {
        ProductListModel *model=[self.taoCanSouceArray objectAtIndex:row];
        return model.name;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (isRelation ) {
        markRelationModel=[self.relationSourceArray objectAtIndex:row];
    }else
    {
        markProductModel=[self.taoCanSouceArray objectAtIndex:row];
    }
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


#pragma mark ------tableViewDelegate--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellNum;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JoinProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JoinProjectCell" forIndexPath:indexPath];
    cell.selfIndexPath=indexPath;
    JoinCellModel *cellModel= [joinSouceArray objectAtIndex:indexPath.row];
    cell.cellModel=cellModel;
    cell.productID=self.productID;
    cell.peopleNumLabel.text=[NSString stringWithFormat:@"第%ld位",indexPath.row+1];
    cell.deletButton.tag=indexPath.row*4+1;
    [cell.deletButton addTarget:self action:@selector(deleteCellAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.relationButton.tag=indexPath.row*4+2;
    [cell.relationButton addTarget:self action:@selector(selectRelationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.taoCanButton.tag=indexPath.row*4+3;
    [cell.taoCanButton addTarget:self action:@selector(selectTaoCanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    JoinProjectCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell.nameTextField resignFirstResponder];
    [cell.certificatTextField resignFirstResponder];
    JoinCellModel *cellModel=[joinSouceArray objectAtIndex:indexPath.row];
    cellModel.name=cell.nameTextField.text;
    cellModel.codeNum=cell.certificatTextField.text;
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
