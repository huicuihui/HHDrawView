//
//  DrawTrianglePath.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2019/12/5.
//  Copyright © 2019 huihui. All rights reserved.
//

#import "DrawTrianglePath.h"

@implementation DrawTrianglePath
+ (CAShapeLayer *)hh_maskLayerWithRect:(CGRect)rect
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self hh_bezierPathWithRect:rect cornerRadius:cornerRadius borderWidth:0 borderColor:[UIColor blueColor] backgroundColor:[UIColor redColor] arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition].CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor redColor].CGColor;
    return shapeLayer;
}
+ (UIBezierPath *)hh_bezierPathWithRect:(CGRect)rect
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, rect.size.width - borderWidth, rect.size.height - borderWidth);
    CGFloat topRightRadius = 0, topLeftRadius = 0, bottomRightRadius = 0, bottomLeftRadius = 0;
    CGPoint topRightArcCenter,topLeftArcCenter,bottomRightArcCenter,bottomLeftArcCenter;
    
    CGFloat rectX = rect.origin.x, rectWidth = rect.size.width, rectHeight = rect.size.height;
    CGFloat rectTop = rect.origin.y;
    
    topLeftArcCenter = CGPointMake(topLeftRadius + rectX, arrowHeight + topLeftRadius + rectX);
    topRightArcCenter = CGPointMake(rectWidth - topRightRadius + rectX, arrowHeight + topRightRadius + rectX);
    bottomLeftArcCenter = CGPointMake(bottomLeftRadius + rectX, rectHeight - bottomLeftRadius + rectX);
    bottomRightArcCenter = CGPointMake(rectWidth - bottomRightRadius + rectX, rectHeight - bottomRightRadius + rectX);
    if (arrowPosition < topLeftRadius + arrowWidth / 2) {
        arrowPosition = topLeftRadius + arrowWidth / 2;
    }else if (arrowPosition > rectWidth - topRightRadius - arrowWidth / 2) {
        arrowPosition = rectWidth - topRightRadius - arrowWidth / 2;
    }
    [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + rectX)];
    [bezierPath addLineToPoint:CGPointMake(arrowPosition, rectTop + rectX)];
    [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + rectX)];
    
    [bezierPath addLineToPoint:CGPointMake(rectWidth - topRightRadius, arrowHeight + rectX)];
    [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
    
    [bezierPath addLineToPoint:CGPointMake(rectWidth + rectX, rectHeight - bottomRightRadius - rectX)];
    [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + rectX, rectHeight + rectX)];
    [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    
    [bezierPath addLineToPoint:CGPointMake(rectX, arrowHeight + topLeftRadius + rectX)];
    [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    
    [bezierPath closePath];
    return bezierPath;
}
@end
