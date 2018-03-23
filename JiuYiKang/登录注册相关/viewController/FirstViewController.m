//
//  FirstViewController.m
//  JiuYiKang
//
//  Created by MrZhang on 2017/9/22.
//  Copyright © 2017年 MrZhang. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UIButton *JoinButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.backScrollView.contentSize=CGSizeMake(SCREENWIDTH*2, SCREENHEIGHT);
    self.backScrollView.showsVerticalScrollIndicator=NO;
    self.backScrollView.showsHorizontalScrollIndicator=NO;
    self.backScrollView.bounces = NO;
    self.backScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backScrollView.pagingEnabled=YES;
    self.backScrollView.delegate=self;
    [self.JoinButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}
-(void)dismissSelf
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
