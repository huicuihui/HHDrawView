//
//  HHViewController.m
//  HHDrawView
//
//  Created by 805988356@qq.com on 08/04/2020.
//  Copyright (c) 2020 805988356@qq.com. All rights reserved.
//

#import "HHViewController.h"
#import "DrawArcViewController.h"
#import "DrawTriangleViewController.h"
#import "DrawCurveViewController.h"

@interface HHViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *objects;

@end

@implementation HHViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableView];
}
#pragma mark lazy load
- (NSMutableArray *)objects {
    if (!_objects) {
        self.objects = [NSMutableArray arrayWithObjects:@"画圆环",@"三角",@"画曲线", nil];
    }
    return _objects;
}
- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}
#pragma mark tableView delegate & dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.objects[indexPath.row];
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            {
                [self.navigationController pushViewController:[DrawArcViewController new] animated:YES];
            }
            break;
            case 1:
        {
            [self.navigationController pushViewController:[DrawTriangleViewController new] animated:YES];

        }
            break;
               case 2:
            {
                [self.navigationController pushViewController:[DrawCurveViewController new] animated:YES];

            }
                break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
