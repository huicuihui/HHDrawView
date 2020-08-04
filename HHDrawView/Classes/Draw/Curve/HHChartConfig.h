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
@end

@class HHDrawView;

@protocol HHDrawViewDataSource <NSObject>

@required

- (NSInteger)numberOfLineWithDrawView:(HHDrawView *)drawView;

- (NSArray *)dataSourceWithDrawView:(HHDrawView *)drawView
                              index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
