//
//  BabyProjectFiveCell.h
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/21.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyProjectModel.h"
@interface BabyProjectFiveCell : UITableViewCell<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expandButt;
@property (weak, nonatomic) IBOutlet UILabel *detaillabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,assign) CGRect webViewFrame;

@property (weak, nonatomic) IBOutlet UIImageView *hengXuXianImageView;
@property(nonatomic,strong) FastQList *commonModel;
@end
