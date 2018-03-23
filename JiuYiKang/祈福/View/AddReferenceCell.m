//
//  AddReferenceCell.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "AddReferenceCell.h"

@implementation AddReferenceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.providenceWordTextView.layer.cornerRadius=5;
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyBoard)];
    [self addGestureRecognizer:gesture];
}
-(void)configeCellDataWith:(AddReferenceModel *)dataModel
{
    self.nameField.text=dataModel.user_name;
    self.telephoneNumField.text=dataModel.user_mobile;
    self.relationLabel.text=dataModel.user_relative;
    if (dataModel.faceImage==nil) {
    [self.personnalPhotoButt setImage:[UIImage imageNamed:@"icon_xj"] forState:UIControlStateNormal];
    }else
    {
        [self.personnalPhotoButt setImage:dataModel.faceImage forState:UIControlStateNormal];
    }
    
    if (dataModel.showCIDImage==nil)
    {
    [self.cidPhotoButt setImage:[UIImage imageNamed:@"icon_xj"] forState:UIControlStateNormal];
    }else
    {
        [self.cidPhotoButt setImage:dataModel.showCIDImage forState:UIControlStateNormal];
    }
    self.providenceWordTextView.text=dataModel.desc;
}
-(void)resignKeyBoard
{
    [self.nameField resignFirstResponder];
    [self.telephoneNumField resignFirstResponder];
    [self.providenceWordTextView resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==self.nameField) {
        self.cellModel.user_name=textField.text;
    }else if (textField==self.telephoneNumField)
    {
        self.cellModel.user_mobile=textField.text;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.cellModel.desc=textView.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
