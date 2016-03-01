//
//  UIView+Appearance.h
//  socialDemo
//
//  Created by 陈欢 on 14-1-2.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Appearance)

/**
 *  返回UIView尺寸
 *
 *  @return UIView尺寸
 */
- (CGSize)size;

/**
 *  设置UIView尺寸
 *
 *  @param size 设置的size
 */
- (void)setSize:(CGSize)size;

/**
 *  返回origin.x
 *
 *  @return 返回self.frame.origin.x
 */
- (CGFloat)x;

/**
 *  设置origin.x
 *
 *  @param x 设置的origin.x
 */
- (void)setX:(CGFloat)x;

/**
 *  返回origin.y
 *
 *  @return 设置的origin.y
 */
- (CGFloat)y;

/**
 *  设置origin.y
 *
 *  @param y 设置的origin.y
 */
- (void)setY:(CGFloat)y;

/**
 *  获取UIView宽度
 *
 *  @return UIView宽度
 */
- (CGFloat)width;

/**
 *  设置UIView宽度
 *
 *  @param width 设置的UIView宽度
 */
- (void)setWidth:(CGFloat)width;

/**
 *  获取UIView高度
 *
 *  @return UIView高度
 */
- (CGFloat)height;

/**
 *  设置UIView高度
 *
 *  @param height UIView高度
 */
- (void)setHeight:(CGFloat)height;

/**
 *  self.y
 *
 *  @return self.y
 */
- (CGFloat)top;

/**
 *  设置self.y
 *
 *  @param top self.y值
 */
- (void)setTop:(CGFloat)top;

/**
 *  self.y+self.height
 *
 *  @return self.y+self.height
 */
- (CGFloat)bottom;

/**
 *  设置bottom
 *
 *  @param bottom bottom值
 */
- (void)setBottom:(CGFloat)bottom;

/**
 *  self.frame.origin.x
 *
 *  @return self.frame.origin.x
 */
- (CGFloat)left;

/**
 *  设置self.frame.origin.x
 *
 *  @param left left值
 */
- (void)setLeft:(CGFloat)left;

/**
 *  self.frame.origin.y
 *
 *  @return self.frame.origin.y
 */
- (CGFloat)right;

/**
 *  设置self.frame.origin.y
 *
 *  @param right right值
 */
- (void)setRight:(CGFloat)right;

/**
 *  当时View加activityIndicatorView
 *
 *  @return UIActivityIndicatorView
 */
- (UIActivityIndicatorView *)activityIndicatorView;

/**
 *  清除背景颜色
 */
- (void)clearBackgroundColor;

/**
 *  设置背景图片
 *
 *  @param image 背景图片
 */
- (void)setBackgroundImage:(UIImage *)image;

/**
 *  设置View层顺序
 *
 *  @param index index顺序
 */
- (void)setIndex:(NSInteger)index;

/**
 *  设置为最顶层View
 */
- (void)bringToFront;

/**
 *  设置为最底层View
 */
- (void)sendToBack;

/**
 *  registEndEditing
 */
- (void)registEndEditing;

/**
 *  设置边框颜色和边框宽度
 *
 *  @param color 边框颜色
 *  @param width 边框宽度
 */
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

/**
 *  设置圆角
 *
 *  @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  设置外阴影
 *
 *  @param color      外阴影颜色
 *  @param opacity    opacity
 *  @param offset     offset
 *  @param blurRadius blurRadius
 */
- (void)setShadowColor:(UIColor *)color
               opacity:(CGFloat)opacity
                offset:(CGSize)offset
            blurRadius:(CGFloat)blurRadius;

/**
 *  viewController
 *
 *  @return viewController
 */
- (UIViewController *)viewController;

/**
 *  推出view
 *
 *  @param view       推出的view
 *  @param completion 完成block
 */
- (void)pushView:(UIView *)view completion:(void (^)(BOOL finished))completion;

/**
 *  popCompletion block
 *
 *  @param completion （popCompletion block）
 */
- (void)popCompletion:(void (^)(BOOL finished))completion;

@end
