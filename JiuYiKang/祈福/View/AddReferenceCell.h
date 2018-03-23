//
//  AddReferenceCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/11/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddReferenceModel.h"
@interface AddReferenceCell : UITableViewCell<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumField;
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
@property (weak, nonatomic) IBOutlet UIButton *showRelationButt;
@property (weak, nonatomic) IBOutlet UIButton *personnalPhotoButt;
@property (weak, nonatomic) IBOutlet UIButton *cidPhotoButt;
@property (weak, nonatomic) IBOutlet UITextView *providenceWordTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButt;
@property(nonatomic,strong)AddReferenceModel *cellModel;
-(void)configeCellDataWith:(AddReferenceModel*)dataModel;
@end
