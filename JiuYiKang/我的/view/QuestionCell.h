//
//  QuestionCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonQuestionModel.h"
@interface QuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandButt;
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,assign) CGRect webViewFrame;
@property(nonatomic,strong)NSIndexPath *indexpath;
@property(nonatomic,strong)HuZhuIntroModel *introModel;
@property(nonatomic,strong)HuZhuClauseModel *clauseModel;
@end
