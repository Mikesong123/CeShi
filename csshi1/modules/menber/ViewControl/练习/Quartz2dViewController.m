//
//  Quartz2dViewController.m
//  csshi1
//
//  Created by 高 on 16/3/17.
//  Copyright © 2016年 高. All rights reserved.
//

#import "Quartz2dViewController.h"

//初始相位
static float phase = 0;
//相位偏移量
static float phaseShift = 0.25;

@interface Quartz2dViewController (){
    CALayer *coverlayer;
    
    int (^someblock)(int,int);
    UILabel *(^someLbale)(* UILabel);
    
}


@property (nonatomic, strong) CADisplayLink *displayLink;
//背景图层
@property (nonatomic, strong) CALayer *canvasLayer;
//遮罩图层
@property (nonatomic, strong) CAShapeLayer *waveLayer;
//背景图层frame
@property (nonatomic) CGRect frame;
//遮罩图层frame
@property (nonatomic) CGRect shapeFrame;

@property (nonatomic, strong) UILabel *label;

@end

@implementation Quartz2dViewController

- (UILabel *)label{
    if (!_label) {
      
    }
    return _label;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self draw];
//    [self drawLine1];
    
//   someblock = ^int(int a ,int b){
//        return a + b;
//    };
    if (_isplay) {
        if (self.isplay(@"jjjkkk")) {
            NSLog(@"返回正确");
        }
    }
    
}
- (void)draw{
    
    someblock = ^int(int a ,int b){
        return a + b;
    };
    
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 200, 200);
    CGContextAddPath(ctx, path);
    [[UIColor redColor]set];
    CGContextStrokePath(ctx);
    
}


- (void)drawLine1
{
    
    int A =  someblock(10 , 20);
    NSLog(@"%d",A);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 这个方法系统会自动给你生成路径,自动给你添加到上下文,但是底层还是封装的drawLine里写的方法
    // 描述路径
    // 设置起点
    CGContextMoveToPoint(ctx, 50, 50);
    // 终点
    CGContextAddLineToPoint(ctx, 200, 200);
    
    // 渲染上下文
    CGContextStrokePath(ctx);
}
- (void)draw2{
    
    CALayer *pContainerLayer = [CALayer layer];
    pContainerLayer.frame = CGRectMake(200, 70, 100, 50);
    pContainerLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [self.view.layer addSublayer:pContainerLayer];
    
    CALayer *pCoverLayer = [CALayer layer];
    pCoverLayer.frame = CGRectMake(0  , 0, 0, 50);
    pCoverLayer.backgroundColor = [[UIColor greenColor] CGColor];
    pCoverLayer.anchorPoint = CGPointMake(0, 0.5);
    [pContainerLayer addSublayer:pCoverLayer];
    
    CGFloat pToX = 100 ;
    CABasicAnimation *pAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];;
    pAnimation.fromValue = @(0);
    pAnimation.toValue = @(pToX);
    pAnimation.duration = 5.0f;
    pAnimation.repeatCount = 1;
    pAnimation.removedOnCompletion = YES;
    
    [pCoverLayer addAnimation:pAnimation forKey:nil];
    pCoverLayer.bounds = CGRectMake(0, 0, 100, 50);
}

- (void)draw3{
    
    //bounds.size.width animation
    CALayer *bContainerLayer = [CALayer layer];
    bContainerLayer.frame = CGRectMake(200, 110, 100, 50);
    bContainerLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [self.view.layer addSublayer:bContainerLayer];
    
    CALayer *bCoverLayer = [CALayer layer];
    bCoverLayer.frame = CGRectMake(0, 0, 0, 50);
    bCoverLayer.backgroundColor = [[UIColor greenColor] CGColor];
    bCoverLayer.anchorPoint = CGPointMake(0, 0.5);
    [bContainerLayer addSublayer:bCoverLayer];
    
    CGFloat bToWidth = 100;
    CABasicAnimation *bAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    bAnimation.fromValue = @(0);
    bAnimation.toValue = @(bToWidth);
    bAnimation.duration = 5.0f;
    bAnimation.repeatCount = 1;
    bAnimation.removedOnCompletion = YES;
    
    [bCoverLayer addAnimation:bAnimation forKey:nil];
    // change model layer bounds
    bCoverLayer.bounds = CGRectMake(0, 0, 100, 50);
}

