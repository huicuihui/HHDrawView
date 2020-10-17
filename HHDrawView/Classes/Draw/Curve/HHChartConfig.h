//
//  HHChartConfig.h
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/29.
//  Copyright © 2020 huihui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HHChartConfig : NSObject
@property (nonatomic, assign)CGFloat itemWidth;
@property (nonatomic, assign)CGFloat indicatorAnimateDuration;
@property (nonatomic, assign)CGFloat bottomSpace;

//曲线图上下的边距
@property (nonatomic, assign)CGFloat lineTopSpace;
@property (nonatomic, assign)CGFloat lineBottomSpace;

@end

NS_ASSUME_NONNULL_END
