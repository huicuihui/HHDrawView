# Curve
画曲线图

### 有以下几个类：
1. view
    画图
    view上面是一个collectionView
    CAShapeLayer 曲线的layer
    CAGradientLayer 渐变填充色的layer 
    填充色的path和曲线的路径基本一致，除了起点和终点，渐变色要从嘴底部填满。
2. util
    创建shapeLayer和bezierPath
3. model
4. HHLineChartValue
    数据处理类
    1. 把传入的数据找到最大值最小值。
5. ChartConfig
    设置每一条数据的宽度即cell宽度
    线的宽度，颜色等
6. HHChartCell
    每一条竖线所在的cell
7. HHIndicatorView
    指示弹窗。`self.userInteractionEnabled = NO;`
    注：
    indicatorView只在创建的时候，添加一次，之后画曲线图之后只需把indicatorView移到视图最上层。
    


### 点击任意位置弹窗
在HHChartCell中实现touchesBegan和touchesMoved方法，因为cell在响应者链的最上方。
将手势传出去，并且获取手势相对于collectionView的位置，进行弹窗。
可以点击也可以跟随手势位置滑动。
注
touchesMoved会和collectionView的滑动冲突，需要设置collectionView不可滚动。

### 数据
通过代理传入，代理方法必须实现。
1. 有几条线
2. 线的model 
    每条线的数据
    线的颜色
    线的渐变填充色


