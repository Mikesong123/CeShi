//
//  ceshi1ViewController.m
//  csshi1
//
//  Created by 高 on 16/2/18.
//  Copyright © 2016年 高. All rights reserved.
//

#import "ceshi1ViewController.h"

#define kDegreesToRadian(x) (M_PI * (x) / 180.0 )

#define kRadianToDegrees(radian) (radian* 180.0 )/(M_PI)

@interface ceshi1ViewController ()
{
    UILabel *myTest1;
}

@end

@implementation ceshi1ViewController

- ( void )viewDidLoad

{
    
    [ super viewDidLoad ];
    
    self . title = @" 测试动画 " ;
    
    self . view . backgroundColor = [UIColor whiteColor ];
    
    myTest1 = [[ UILabel alloc ] initWithFrame : CGRectMake ( 10 , 100 , 60 , 40 )];
    
    myTest1.backgroundColor = [ UIColor whiteColor ];
    
    myTest1.textAlignment = NSTextAlignmentCenter ;
    
    myTest1.text = @" 张明炜 " ;
    
    myTest1.textColor = [ UIColor greenColor ];
    
    [ self.view addSubview : myTest1 ];
    
    
    
   //  闪烁效果。
    
//        [myTest1.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    
    /// 移动的动画。
    
//        [myTest1.layer addAnimation:[self moveX:1.0f X:[NSNumber numberWithFloat:200.0f]] forKey:nil];
    
    // 缩放效果。
    
//        [myTest1.layer addAnimation:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:3.0f] durTimes:2.0f Rep:MAXFLOAT] forKey:nil];
    
    // 组合动画。
    
//        NSArray *myArray = [NSArray arrayWithObjects:[self opacityForever_Animation:0.5],[self moveX:1.0f X:[NSNumber numberWithFloat:200.0f]],[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:3.0f] durTimes:2.0f Rep:MAXFLOAT], nil];
//    
//        [myTest1.layer addAnimation:[self groupAnimation:myArray durTimes:3.0f Rep:MAXFLOAT] forKey:nil];
    
    // 路径动画。
    
        CGMutablePathRef myPah = CGPathCreateMutable();
    
        CGPathMoveToPoint(myPah, nil,30, 77);
    
        CGPathAddCurveToPoint(myPah, nil, 50, 50, 60, 200, 200, 300);// 这里的是控制点。
    
        [myTest1.layer addAnimation:[self keyframeAnimation:myPah durTimes:5 Rep:MAXFLOAT] forKey:nil];
    
    // 旋转动画。
    
//    [ myTest1 . layer addAnimation :[ self rotation : 2 degree : kRadianToDegrees ( 90 ) direction : 1 repeatCount : MAXFLOAT ] forKey : nil ];
    
}

#pragma mark === 永久闪烁的动画 ======

- (CABasicAnimation *)opacityForever_Animation:( float )time

{
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"opacity" ]; // 必须写 opacity 才行。
    
    animation. fromValue  =  [ NSNumber numberWithFloat : 1.0f ] ;
    
    animation. toValue = [ NSNumber numberWithFloat : 0.0f ]; // 这是透明度。
    
    animation. autoreverses = YES ;
    
    animation. duration = time;
    
    animation. repeatCount = MAXFLOAT ;
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation. timingFunction =[ CAMediaTimingFunction functionWithName : kCAMediaTimingFunctionEaseIn ]; /// 没有的话是均匀的动画。
    
    return animation;
    
}

#pragma mark ===== 横向、纵向移动 ===========

-( CABasicAnimation *)moveX:( float )time X:( NSNumber *)x

{
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform.translation.x" ]; ///.y 的话就向下移动。
    
    animation. toValue = x;
    
    animation. duration = time;
    
    animation. removedOnCompletion = NO ; //yes 的话，又返回原位置了。
    
    animation. repeatCount = MAXFLOAT ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    return animation;
    
}

#pragma mark ===== 缩放 -=============

-(CABasicAnimation *)scale:( NSNumber *)Multiple orgin:( NSNumber *)orginMultiple durTimes:( float )time Rep:( float )repertTimes

{
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform.scale" ];
    
    animation. fromValue = Multiple;
    
    animation. toValue = orginMultiple;
    
    animation. autoreverses = YES ;
    
    animation. repeatCount = repertTimes;
    
    animation. duration = time; // 不设置时候的话，有一个默认的缩放时间 .
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    return   animation;
    
}

#pragma mark ===== 组合动画 -=============

-( CAAnimationGroup *)groupAnimation:( NSArray *)animationAry durTimes:( float )time Rep:( float )repeatTimes

{
    
    CAAnimationGroup *animation = [ CAAnimationGroup animation ];
    
    animation. animations = animationAry;
    
    animation. duration = time;
    
    animation. removedOnCompletion = NO ;
    
    animation. repeatCount = repeatTimes;
    
    animation. fillMode = kCAFillModeForwards ;
    
    return animation;
    
}

#pragma mark ===== 路径动画 -=============

-( CAKeyframeAnimation *)keyframeAnimation:( CGMutablePathRef )path durTimes:( float )time Rep:( float )repeatTimes

{
    
    CAKeyframeAnimation *animation = [ CAKeyframeAnimation animationWithKeyPath : @"position" ];
    
    animation. path = path;
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation. timingFunction = [ CAMediaTimingFunction functionWithName : kCAMediaTimingFunctionEaseIn ];
    
    animation. autoreverses = NO ;
    
    animation. duration = time;
    
    animation. repeatCount = repeatTimes;
    
    return animation;
    
}

#pragma mark ==== 旋转动画 ======

-( CABasicAnimation *)rotation:( float )dur degree:( float )degree direction:( int )direction repeatCount:( int )repeatCount

{
    
    CATransform3D rotationTransform = CATransform3DMakeRotation (degree, 0 , 0 , direction);
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"transform" ];
    
    animation. toValue = [ NSValue valueWithCATransform3D :rotationTransform];
    
    animation. duration   =  dur;
    
    animation. autoreverses = NO ;
    
    animation. cumulative = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation. repeatCount = repeatCount;
    
    animation. delegate = self ;
    
    return animation;
    
}


@end
