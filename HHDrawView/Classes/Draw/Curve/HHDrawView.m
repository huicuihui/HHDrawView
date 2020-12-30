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
@interface HHDrawView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)HHChartConfig *config;
/// 指示线
@property (nonatomic, strong)UIView *indicatorLineView;
@property (nonatomic, strong)NSMutableArray *points;

/// 数据源：数据和颜色
@property (nonatomic, strong)NSArray <HHCurveModel *> *dataSources;

/// 保存之前画的线和渐变填充背景色  reload的时候需要移除
@property (nonatomic, strong)NSMutableArray *subLayers;

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
    self.dataSources = [NSMutableArray arrayWithCapacity:0];
    self.subLayers = [NSMutableArray arrayWithCapacity:0];
    
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
    [self reloadData];
}

- (void)reloadData
{
    //移除之前的线和渐变填充背景色
    [self.subLayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.subLayers removeAllObjects];
    self.indicatorView.labOne.text = @"";
    self.indicatorView.labTwo.text = @"";
    self.indicatorView.labThree.text = @"";
    self.indicatorView.frame = CGRectZero;
    self.indicatorLineView.frame = CGRectZero;
    
    HHLineChartValue *chartValue;
    self.dataSources = [NSMutableArray arrayWithArray:[self.dataSource dataSourceWithDrawView:self]];
    for (int i = 0; i < [self.dataSources count]; i++) {
        HHCurveModel *model = [self.dataSources objectAtIndex:i];
        NSArray *data = model.values;
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
        for (NSNumber *n in data) {
            ChartModel *m = [ChartModel new];
            m.value = [n floatValue];
            [tempArray addObject:m];
        }
        
        if (i == 0) {
            self.config.itemWidth = self.collectionView.frame.size.width / tempArray.count;
            chartValue = [[HHLineChartValue alloc]initWithDataSource:tempArray separate:0];
        }
        
        [self drawCurveLineWithLineColor:model.lineColor colors:model.fillColors dataSource:tempArray chartValue:chartValue];
    }
    [self.collectionView reloadData];
    //添加指示视图要在添加曲线填充色后面
    [self.collectionView bringSubviewToFront:self.indicatorView];
    [self.collectionView bringSubviewToFront:self.indicatorLineView];
}

- (void)drawCurveLineWithLineColor:(UIColor *)lineColor
                            colors:(NSArray *)colors
                        dataSource:(NSArray <ChartModel *> *)dataSource
                        chartValue:(HHLineChartValue *)chartValue
{
    CGFloat width = self.config.itemWidth;
    CGFloat ratio = chartValue.min - chartValue.max;
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:0];
    [dataSource enumerateObjectsUsingBlock:^(ChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat y = HHInterpolation(self.config.lineTopSpace, self.collectionView.frame.size.height - self.config.lineTopSpace - self.config.lineBottomSpace, (obj.value - chartValue.max) / ratio);
        //第一个节点的x坐标self.config.itemWidth * 0.5
        if (idx == 0) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(self.config.itemWidth * 0.5, y)]];
        }
        
        CGPoint center = CGPointMake(width * 0.5 + idx * width, y);
        [points addObject:[NSValue valueWithCGPoint:center]];
//        if (idx == self.dataSource.count - 1) {
//            [points addObject:[NSValue valueWithCGPoint:CGPointMake(300, y)]];
//        }
    }];
    self.points = [NSMutableArray arrayWithArray:points];

    //画线
    CAShapeLayer * lineLayer = [HHDrawUtil shapeLayerWithLineWidth:1.0 strokeColor:lineColor];
    [self.collectionView.layer addSublayer:lineLayer];
    UIBezierPath *bezierPath = [HHDrawUtil bezierPathWithPoints:points curve:YES];
    lineLayer.path = [bezierPath.copy CGPath];

    //渐变填充色
    CAGradientLayer *gradientLayer = [HHDrawUtil gradientLayerWithColors:colors];
    [self.collectionView.layer addSublayer:gradientLayer];
    UIBezierPath *fillColorBezierPath = [HHDrawUtil fillColorBezierPathWithPoints:points curve:YES size:self.collectionView.frame.size];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = fillColorBezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    gradientLayer.mask = shapeLayer;
    
    [self.subLayers addObject:lineLayer];
    [self.subLayers addObject:gradientLayer];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSources.firstObject.values count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.firstCell = NO;
    cell.lastCell = NO;
    if (indexPath.row == 0) {
        cell.firstCell = YES;
    } else if (indexPath.row == [self.dataSources.firstObject.values count] - 1) {
        cell.lastCell = YES;
    }
    cell.config = self.config;
    cell.touchesAction = ^(UITouch * _Nonnull touch) {
        CGPoint indicatorPoint = [touch previousLocationInView:self.collectionView];        
        NSInteger index = (int)(indicatorPoint.x / self.config.itemWidth) + 2;
        if (self.delegate && [self.delegate respondsToSelector:@selector(curveView:didSelectItemAtIndex:)]) {
            [self.delegate curveView:self didSelectItemAtIndex:index - 2];
        }
        CGPoint prePoint = [[self.points objectAtIndex:((index-1) >= self.points.count) ? (self.points.count - 1) : (index - 1)] CGPointValue];
        CGPoint nowPoint = [[self.points objectAtIndex:(index >= self.points.count) ? (self.points.count - 1) : index] CGPointValue];
        CGPoint pq = [HHLineChartValue calculateBezierPointForCubicWithT:(1.0 / [self.dataSources objectAtIndex:0].values.count) point0:prePoint point1:CGPointMake((nowPoint.x + prePoint.x) / 2, prePoint.y) point2:CGPointMake((nowPoint.x + prePoint.x) / 2, nowPoint.y) point3:nowPoint];
        
        CGFloat indicatorX = pq.x/*indicatorPoint.x*/, indicatorY = pq.y;
        CGFloat indicatorWidth = 145, indicatorHeight = 76;
        if (indicatorX + indicatorWidth > self.collectionView.frame.size.width) {
            indicatorX -= (indicatorWidth + 5);
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
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.dataSources.firstObject.bottomTitles[indexPath.row]];
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
