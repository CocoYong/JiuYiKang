//
//  BabyProjectOneCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/11.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyProjectModel.h"
@interface BabyProjectOneCell : UITableViewCell<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandButt;
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,assign) CGRect webViewFrame;
@property (weak, nonatomic) IBOutlet UIImageView *hengXuXianImageView;

@property(nonatomic,strong) RuleListModel*helpModel;
@end
