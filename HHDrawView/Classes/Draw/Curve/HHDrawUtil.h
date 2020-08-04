//
//  HHDrawUtil.h
//  HHDrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HHDrawUtil : NSObject

+ (CAShapeLayer *)shapeLayerWithLineWidth:(CGFloat)linewidth
                              strokeColor:(UIColor *)strokeColor;

/// <#Description#>
/// @param points <#points description#>
/// @param curve YES：曲线     NO：折线
+ (UIBezierPath *)bezierPathWithPoints:(NSArray *)points
                                 curve:(BOOL)curve;

/// 填充色的路径
/// @param points <#points description#>
/// @param curve <#curve description#>
/// @param size <#size description#>
+ (UIBezierPath *)fillColorBezierPathWithPoints:(NSArray *)points
                                          curve:(BOOL)curve
                                           size:(CGSize)size;

/// 背景渐变色
+ (CAGradientLayer *)gradientLayerWithColors:(NSArray *)colors;

@end

NS_ASSUME_NONNULL_END
