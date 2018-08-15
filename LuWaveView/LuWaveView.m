//
//  LuWaveView.m
//  LuWaveView
//
//  Created by Rango on 2018/8/15.
//  Copyright © 2018年 Rango. All rights reserved.
//

#import "LuWaveView.h"
@interface LuWaveView()

@property (nonatomic ,assign)CGFloat offSet;
@property (nonatomic ,assign)CGRect rect;
@property (nonatomic ,strong)CAShapeLayer *waveLayer;
@end
@implementation LuWaveView

/*
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
 
 */
-(void)waveCycle{
    self.offSet += 15;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    CGFloat y = 0.0;
    for (CGFloat x = 0.0; x <= self.rect.size.width; x ++) {
        y = self.rect.size.height *0.05 * sin((8 * x + self.offSet) * 0.01);
        [path addLineToPoint:CGPointMake(x, y)];
        
    }
    [path addLineToPoint:CGPointMake(self.rect.size.width, self.rect.size.height)];
    [path addLineToPoint:CGPointMake(0, self.rect.size.height)];
    [path closePath];
    self.waveLayer.path = path.CGPath;
    
}

+(instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor waveColor:(UIColor *)waveColor frame:(CGRect )rect{
    
    LuWaveView *view = [[LuWaveView alloc]initWithFrame:rect];
    view.rect = rect;
    //白色label
    UILabel *whiteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    whiteLabel.textColor = textColor;
    whiteLabel.backgroundColor = [UIColor cyanColor];
    whiteLabel.font = [UIFont systemFontOfSize:50];
    whiteLabel.text = text;
    whiteLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:whiteLabel];
    
    //蓝色label
    UILabel *blueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    blueLabel.backgroundColor = waveColor;
    blueLabel.textColor = [UIColor cyanColor];
    blueLabel.font = [UIFont systemFontOfSize:50];
    blueLabel.text = text;
    blueLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:blueLabel];
    
    //蓝色label mask
    CAShapeLayer *waveLayer = [CAShapeLayer layer];
    waveLayer.frame = CGRectMake(0, rect.size.height/2, rect.size.width, rect.size.height);
    blueLabel.layer.mask = waveLayer;
    view.waveLayer = waveLayer;
    
    CADisplayLink * dispalyLink = [CADisplayLink displayLinkWithTarget:view selector:@selector(waveCycle)];
    [dispalyLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    return view;
}

@end
