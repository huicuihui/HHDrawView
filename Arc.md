# DrawDemo
带动画的环形进度条

## 属性的组合产生的效果总结
1. keyPath = strokeStart  动画的fromValue = 0，toValue = 1
    strokeEnd默认为1，strokeStart从 0 到 1 ，strokeStart = 0 时有一条完整的路径，strokeStart = 1 时 路径消失。效果就是一条从路径起点到终点慢慢的消失
2. keyPath = strokeStart  动画的fromValue = 1，toValue = 0     
    strokeEnd默认为1，strokeStart从 1 到 0 ，strokeStart = 1 时无路径，strokeStart = 0 时 画出一条完整的路径。效果就是一条从路径终点到起点慢慢的出现
3. keyPath = strokeEnd  动画的fromValue = 0，toValue = 1
    strokeStart默认为0，strokeEnd从 0-1，strokeEnd=0 时，无路径，strokeEnd=1 时，一条完整路径。效果就是一条路径起点到终点慢慢的出现
4. keyPath = strokeEnd  动画的fromValue = 1，toValue = 0
    效果就是一条路径从终点到起点慢慢消失

## 从12点开始方向开始的动画
CAShapeLayer的path定为从12点开始的圆就行了。

用来画线条的函数：
UIBezierPath *bezier = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
- radius: 半径
- clockwise:YES 顺时针， NO 逆时针
- startAngle和endAngle
    设置起点和终点
    - -M_PI_2：12点钟
    - M_PI_2 * 3：12点钟
    - 0：3点钟
    - M_PI_2：6点钟
    - M_PI：9点钟
    - M_PI * 2：3点钟
一整圈：M_PI * 2
四分之一圈：M_PI_2

## 进度
传的值范围：0～1。当前的进度占总数的百分比。一个小数。
