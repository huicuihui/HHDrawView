//
//  HHChartConfig.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHChartConfig.h"

@implementation HHChartConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemWidth = 35;

        self.lineTopSpace = 30;
        self.lineBottomSpace = 35;
    }
    return self;
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
