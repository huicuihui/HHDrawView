//
//  HHLineChartValue.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHLineChartValue.h"

@implementation HHLineChartValue
- (instancetype)initWithDataSource:(NSArray<ChartModel *> *)dataSource
                          separate:(NSInteger)separate
{
    self = [super init];
    if (self) {
        NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:dataSource.count];
        [dataSource enumerateObjectsUsingBlock:^(ChartModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [numbers addObject:@(obj.value)];
        }];
        [self valueSortWithDatas:numbers];
    }
    return self;
}
- (void)valueSortWithDatas:(NSArray<NSNumber *> *)datas
{
    __block CGFloat max = [datas.firstObject floatValue];
    __block CGFloat min = [datas.firstObject floatValue];
    [datas enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.doubleValue > max) {
            max = obj.doubleValue;
        }
        if (obj.doubleValue < min) {
            min = obj.doubleValue;
        }
    }];
    
    _min = min;
    _max = max;
}


/// 求三次贝塞尔曲线上任意一点的坐标
/// 公式：B(t) = P0 * (1-t)^3 + 3 * P1 * t * (1-t)^2 + 3 * P2 * t^2 * (1-t) + P3 * t^3, t ∈ [0,1]
/// @param t 曲线长度比例(所求"点"在曲线上的轨迹与整个轨迹长度的百分比)
/// @param p0 起始点  Start Point
/// @param p1 控制点1 Control Point
/// @param p2 控制点2 Control Point
/// @param p3 终止点  End Point
/// @return t对应的点
+ (CGPoint)calculateBezierPointForCubicWithT:(CGFloat)t point0:(CGPoint)p0 point1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3
{
    CGPoint point = CGPointZero;
    float temp = 1 - t;
    point.x = p0.x * temp * temp * temp + 3 * p1.x * t * temp * temp + 3 * p2.x * t * t * temp + p3.x * t * t * t;
    point.y = p0.y * temp * temp * temp + 3 * p1.y * t * temp * temp + 3 * p2.y * t * t * temp + p3.y * t * t * t;
    return point;
}
@end
