//
//  HHDrawView.h
//  HHDrawDemo
//
//  Created by 崔辉辉 on 2020/7/28.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHChartConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHDrawView : UIView
@property (nonatomic, weak)id<HHDrawViewDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
