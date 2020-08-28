//
//  DrawArcView.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2019/9/18.
//  Copyright © 2019 huihui. All rights reserved.
//

#import "DrawArcView.h"
@interface DrawArcView()
{
    dispatch_source_t timer;
}
@property (nonatomic, strong)CAShapeLayer *shapeLayer;
@end
@implementation DrawArcView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
//在其中进行绘图操作，在首次显示该view时程序会自动调用此方法进行绘图。 在多次手动重复绘制的情况下，需要调用UIView中的setNeedsDisplay方法，则程序会自动调用drawRect方法进行重绘。
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.drawRect) {
        //画背景图
        //圆环有个背景进度刻度图，需要画上去。使用UIImageView的话，会显示在上面，因为圆环是画的，在view上，最底层。
        UIImage *bgImage = [UIImage imageNamed:@"arcBg"];
        [bgImage drawInRect:rect];
        
        [self drawARCPath];
    }
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        //圆弧
//        UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        //设置画弧方向和开始的位置
        //顺时针，从12点开始：startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES
        //逆时针，从12点开始：startAngle:M_PI_2 * 3 endAngle:-M_PI_2 clockwise:NO
        UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:self.bounds.size.width / 2.0 startAngle:M_PI_2 * 3 endAngle:-M_PI_2 clockwise:NO];

        //CAShapeLayer
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        //给shapeLayer设置路径，路径需要是CGPathRef类型的
        shapeLayer.path = bezier.CGPath;
        //线宽
        shapeLayer.lineWidth = 10;
        //端点样式
        shapeLayer.lineCap = kCALineCapRound;
        //线条颜色
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        //填充颜色
        shapeLayer.fillColor = nil;
        [self.layer addSublayer:shapeLayer];
        self.shapeLayer = shapeLayer;
    }
    return _shapeLayer;
}

/// 线条颜色
/// @param shapeLayerStrokeColor 线条颜色
- (void)setShapeLayerStrokeColor:(UIColor *)shapeLayerStrokeColor {
    self.shapeLayer.strokeColor = shapeLayerStrokeColor.CGColor;
    _shapeLayerStrokeColor = shapeLayerStrokeColor;
}

- (void)startAnimatingWithFromValue:(CGFloat)fromValue
                            toValue:(CGFloat)toValue
{
    //转一圈是3.0秒，
    CGFloat speed = 3.0;
    [self startAnimatingWithFromValue:fromValue toValue:toValue duration:fabs(fromValue - toValue) * speed];
}
- (void)startAnimatingWithFromValue:(CGFloat)fromValue
                            toValue:(CGFloat)toValue
                           duration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSNumber numberWithFloat:fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    //保存动画最前面的效果
    animation.fillMode = kCAFillModeForwards;
    //告诉动画完成的时候不要移除（这个很重要），完成后是否删除动画
    //NO：动画完成后不会变为动画之前的样式
    //YES：动画结束之后会返回原来的样式
    animation.removedOnCompletion = NO;
//    animation.repeatCount = 1;
    [self.shapeLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    [self updateTextWithDuration:duration fromValue:fromValue toValue:toValue];
}
- (void)updateTextWithDuration:(CFTimeInterval)duration
                     fromValue:(CGFloat)fromValue
                       toValue:(CGFloat)toValue {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    __block CGFloat timeCount = fromValue;
    //时间间隔
    CGFloat intervalTime = 0.05;
    CGFloat intervalValue = (toValue - fromValue) / (duration / intervalTime);
    // 每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), intervalTime * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //======在这根据自己的需求去刷新UI==============
            NSLog(@"timeCount==%f",timeCount);
        });
        if (timeCount >= toValue) {
            dispatch_source_cancel(self->timer);
        }
        timeCount += intervalValue;
    });
    
    dispatch_resume(timer);
}

-(void)drawARCPath
{
    //-M_PI_2 从12点开始
    //顺时针，从12点开始：startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES
    //逆时针，从12点开始：startAngle:M_PI_2 * 3 endAngle:-M_PI_2 clockwise:NO
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:self.bounds.size.width / 2.0 startAngle:M_PI_2 * 3 endAngle:M_PI_2 * 3 - self.endAngleScale * M_PI * 2 clockwise:NO];

    //连接处的样式
    path.lineCapStyle = kCGLineCapRound;
    //连接方式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 7;

    [self.lineColor set];
    [path stroke];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
