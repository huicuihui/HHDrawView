//
//  HHDrawView.h
//  HHDrawDemo
//
//  Created by 崔辉辉 on 2020/7/28.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHChartConfig.h"
#import "HHCurveModel.h"
#import "HHIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

@class HHDrawView;
@class HHCurveModel;
@protocol HHDrawViewDataSource <NSObject>

@required

- (NSArray <HHCurveModel *>*)dataSourceWithDrawView:(HHDrawView *)drawView;

@end
@protocol HHDrawViewDelegate <NSObject>

@optional

- (void)curveView:(HHDrawView *)curveView didSelectItemAtIndex:(NSInteger)index;

@end

@interface HHDrawView : UIView

/// 指示弹窗
@property (nonatomic, strong)HHIndicatorView *indicatorView;

@property (nonatomic, weak)id<HHDrawViewDataSource> dataSource;
@property (nonatomic, weak)id<HHDrawViewDelegate> delegate;
/// 画曲线图
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
