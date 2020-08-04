//
//  HHIndicatorView.m
//  DrawDemo
//
//  Created by 崔辉辉 on 2020/7/30.
//  Copyright © 2020 huihui. All rights reserved.
//

#import "HHIndicatorView.h"
@interface HHIndicatorView()
@end
@implementation HHIndicatorView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpItems];
    }
    return self;
}
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
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = NO;
    self.labOne = [UILabel new];
    self.labOne.font = [UIFont systemFontOfSize:13];
    self.labOne.textColor = [UIColor darkTextColor];
    [self addSubview:self.labOne];
    
    self.labTwo = [UILabel new];
    self.labTwo.font = [UIFont systemFontOfSize:12];
    self.labTwo.textColor = [UIColor darkTextColor];
    [self addSubview:self.labTwo];
    
    self.labThree = [UILabel new];
    self.labThree.font = [UIFont systemFontOfSize:12];
    self.labThree.textColor = [UIColor darkTextColor];
    [self addSubview:self.labThree];
}
- (void)layoutSubviews
{
    self.labOne.frame = CGRectMake(10, 8, self.bounds.size.width - 15, 20);
    self.labTwo.frame = CGRectMake(10, 30, self.bounds.size.width - 15, 20);
    self.labThree.frame = CGRectMake(10, 52, self.bounds.size.width - 15, 20);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
