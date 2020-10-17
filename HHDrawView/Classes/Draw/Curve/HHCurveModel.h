//
//  HHCurveModel.h
//  HHDrawView
//
//  Created by 崔辉辉 on 2020/10/15.
//  曲线model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHCurveModel : NSObject

/// 曲线的点点值
@property (nonatomic, strong)NSArray *values;

/// 曲线线的颜色
@property (nonatomic, strong)UIColor *lineColor;

/// 渐变填充色
@property (nonatomic, strong)NSArray *fillColors;

/// 底部title
@property (nonatomic, strong)NSArray *bottomTitles;
@end

NS_ASSUME_NONNULL_END
