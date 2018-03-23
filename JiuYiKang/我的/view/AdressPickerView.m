//
//  AdressPickerView.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/5.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AdressPickerView.h"
#import "AddressModel.h"

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
@interface AdressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *myPickerView;
    NSMutableArray *shengArray;
    NSMutableArray *shiArray;
    NSMutableArray *xianArray;
    NSMutableDictionary *chooseDic;
}
@property(nonatomic,copy)PickerViewBlock callBackBlock;
@end
@implementation AdressPickerView
//+(instancetype)sharePickerView
//{
//    static  AdressPickerView *pickerView=nil;
//    static dispatch_once_t  token;
//    dispatch_once(&token, ^{
//        pickerView=[[self alloc]init];
//    });
//    return pickerView;
//}
-(instancetype)initWithFrame:(CGRect)frame andPickerBlock:(PickerViewBlock)pickerBlock
{
    self=[self initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.callBackBlock = pickerBlock;
    return self;
}
//+(instancetype)pickerWithBlock:(PickerViewBlock)pickerBlock
//{
//    AdressPickerView *picker=[self sharePickerView];
//    picker.callBackBlock=pickerBlock;
//    return picker;
//}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.frame=CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.backgroundColor=[UIColor clearColor];
    UIView *bigGrayView=[[UIView alloc]initWithFrame:self.frame];
    bigGrayView.backgroundColor=[UIColor darkGrayColor];
    bigGrayView.alpha=0.5;
    [self addSubview:bigGrayView];
    
    UIView *pickerBack=[[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-300, SCREENWIDTH, 300)];
    pickerBack.backgroundColor=[UIColor redColor];
    pickerBack.backgroundColor=[UtilitiesHelper colorWithHexString:@"#F5F5F5"];
    [self addSubview:pickerBack];
    

    
    
    // 选择框
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 216)];
    // 显示选中框
    myPickerView.showsSelectionIndicator=YES;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.backgroundColor=[UtilitiesHelper colorWithHexString:@"#EDEDED"];
    [pickerBack addSubview:myPickerView];
    
    
    
    UIView *clearView=[[UIView alloc]initWithFrame:CGRectMake(-10, CGRectGetMidY(myPickerView.bounds)-20, SCREENWIDTH+20, 40)];
    clearView.layer.borderColor=[UtilitiesHelper colorWithHexString:@"#CCCCCC"].CGColor;
    clearView.layer.borderWidth=0.5;
    clearView.backgroundColor=[UIColor clearColor];
    [myPickerView addSubview:clearView];
    
    UIButton *cancelButt=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButt.frame=CGRectMake(10, 6, 60, 30);
    [cancelButt setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButt setTitleColor:[UtilitiesHelper colorWithHexString:@"#006FFC"] forState:UIControlStateNormal];
    [cancelButt addTarget:self action:@selector(cancelButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerBack addSubview:cancelButt];
    
    UIButton *sureButt=[UIButton buttonWithType:UIButtonTypeCustom];
    sureButt.frame=CGRectMake(SCREENWIDTH-70, 6, 60, 30);
    [sureButt setTitle:@"确定" forState:UIControlStateNormal];
    [sureButt setTitleColor:[UtilitiesHelper colorWithHexString:@"#006FFC"] forState:UIControlStateNormal];
    [sureButt addTarget:self action:@selector(sureButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [pickerBack addSubview:sureButt];
    
     [self dealDataSource];
    
    return self;
}
-(void)show
{
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}
-(void)cancelButtAction:(UIButton*)butt
{
    [self removeFromSuperview];
}
-(void)sureButtAction:(UIButton*)butt
{
    self.callBackBlock(chooseDic);
    [self removeFromSuperview];
}
-(void)dealDataSource
{
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"]];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *dataArray=dataDic[@"result"][0][@"son"];
    //    NSLog(@"%@",dataArray);
    
    shengArray=[NSMutableArray array];
    shiArray=[NSMutableArray array];
    xianArray=[NSMutableArray array];
    
    chooseDic=[NSMutableDictionary dictionary];
    
    //省数组
    shengArray=[AddressModel mj_objectArrayWithKeyValuesArray:dataArray];
    //市数组，默认省数组第一个
    AddressModel *model=shengArray[0];
    shiArray=[AddressModel mj_objectArrayWithKeyValuesArray:model.son];
    
    //县数组，默认市数组第一个
    AddressModel *model1=shiArray[0];
    xianArray=[AddressModel mj_objectArrayWithKeyValuesArray:model1.son];
    AddressModel *model2=xianArray[0];
    
    [chooseDic setValue:model.area_district forKey:@"sheng"];
    [chooseDic setValue:model.area_district forKey:@"shi"];
    [chooseDic setValue:model2.area_district forKey:@"xian"];
}

#pragma mark
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return shengArray.count;
    }
    if (component==1) {
        return  shiArray.count;
    }
    if (component==2) {
        return xianArray.count;
    }
    
    return 0;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"选中%ld列---%ld行",(long)component,(long)row);
    if (component==0) {
        AddressModel *model=shengArray[row];
        shiArray=[AddressModel mj_objectArrayWithKeyValuesArray:model.son];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        //默认第一个
        AddressModel *model1=shiArray[0];
        xianArray=[AddressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        AddressModel *model2=xianArray[0];
        [chooseDic setValue:model.area_district forKey:@"sheng"];
        [chooseDic setValue:model1.area_district forKey:@"shi"];
        [chooseDic setValue:model2.area_district forKey:@"xian"];
    }
    if (component==1) {
        AddressModel *model1=shiArray[row];
        xianArray=[AddressModel mj_objectArrayWithKeyValuesArray:model1.son];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:NO];
        AddressModel *model2=xianArray[0];
        [chooseDic setValue:model1.area_district forKey:@"shi"];
        [chooseDic setValue:model2.area_district forKey:@"xian"];
    }
    if (component==2) {
        AddressModel *model2=xianArray[row];
        [chooseDic setValue:model2.area_district forKey:@"xian"];
    }
    NSLog(@"%@",chooseDic);
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        AddressModel *model=shengArray[row];
        return model.area_district;
    }
    if (component==1) {
        AddressModel *model=shiArray[row];
        return model.area_district;
    }
    if (component==2) {
        AddressModel *model=xianArray[row];
        return model.area_district;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end
