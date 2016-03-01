//
//  UIViewController+Navigate.h
//  socialDemo
//
//  Created by 陈欢 on 14-1-2.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigate)

/**
 *  设置导航栏标题
 *
 *  @param font  标题字体
 *  @param color 标题color
 */
- (void)setTitleText:(UIFont *)font
               Color:(UIColor *)color;

/**
 *  设置Title
 *
 *  @param title title字符串
 */
- (void)setTitleTextView:(NSString *)title;

/**
 *  设置导航栏背景图片
 *
 *  @param image 背景图片
 */
- (void)setNavigateBarBackImage:(UIImage *)image;

// 左导航栏使用X图片
- (void)setLeftBarItemWithImageX;

// 左导航栏使用返回图片
- (void)setLeftBarItemWithBackImage;

//设置导航栏左边按钮X形状
- (void)setLeftBarItemImageXWithselector:(SEL)selector;
//设置左边放回按钮
- (void)setLeftBarItemBackImageWithselector:(SEL)selector;

/**
 *  设置左导航栏
 *
 *  @param title    左导航栏title
 *  @param selector 左导航栏选择子
 */
- (void)setLeftBarItemWithTitle:(NSString *)title
                       selector:(SEL)selector;

//右侧导航栏按钮添加
- (void)addRightBarItemWithImage:(NSString *)Image
                  HighlightImage:(NSString *)highImage
                        selector:(SEL)selector;

/**
 *  设置右导航栏
 *
 *  @param title    右导航栏title
 *  @param selector 右导航栏选择子
 */
- (void)setRightBarItemWithTitle:(NSString *)title
                        selector:(SEL)selector;

/**
 *  设置左导航栏
 *
 *  @param Image     左导航栏正常图片
 *  @param highImage 左导航栏高亮图片
 *  @param selector  左导航栏选择子
 */
- (void)setLeftBarItemWithImage:(NSString *)Image
                 HighlightImage:(NSString *)highImage
                       selector:(SEL)selector;

/**
 *  设置右导航栏
 *
 *  @param Image     右导航栏正常图片
 *  @param highImage 右导航栏高亮图片
 *  @param selector  右导航栏选择子
 */
- (void)setRightBarItemWithImage:(NSString *)Image
                  HighlightImage:(NSString *)highImage
                        selector:(SEL)selector;

/**
 *  设置左右导航栏
 *
 *  @param leftImage      左导航栏正常图片
 *  @param rightImage     右导航栏正常图片
 *  @param leftHighImage  左导航栏高亮图片
 *  @param rightHighImage 右导航栏高亮图片
 *  @param leftSelector   左导航选择子
 *  @param rightSelector  右导航选择子
 */
- (void)setRightBarItemWithImage:(NSString *)leftImage
								:(NSString *)rightImage
                  HighlightImage:(NSString *)leftHighImage
								:(NSString *)rightHighImage
                        selector:(SEL)leftSelector
								:(SEL)rightSelector;

/**
 *  移除左导航栏
 */
- (void)removeLeftBarItem;

/**
 *  移除右导航栏
 */
- (void)removeRightBarItem;

/**
 *  push viewController
 *
 *  @param viewController push的viewController
 */
- (void)pushController:(UIViewController *)viewController;

/**
 *  push viewController
 *
 *  @param viewController push的viewController
 *  @param animated       是否动画
 */
- (void)pushController:(UIViewController *)viewController
          withAnimated:(BOOL)animated;

/**
 *  弹出viewController
 */
- (void)popController;

/**
 *  弹出viewController
 *
 *  @param Animated 是否动画
 */
- (void)popControllerWithAnimated:(BOOL)Animated;

/**
 *  presentController
 *
 *  @param viewController present的viewController
 */
- (void)presentController:(UIViewController *)viewController;

/**
 *  dismissModalController
 */
- (void)dismissModalController;

/**
 *  设置左导航栏
 *
 *  @param title    标题
 *  @param image    image
 *  @param imageH   imageH
 *  @param icon     icon
 *  @param iconH    iconH
 *  @param selector 左导航选择子
 */
- (void)setLeftBarItemWithTitle:(NSString *)title
                backgroundImage:(UIImage *)image
               backgroundImageH:(UIImage *)imageH
                           icon:(UIImage *)icon
                          iconH:(UIImage *)iconH
                       selector:(SEL)selector;

@end
