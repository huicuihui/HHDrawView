//
//  HHDrawView.m
//  HHDrawDemo
//
//  Created by 崔辉辉 on 2020/7/28.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHDrawView.h"
#import "HHDrawUtil.h"
#import "HHLineChartValue.h"
#import "HHChartCell.h"
#import "HHIndicatorView.h"
@interface HHDrawView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)HHLineChartValue *chartValue;
@property (nonatomic, strong)HHChartConfig *config;
@property (nonatomic, strong)HHIndicatorView *indicatorView;
@property (nonatomic, strong)UIView *indicatorLineView;
@property (nonatomic, strong)NSMutableArray *points;
@end
@implementation HHDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpItems];
    }
    return self;
}

- (void)setUpItems
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[HHChartCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:self.collectionView];
    
    self.config = [[HHChartConfig alloc]init];
    
    self.indicatorView = [[HHIndicatorView alloc]initWithFrame:CGRectZero];
    self.indicatorLineView = [UIView new];
    self.indicatorLineView.backgroundColor = [UIColor blueColor];
    [self.collectionView addSubview:self.indicatorView];
    [self.collectionView addSubview:self.indicatorLineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(20,
                                           0,
                                           self.frame.size.width - 30,
                                           self.frame.size.height);

    for (int i = 0; i < [self.dataSource numberOfLineWithDrawView:self]; i++) {
        NSArray *data = [self.dataSource dataSourceWithDrawView:self index:i];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
        for (NSNumber *n in data) {
            ChartModel *m = [ChartModel new];
            m.value = [n floatValue];
            [tempArray addObject:m];
        }
        
        if (i == 0) {
            self.config.itemWidth = (self.frame.size.width - 30) / tempArray.count;
            self.chartValue = [[HHLineChartValue alloc]initWithDataSource:tempArray separate:0];
        }
        
        
        UIColor *lineColor = [UIColor redColor];
        if (i == 1) {
            lineColor = [UIColor blueColor];
        }
        [self drawCurveLineWithLineColor:lineColor colors:@[(__bridge id)[UIColor colorWithRed:250/255.0 green:70/255.0 blue:110/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor] dataSource:tempArray];
        
    }
    
    //添加指示视图要在添加曲线填充色后面
    [self.collectionView bringSubviewToFront:self.indicatorView];
    [self.collectionView bringSubviewToFront:self.indicatorLineView];

}

- (void)drawCurveLineWithLineColor:(UIColor *)lineColor
                            colors:(NSArray *)colors
                        dataSource:(NSArray <ChartModel *> *)dataSource
{
    CAShapeLayer * lineLayer = [HHDrawUtil shapeLayerWithLineWidth:1.0 strokeColor:lineColor];
    [self.collectionView.layer addSublayer:lineLayer];

    CAGradientLayer *gradientLayer = [HHDrawUtil gradientLayerWithColors:colors];
    [self.collectionView.layer addSublayer:gradientLayer];

    
    CGFloat width = self.config.itemWidth;
    CGFloat ratio = self.chartValue.min - self.chartValue.max;
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [dataSource enumerateObjectsUsingBlock:^(ChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat y = HHInterpolation(50, 400, (obj.value - self.chartValue.max) / ratio);
        if (idx == 0) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(10, y)]];
        }
        
        CGPoint center = CGPointMake(width * 0.5 + idx * width, y);
        [points addObject:[NSValue valueWithCGPoint:center]];
//        if (idx == self.dataSource.count - 1) {
//            [points addObject:[NSValue valueWithCGPoint:CGPointMake(300, y)]];
//        }
    }];
    self.points = [NSMutableArray arrayWithArray:points];
    UIBezierPath *bezierPath = [HHDrawUtil bezierPathWithPoints:points curve:YES];
    lineLayer.path = [bezierPath.copy CGPath];
    UIBezierPath *fillColorBezierPath = [HHDrawUtil fillColorBezierPathWithPoints:points curve:YES size:self.collectionView.frame.size];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = fillColorBezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    gradientLayer.mask = shapeLayer;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataSource dataSourceWithDrawView:self index:1] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.config = self.config;
//    cell.titleLabel.text = [NSString stringWithFormat:@"%.3f",((ChartModel *)self.dataSource[indexPath.row]).value];
    cell.touchesAction = ^(UITouch * _Nonnull touch) {
        CGPoint indicatorPoint = [touch previousLocationInView:self.collectionView];
        self.indicatorView.labOne.text = @"7月";
        self.indicatorView.labTwo.text = @"小规模纳税人：899";
        self.indicatorView.labThree.text = @"一般纳税人：2000";
        
        NSInteger index = (int)(indicatorPoint.x / self.config.itemWidth) + 2;
        CGPoint prePoint = [[self.points objectAtIndex:((index-1) >= self.points.count) ? (self.points.count - 1) : (index - 1)] CGPointValue];
        CGPoint nowPoint = [[self.points objectAtIndex:(index >= self.points.count) ? (self.points.count - 1) : index] CGPointValue];
        CGPoint pq = [HHLineChartValue calculateBezierPointForCubicWithT:(1.0 / [self.dataSource dataSourceWithDrawView:self index:0].count) point0:prePoint point1:CGPointMake((nowPoint.x + prePoint.x) / 2, prePoint.y) point2:CGPointMake((nowPoint.x + prePoint.x) / 2, nowPoint.y) point3:nowPoint];
        
        CGFloat indicatorX = pq.x/*indicatorPoint.x*/, indicatorY = pq.y;
        CGFloat indicatorWidth = 145, indicatorHeight = 76;
        if (indicatorX + indicatorWidth > self.collectionView.frame.size.width) {
            indicatorX -= indicatorWidth;
        }
        if (indicatorY + indicatorHeight > self.collectionView.frame.size.height) {
            indicatorY -= indicatorHeight;
        }
        [UIView animateWithDuration:self.config.indicatorAnimateDuration animations:^{
            self.indicatorLineView.frame = CGRectMake((index - 2) * self.config.itemWidth + self.config.itemWidth * 0.5 - 0.5, 0, 1, self.collectionView.frame.size.height - self.config.bottomSpace-18);
            self.indicatorView.frame = CGRectMake(indicatorX, indicatorY, indicatorWidth, indicatorHeight);
        }];
//        NSLog(@"");
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.config.itemWidth, collectionView.bounds.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
