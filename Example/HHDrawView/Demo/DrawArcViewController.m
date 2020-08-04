//
//  DrawArcViewController.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2019/12/5.
//  Copyright © 2019 huihui. All rights reserved.
//

#import "DrawArcViewController.h"
#import "DrawArcView.h"

@interface DrawArcViewController ()
@property (nonatomic, strong)DrawArcView *drawArcView;

@end

@implementation DrawArcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    DrawArcView *drawArcView = [[DrawArcView alloc]initWithFrame:CGRectMake(90, 100, 200, 200)];
    drawArcView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:drawArcView];
    [drawArcView startAnimatingWithFromValue:0.0f toValue:0.5f];
    self.drawArcView = drawArcView;
    UIButton *testBuuton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:testBuuton];
    testBuuton.frame = CGRectMake(80, 400, 90, 50);
    testBuuton.backgroundColor = [UIColor purpleColor];
    [testBuuton addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *testBuuton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:testBuuton1];
    testBuuton1.frame = CGRectMake(200, 400, 90, 50);
    testBuuton1.backgroundColor = [UIColor purpleColor];
    [testBuuton1 addTarget:self action:@selector(testAction1) forControlEvents:UIControlEventTouchUpInside];

}

- (void)testAction {
    [self.drawArcView startAnimatingWithFromValue:0.5f toValue:0.8f];
}
- (void)testAction1 {
    self.drawArcView.shapeLayerStrokeColor = [UIColor blueColor];
    [self.drawArcView startAnimatingWithFromValue:0.8f toValue:0.3f];
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
