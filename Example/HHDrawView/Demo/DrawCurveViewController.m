//
//  DrawCurveViewController.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "DrawCurveViewController.h"
#import "HHDrawView.h"

@interface DrawCurveViewController ()<HHDrawViewDataSource>

@end

@implementation DrawCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];

    HHDrawView *dw = [[HHDrawView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 500)];
    dw.dataSource = self;
    [self.view addSubview:dw];
    dw.backgroundColor = [UIColor lightTextColor];
}

- (NSInteger)numberOfLineWithDrawView:(HHDrawView *)drawView
{
    return 2;
}

- (NSArray *)dataSourceWithDrawView:(HHDrawView *)drawView index:(NSInteger)index
{
    if (index == 0) {
        return @[@(0.12), @(0.2),@(0.497),@(0.274),@(0.37),@(0.22),@(0.297),@(0.274),@(0.358),@(0.235),@(0.18),@(0.8),@(0.5),@(0.12),@(0.165)];
    } else {
        return @[@(0.1), @(0.29),@(0.17),@(0.174),@(0.337),@(0.122),@(0.27),@(0.24),@(0.58),@(0.23),@(0.1),@(0.58),@(0.2),@(0.12),@(0.15)];
    }
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
