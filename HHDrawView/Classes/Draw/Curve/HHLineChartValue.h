//
//  HHLineChartValue.h
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ChartModel.h"
NS_ASSUME_NONNULL_BEGIN

static inline CGFloat HHInterpolation(CGFloat from, CGFloat to, CGFloat ratio)
{
    return from + (to - from) * ratio;
}

@interface HHLineChartValue : NSObject
@property (nonatomic, assign, readonly)CGFloat max;
@property (nonatomic, assign, readonly)CGFloat min;

- (instancetype)initWithDataSource:(NSArray<ChartModel *> *)dataSource
                          separate:(NSInteger)separate;

/// 求三次贝塞尔曲线上任意一点的坐标
/// 公式：B(t) = P0 * (1-t)^3 + 3 * P1 * t * (1-t)^2 + 3 * P2 * t^2 * (1-t) + P3 * t^3, t ∈ [0,1]
/// @param t 曲线长度比例(所求"点"在曲线上的轨迹与整个轨迹长度的百分比)
/// @param p0 起始点  Start Point
/// @param p1 控制点1 Control Point
/// @param p2 控制点2 Control Point
/// @param p3 终止点  End Point
/// @return t对应的点
+ (CGPoint)calculateBezierPointForCubicWithT:(CGFloat)t point0:(CGPoint)p0 point1:(CGPoint)p1 point2:(CGPoint)p2 point3:(CGPoint)p3;
@end

NS_ASSUME_NONNULL_END
