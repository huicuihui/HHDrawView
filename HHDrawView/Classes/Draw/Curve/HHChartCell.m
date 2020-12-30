//
//  HHChartCell.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/30.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHChartCell.h"
@interface HHChartCell()
@property (nonatomic, strong)CAShapeLayer *shapeLayer;

/// 底部横线
@property (nonatomic, strong)CAShapeLayer *shapeHorizontalLayer;
@end
@implementation HHChartCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpItems];
    }
    return self;
}

- (void)setUpItems
{
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeHorizontalLayer = [CAShapeLayer layer];

    [self.contentView.layer addSublayer:self.shapeLayer];
    [self.contentView.layer addSublayer:self.shapeHorizontalLayer];
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat titleHeight = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height;
    self.titleLabel.frame = CGRectMake(0, height - titleHeight, width, titleHeight);
    
    
    CGFloat lineHeight = height - titleHeight - 10;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(width * 0.5 - 0.5, 0)];
    [bezierPath addLineToPoint:CGPointMake(width * 0.5 - 0.5, lineHeight)];
    self.shapeLayer.path = bezierPath.CGPath;
    
    UIBezierPath *horizontalBezierPath = [UIBezierPath bezierPath];
    if (self.firstCell) {
        [horizontalBezierPath moveToPoint:CGPointMake(width * 0.5 - 0.5, lineHeight)];
        [horizontalBezierPath addLineToPoint:CGPointMake(width, lineHeight)];
    } else if (self.lastCell) {
        [horizontalBezierPath moveToPoint:CGPointMake(0, lineHeight)];
        [horizontalBezierPath addLineToPoint:CGPointMake(width * 0.5 - 0.5, lineHeight)];
    } else {
        [horizontalBezierPath moveToPoint:CGPointMake(0, lineHeight)];
        [horizontalBezierPath addLineToPoint:CGPointMake(width, lineHeight)];
    }
    self.shapeHorizontalLayer.path = horizontalBezierPath.CGPath;
}

- (void)setConfig:(HHChartConfig *)config
{
    _config = config;
    self.shapeLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    self.shapeLayer.lineDashPattern = @[@(1.5)];
    self.shapeLayer.lineWidth = 1.0;
    self.shapeHorizontalLayer.strokeColor = [UIColor darkGrayColor].CGColor;
    self.shapeHorizontalLayer.lineDashPattern = @[@(1.5)];
    self.shapeHorizontalLayer.lineWidth = 1.0;
    [self setNeedsLayout];
}

#pragma mark - touchedBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (self.touchesAction) {
        self.touchesAction(touch);
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
//    CGPoint firstPoint = [touch locationInView:self];
    if (self.touchesAction) {
        self.touchesAction(touch);
    }
}
@end
