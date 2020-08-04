//
//  DrawTriangleViewController.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2019/12/5.
//  Copyright © 2019 huihui. All rights reserved.
//

#import "DrawTriangleViewController.h"
#import "DrawTriangleView.h"

@interface DrawTriangleViewController ()

@end

@implementation DrawTriangleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    DrawTriangleView *v = [[DrawTriangleView alloc]initWithFrame:CGRectMake(10, 150, 200, 300)];
    [self.view addSubview:v];

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
