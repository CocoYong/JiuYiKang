//
//  BeginBlessViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "BeginBlessViewController.h"
#import "BlessOneCell.h"
#import "AddReferenceViewController.h"
#import "UILabel+Universal.h"
#import "ImageModel.h"
#import "PlanCauseViewController.h"
#import "BeginBlessModel.h"
#import "BeginUpdateModel.h"
#import "TakePhotoOrLibraryView.h"
@interface BeginBlessViewController ()<UITableViewDelegate,UITableViewDataSource,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableArray *falseDataArray;
    NSArray *titleArray;
    NSMutableArray *payeeArray;
}
@property (weak, nonatomic) IBOutlet UITableView *beginBlessTable;

@property (weak, nonatomic) IBOutlet UIView *nameTextBgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;


@property (weak, nonatomic) IBOutlet UIView *titleTextFieldBackView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property(nonatomic,strong)BlessOneCell *blessOneCell;
@property (weak, nonatomic) IBOutlet UITextView *introTextView;
@property (weak, nonatomic) IBOutlet UIButton *protocolButt;

@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (weak, nonatomic) IBOutlet UIView *daysButtBgView;
//设置灰色条距上边自动审核的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *daysButtHeightConstraint;
@property(nonatomic,strong)UIButton *cacheButt;



@property (weak, nonatomic) IBOutlet UITextField *openAcountBankField;//开户行
@property (weak, nonatomic) IBOutlet UITextField *acountNumField;//开户行账号
@property (weak, nonatomic) IBOutlet UITextField *acountNameField; //开户行姓名
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField; //手机号


@property (weak, nonatomic) IBOutlet UIButton *pickerPayeeButt;
@property (weak, nonatomic) IBOutlet UILabel *payeeRelationLabel;
@property (weak, nonatomic) IBOutlet UIButton *agreeProtocalButt;

//模型数组
@property(nonatomic,strong)BeginBlessModel *beginBlessModel;

@property(nonatomic,strong)UIButton *markButt;

@property(nonatomic,strong)NSMutableArray *imageModelArray;
//下一步
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

//上传数据数组
@property(nonatomic,strong)BeginUpdateModel *uploadModel;

@end

@implementation BeginBlessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatBackNavigationItem];
    [self configeUI];
    [self requestAddBless];
    _uploadModel=[[BeginUpdateModel alloc]init];
//    payeeArray=@[@"发起人",@"受助人"];
    payeeArray=[NSMutableArray arrayWithCapacity:10];

    self.beginBlessTable.tableFooterView.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(self.nextButton.frame)+60);
    UITapGestureRecognizer *tapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.headerView addGestureRecognizer:tapGestureController];
    
    UITapGestureRecognizer *headerTapGestureController=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.footerView addGestureRecognizer:headerTapGestureController];
    
    _imageModelArray=[NSMutableArray arrayWithCapacity:10];
    
}
-(void)hideKeyBoard
{
    [self.acountNumField resignFirstResponder];
    [self.acountNameField resignFirstResponder];
    [self.openAcountBankField resignFirstResponder];
    [self.introTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
    [self.phoneNumField resignFirstResponder];
}
-(void)configeUI
{
    self.titleTextFieldBackView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.titleTextFieldBackView.layer.cornerRadius=5;
      self.titleTextFieldBackView.layer.borderWidth=1;
    self.nameTextBgView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.nameTextBgView.layer.cornerRadius=5;
    self.nameTextBgView.layer.borderWidth=1;
    self.introTextView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.introTextView.layer.borderWidth=1;
    self.introTextView.layer.cornerRadius=5;
    self.pickerPayeeButt.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#E6E6E6"].CGColor;
    self.pickerPayeeButt.layer.borderWidth=1;
    self.pickerPayeeButt.layer.cornerRadius=5.0;
}

-(BlessOneCell *)blessOneCell
{
    if (!_blessOneCell) {
        _blessOneCell=[[BlessOneCell alloc]initWithFrame:CGRectZero];
    }
    return _blessOneCell;
}

#pragma mark - ---------->>>>>>>>>>tableview代理方法<<<<<<<<<<----------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        self.blessOneCell.dataArray=self.beginBlessModel.bless_type_image_list;
        self.blessOneCell.parentController=self;
        return self.blessOneCell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return self.blessOneCell.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideKeyBoard];
}
#pragma mark - ---------->>>>>>>>>>textFieldDelegate<<<<<<<<<<----------
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.titleTextField) {
        self.uploadModel.name=textField.text;
    }else if (textField==self.nameTextField)
    {
        self.uploadModel.bless_username=textField.text;
    }
    else if (textField==self.openAcountBankField) {
       self.uploadModel.bank_name=textField.text;
    }else if (textField==self.acountNumField)
    {
        self.uploadModel.bank_card_number=textField.text;
    }else if (textField==self.acountNameField)
    {
        self.uploadModel.bank_card_user_name=textField.text;
    }else
    {
        self.uploadModel.bank_card_user_mobile=textField.text;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.uploadModel.desc=textView.text;
}
#pragma mark - ---------->>>>>>>>>>buttAction<<<<<<<<<<----------