- (void)draw4{
    CALayer *slider = [CALayer layer];
    slider.frame = CGRectMake(200, 100, 100, 50);
    slider.backgroundColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:slider];
    
    CALayer *cover = [CALayer layer];
    cover.frame = CGRectMake(0, 0, 0, 50);
    cover.backgroundColor = [UIColor greenColor].CGColor;
    cover.anchorPoint = CGPointMake(0, 0.5);
    [slider addSublayer:cover];
    coverlayer = cover;
    
    UISlider *sslider = [[UISlider alloc] initWithFrame:CGRectMake(200, 300, 100, 30)];
    [sslider addTarget:self action:@selector(update:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sslider];
}
- (void)update:(UISlider *)sliders{
    coverlayer.frame = CGRectMake(0, 0, sliders.value *100, 50);
}

- (void)draw5{
    
    CALayer *canvasLayer = [CALayer layer];
    canvasLayer.frame = CGRectMake(200, 80, 52, 94);
    canvasLayer.backgroundColor = [[UIColor orangeColor] CGColor];
    [self.view.layer addSublayer:canvasLayer];
    
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.path = [[self craetBezierPath] CGPath];
    canvasLayer.mask = ovalShapeLayer;
    
    CALayer *coverLayer = [CALayer layer];
    coverLayer.frame = CGRectMake(0, 0 , 52, 94 );
    coverLayer.anchorPoint = CGPointMake(0, 0);
    coverLayer.position = CGPointMake(0, 0);
    coverLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    [canvasLayer addSublayer:coverLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"bounds.size.height";
    animation.fromValue = @(94);
    animation.toValue = @(0);
    animation.duration = 5;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = YES;
    
    [coverLayer addAnimation:animation forKey:nil];
    
}
- (UIBezierPath *)craetBezierPath {
    
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: CGPointMake(53, 30.53)];
    //半圈
    [ovalPath addCurveToPoint: CGPointMake(27, 95) controlPoint1: CGPointMake(53, 46.83) controlPoint2: CGPointMake(41.36, 95)];
    [ovalPath addCurveToPoint: CGPointMake(1, 30.53) controlPoint1: CGPointMake(12.64, 95) controlPoint2: CGPointMake(1, 46.83)];
    [ovalPath addCurveToPoint: CGPointMake(27, 1) controlPoint1: CGPointMake(1, 14.22) controlPoint2: CGPointMake(12.64, 1)];
    [ovalPath addCurveToPoint: CGPointMake(53, 30.53) controlPoint1: CGPointMake(41.36, 1) controlPoint2: CGPointMake(53, 14.22)];
    [ovalPath closePath];
    
    return ovalPath;
}

- (void)draw6{
    
    CGFloat shapePointY = 200;
    CGRect frame = CGRectMake(0, 0, 100, 200);
    CGRect shapeFrame = CGRectMake(0, shapePointY, 100, 200);
    self.frame = frame;
    self.shapeFrame = shapeFrame;
    
    //黑色边框
    CALayer *bglayer = [CALayer layer];
    bglayer.frame = CGRectMake(0, 20, 100, 200);
    bglayer.borderWidth = 1.0;
    bglayer.borderColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:bglayer];
    
    //创建背景图层
    self.canvasLayer = [CALayer layer];
    self.canvasLayer.frame = frame;
    self.canvasLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [bglayer addSublayer:self.canvasLayer];
    //创建遮罩图层
    self.waveLayer = [CAShapeLayer layer];
    self.waveLayer.frame = shapeFrame;
    //设定mask为waveLayer
    self.canvasLayer.mask = self.waveLayer;
    
    //开始动画
    [self startAnimating];
}

- (void)startAnimating {
    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    //获得结束时的position.y值
    CGPoint position = self.waveLayer.position;
    position.y = position.y - self.shapeFrame.size.height;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.waveLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = 5.0;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.waveLayer addAnimation:animation forKey:nil];
    
}
//波浪滚动 phase相位每桢变化值：phaseShift
- (void)update {
    CGRect frame = self.frame;
    phase += phaseShift;
    UIGraphicsBeginImageContext(frame.size);
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    //用UIBezierPath画一个闭合的路径
    CGFloat endX = 0;
    for(CGFloat x = 0; x < frame.size.width ; x += 1) {
        endX=x;
        //正弦函数，求y值
        CGFloat y = 5 * sinf(2 * M_PI *(x / frame.size.width)  + phase) ;
        if (x==0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        }else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
    CGFloat endY = CGRectGetHeight(frame);
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    //修改每桢的wavelayer.path
    self.waveLayer.path = [wavePath CGPath];
    UIGraphicsEndImageContext();
}

@end
