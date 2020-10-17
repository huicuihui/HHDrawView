//
//  HHChartCell.h
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/30.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHChartConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface HHChartCell : UICollectionViewCell
@property (nonatomic, strong)HHChartConfig *config;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, copy)void (^touchesAction)(UITouch *touch);

@end

NS_ASSUME_NONNULL_END
