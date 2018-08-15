# LuWaveView

实现逻辑

 1, 底部有个白色背景的 label
 
 2，上边一个蓝色背景的 label
 
 3，给蓝色背景的label 添加一个遮罩
 
    CALayer有一个属性叫做mask，通常被称为蒙版图层
    mask定义了父图层的可见区域
    最终父视图显示的形态是父视图自身和它的属性mask的交集部分
    
 
 4，用贝塞尔曲线画出一个波浪线   x 递增 y 用sin函数获取
 
 {
 正弦函数图像变换 y =Asin（ωx+φ）+ C
 
 A 表示振幅，也就是使用这个变量来调整波浪的高度
 ω 表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ 表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C 表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置。
 }
 
 从 0，0 -> x：0 - 100 y : Asin（ωx+φ）+ C -> 100,100 -> 0,100
 
 通过UIBezierPath的函数addLineToPoint来把这些点连接起来，就构建了波浪形状的path
 
 
 5，通过CADisplayLink  改变offset 让波浪动起来
 
 ![image](https://github.com/luzhilei/LuWaveView/blob/master/LuWaveView/Assets.xcassets/wave.imageset/wave.png)
