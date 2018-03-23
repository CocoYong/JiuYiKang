//
//  ApplyMoneyViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/8/9.
//  Copyright © 2017年 MrZhang. All rights reserved.
//申请互助

#import "ApplyMoneyViewController.h"
#import "UILabel+Universal.h"
@interface ApplyMoneyViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel;

@end

@implementation ApplyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatBackNavigationItem];
    self.headerLabel.attributedText=[UILabel createAttributStringWithOriginalString:@"如已度过等待期，且需申请互助金，请拨打400-6010-550" specialTextArray:@[@"400-6010-550"] andAttributs:@{NSForegroundColorAttributeName:[UIColor blueColor]}];
    self.backView.frame=CGRectMake(0, 0, SCREENWIDTH, CGRectGetMaxY(self.finalLabel.frame)+100);
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
