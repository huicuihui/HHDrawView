//
//  HHDrawUtil.m
//  HHDrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHDrawUtil.h"

@implementation HHDrawUtil

+ (CAShapeLayer *)shapeLayerWithLineWidth:(CGFloat)linewidth strokeColor:(UIColor *)strokeColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = linewidth;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    if (strokeColor) {
        shapeLayer.strokeColor = strokeColor.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    return shapeLayer;;
}

+ (UIBezierPath *)bezierPathWithPoints:(NSArray *)points
                                 curve:(BOOL)curve
{
    if (points.count <= 0) {
        return nil;
    }
    
    CGPoint p1 = [points.firstObject CGPointValue];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p1];
    for (int i = 1; i < points.count; i++) {
        CGPoint prePoint = [[points objectAtIndex:i-1] CGPointValue];
        CGPoint nowPoint = [[points objectAtIndex:i] CGPointValue];
        if (curve) {
            [bezierPath addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x + prePoint.x) / 2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x + prePoint.x) / 2, nowPoint.y)];
        } else {
            [bezierPath addLineToPoint:nowPoint];
        }
    }
    return bezierPath;
}


/// 填充色的路径
/// @param points <#points description#>
/// @param curve <#curve description#>
/// @param size <#size description#>
+ (UIBezierPath *)fillColorBezierPathWithPoints:(NSArray *)points
                                          curve:(BOOL)curve
                                           size:(CGSize)size
{
    if (points.count <= 0) {
        return nil;
    }
    
    CGPoint p1 = [points.firstObject CGPointValue];
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(p1.x, size.height)];
    for (int i = 1; i < points.count; i++) {
        CGPoint prePoint = [[points objectAtIndex:i-1] CGPointValue];
        CGPoint nowPoint = [[points objectAtIndex:i] CGPointValue];
        if (curve) {
            [bezierPath addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x + prePoint.x) / 2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x + prePoint.x) / 2, nowPoint.y)];
        } else {
            [bezierPath addLineToPoint:nowPoint];
        }
    }
    [bezierPath addLineToPoint:CGPointMake([points.lastObject CGPointValue].x, size.height)];
    return bezierPath;
}

/// 背景渐变色
+ (CAGradientLayer *)gradientLayerWithColors:(NSArray *)colors
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.colors = colors;
    
    gradientLayer.locations=@[@0.0,@1.0];
    gradientLayer.startPoint = CGPointMake(0.0,0.0);
    gradientLayer.endPoint = CGPointMake(0,1);
    
//    CAShapeLayer *arc = [CAShapeLayer layer];
//    arc.path = bezierPath.CGPath;
//    gradientLayer.mask = arc;
    return gradientLayer;
}


@end
