//
//  HHChartConfig.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHChartConfig.h"

@implementation HHChartConfig
- (CGFloat)itemWidth
{
    if (!_itemWidth) {
        self.itemWidth = 35;
    }
    return _itemWidth;
}

- (CGFloat)indicatorAnimateDuration
{
    if (!_indicatorAnimateDuration) {
        self.indicatorAnimateDuration = 0.005;
    }
    return _indicatorAnimateDuration;
}

- (CGFloat)bottomSpace
{
    if (!_bottomSpace) {
        self.bottomSpace = 10;
    }
    return _bottomSpace;
}
@end