-(IBAction)showProtocalController:(UIButton*)butt
{
    PlanCauseViewController *planCauseController=[STORYBOARDOBJECT(@"Universal") instantiateViewControllerWithIdentifier:@"PlanCauseViewController"];
    planCauseController.productID=self.typeID;
    planCauseController.clauseType=@"bless";
    [self showViewController:planCauseController sender:nil];
}
-(void)daysButtAction:(UIButton*)butt
{
    butt.selected=YES;
    self.uploadModel.bless_days=[butt.titleLabel.text stringByReplacingOccurrencesOfString:@"天" withString:@""];;
    self.cacheButt.selected=NO;
    self.cacheButt=butt;
}
-(IBAction)nextButtAction:(UIButton*)butt
{
    if (![self.uploadModel chechInfomationIsOK])
    {
        [MBProgressHUD show:[self.uploadModel checkPropertyIsEmpty] view:self.view time:3];
        return;
    }
    if (!self.agreeProtocalButt.selected) {
        [MBProgressHUD show:@"您还未同意协议" view:self.view time:3];
        return;
    }
    NSMutableDictionary *paramsDic=[self.uploadModel mj_keyValuesWithKeys:@[@"token",@"bless_type_id",@"bless_username",@"name",@"desc",@"bless_days",@"bank_name",@"bank_card_number",@"bank_card_user_name",@"bank_card_user_mobile",@"bank_card_user_relative"]];
    for (int i=0; i<self.uploadModel.photoModelArray.count; i++) {
        BlessTypeImageModel *imageModel=[self.uploadModel.photoModelArray objectAtIndex:i];
        if (imageModel.imageUri!=nil)
        {
            [paramsDic setObject:imageModel.imageUri forKey:[NSString stringWithFormat:@"bless_type_image_%@",imageModel.imageID]];
        }
    }
    [ZYDataRequest requestWithURL:@"AppApi/Ucenter/bless_add" params:paramsDic block:^(NSObject *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *tempDic=(NSDictionary*)result;
            if ([[tempDic objectForKey:@"code"] integerValue]==0) {
                AddReferenceViewController *addReferenceController=[STORYBOARDOBJECT(@"Bless") instantiateViewControllerWithIdentifier:@"AddReferenceViewController"];
                addReferenceController.beginModel=self.beginBlessModel;
                addReferenceController.typeID=[[tempDic objectForKey:@"data"] objectForKey:@"id"];
                [self showViewController:addReferenceController sender:nil];
            }else
            {
                [MBProgressHUD show:[tempDic objectForKey:@"msg"] view:self.view time:1.5];
            }
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
- (IBAction)protocolAgreeButtAction:(UIButton *)sender
{
    sender.selected=!sender.selected;
}
- (IBAction)dialPhoneNumAction:(UIButton *)sender
{
    [[UtilitiesHelper shareHelper]dialTelephoneNum:@"400-601-0550"];
}
- (IBAction)popPickerViewActonn:(UIButton *)sender
{
    [self hideKeyBoard];
    TakePhotoOrLibraryView *pickerView=[[TakePhotoOrLibraryView alloc]initWithFrame:CGRectZero andDataSource:payeeArray andCallBackBlock:^(NSString *passData, NSError *error) {
        self.payeeRelationLabel.text=passData;
        self.payeeRelationLabel.textColor=[UIColor blackColor];
        self.uploadModel.bank_card_user_relative=passData;
    }];
    [pickerView showView];
}
#pragma mark  ----requestService
-(void)requestAddBless
{
    NSDictionary *paramsDic=@{@"token":MYGETNSUSERDEFAULTSDEFINE(@"token"),@"bless_type_id":self.typeID};
    [ZYDataRequest requestWithURL:@"AppApi/Bless/add" params:paramsDic block:^(NSObject *result) {
        self.beginBlessModel=[BeginBlessModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.introLabel.attributedText=[UILabel  getAttributStringWithOrignalString:self.beginBlessModel.bless_type_chengnuo andLineVerticalSpacing:5 andFirstIndent:20];
            [self.protocolButt setTitle:[NSString stringWithFormat:@"《久益康%@条款》",  self.beginBlessModel.bless_type.name] forState:UIControlStateNormal];
            [self createDaysButtWith:self.beginBlessModel];
            [self.uploadModel.photoModelArray addObjectsFromArray:self.beginBlessModel.bless_type_image_list];
                self.uploadModel.token=MYGETNSUSERDEFAULTSDEFINE(@"token");
                self.uploadModel.bless_type_id=self.typeID;
            for ( BlessTypeRelationModel *model in self.beginBlessModel.bless_user_relation_list) {
                [payeeArray addObject:model.name];
            }
            [self.beginBlessTable reloadData];
        });
    } errorBlock:^(NSError *error) {
        [MBProgressHUD showError:error.description toView:self.view];
    } noNetWorking:^(NSString *noNetWorking) {
        [MBProgressHUD show:@"没有网络连接。。。" view:self.view time:1.5];
    }];
}
-(void)createDaysButtWith:(BeginBlessModel*)blessModel
{
    CGFloat buttWidth=(SCREENWIDTH-50)/4;
    NSInteger rowNum=floor((blessModel.bless_days.count-1)/4)+1;
    if (blessModel.bless_days.count!=0) {
        for (int i=0; i<rowNum; i++) {
            NSInteger tempMark;
            if (i==rowNum-1) {
                tempMark=blessModel.bless_days.count-(rowNum-1)*4;
            }else
            {
                tempMark=4;
            }
            for (int j=0; j<tempMark; j++) {
                UIButton *butt=[UIButton buttonWithType:UIButtonTypeCustom];
                butt.frame=CGRectMake(((buttWidth+10)*j)+10, (40+10)*i, buttWidth, 40);
                [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                [butt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [butt setBackgroundImage:[UIImage imageNamed:@"btn_1"] forState:UIControlStateSelected];
                [butt setBackgroundImage:[UtilitiesHelper imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                butt.layer.cornerRadius=5;
                butt.layer.borderColor=[UIColor redColor].CGColor;
                butt.layer.borderWidth=1;
                [butt setTitle:[NSString stringWithFormat:@"%@天",[blessModel.bless_days objectAtIndex:i*4+j]] forState:UIControlStateNormal];
                butt.tag=(i*4+j)+400;
                [butt addTarget:self action:@selector(daysButtAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.daysButtBgView addSubview:butt];
            }
        }
    }
    self.daysButtBgView.frame=CGRectMake(0, 57, SCREENWIDTH, rowNum*50);
    self.daysButtHeightConstraint.constant=CGRectGetHeight(self.daysButtBgView.frame)+10;
    [self.footerView layoutIfNeeded];
}


#pragma mark - ---------->>>>>>>>>>选取照片上传照片<<<<<<<<<<----------
- (void)iamgeButtClicked:(UIButton *)sender
{
    self.markButt=sender;
    [self.introTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
    TakePhotoOrLibraryView *photoView=[[TakePhotoOrLibraryView alloc]initWithFrame:CGRectZero andController:self andCallBackBlock:^(UIImage *editImage,NSString *imageURI,NSError *error) {
        [self.markButt setImage:editImage forState:UIControlStateNormal];
        BlessTypeImageModel *imageObject = [self.uploadModel.photoModelArray objectAtIndex:self.markButt.tag-400];
        imageObject.imageUri=imageURI;
        imageObject.cutImage=editImage;
        [photoView removeFromSuperview];
    }];
    [photoView showView];
   
}
@end
