//
//  DrawCurveViewController.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "DrawCurveViewController.h"
#import "HHDrawView.h"

@interface DrawCurveViewController ()<HHDrawViewDataSource,HHDrawViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataSources;

@end

@implementation DrawCurveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSources = [NSMutableArray arrayWithCapacity:0];
    HHDrawView *dw = [[HHDrawView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 500)];
    dw.dataSource = self;
    dw.delegate = self;
    [self.view addSubview:dw];
    dw.backgroundColor = [UIColor lightTextColor];
}

#pragma mark - 代理
- (NSArray<HHCurveModel *> *)dataSourceWithDrawView:(HHDrawView *)drawView
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            HHCurveModel *model = [[HHCurveModel alloc]init];
            model.values = @[@(0.12), @(0.2),@(0.497),@(0.274),@(0.37),@(0.22),@(0.297),@(0.274),@(0.358),@(0.235),@(0.18),@(0.8),@(0.5),@(0.12),@(0.165)];
            model.bottomTitles = @[@(12), @(2),@(497),@(274),@(37),@(22),@(297),@(274),@(358),@(235),@(18),@(8),@(5),@(12),@(165)];
            model.lineColor = [UIColor redColor];
            model.fillColors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:70/255.0 blue:110/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor];
            [array addObject:model];
        } else {
            HHCurveModel *model = [[HHCurveModel alloc]init];
            model.values =  @[@(0.1), @(0.29),@(0.17),@(0.174),@(0.337),@(0.122),@(0.27),@(0.24),@(0.58),@(0.23),@(0.1),@(0.58),@(0.2),@(0.12),@(0.15)];
            model.lineColor = [UIColor blueColor];
            model.fillColors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:70/255.0 blue:110/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor];
            [array addObject:model];
        }
    }
    self.dataSources = [NSMutableArray arrayWithArray:array];
    return self.dataSources;
}

- (void)curveView:(HHDrawView *)curveView didSelectItemAtIndex:(NSInteger)index
{
    HHCurveModel *model0 = self.dataSources[0];
    HHCurveModel *model1 = self.dataSources[1];
    curveView.indicatorView.labOne.text = [NSString stringWithFormat:@"%@月",model0.bottomTitles[index]];
    curveView.indicatorView.labTwo.text = [NSString stringWithFormat:@"小规模纳税人：%@",model0.values[index]];
    curveView.indicatorView.labThree.text = [NSString stringWithFormat:@"一般纳税人：%@",model1.values[index]];
    NSLog(@"index: %@ - %@",model0.values[index],model1.values[index]);
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
