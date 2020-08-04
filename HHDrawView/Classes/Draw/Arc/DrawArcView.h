//
//  DrawArcView.h
//  DrawDemo
//
//  Created by 崔辉辉 on 2019/9/18.
//  Copyright © 2019 huihui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawArcView : UIView
@property (nonatomic, assign)CGFloat startAngle;

/// 在drawRect中画环，不带动画
@property (nonatomic, assign)BOOL drawRect;

/// 圆弧占整个圆环的比例 范围：0～1
@property (nonatomic, assign)CGFloat endAngleScale;

/// 线条颜色
@property (nonatomic, strong)UIColor *lineColor;




/// 线条颜色
@property (nonatomic, strong)UIColor *shapeLayerStrokeColor;

/// <#Description#>
/// @param fromValue 范围：0.0 ~ 1.0
/// @param toValue 范围：0.0 ~ 1.0
- (void)startAnimatingWithFromValue:(CGFloat)fromValue
                            toValue:(CGFloat)toValue;
- (void)startAnimatingWithFromValue:(CGFloat)fromValue
                            toValue:(CGFloat)toValue
                           duration:(CFTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
