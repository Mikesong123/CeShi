//
//  UIImage+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  创建圆形图
 *
 *  @param image 原图
 *  @param inset 缩进
 *
 *  @return 圆形图
 */
+ (UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset;

/**
 *  创建圆形图
 *
 *  @param image     原图
 *  @param inset     inset
 *  @param imageSize 图片size
 *
 *  @return 圆形图
 */
+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize;

/**
 *  利用色值生成圆形图
 *
 *  @param radius 圆形图半径
 *  @param color  色值
 *
 *  @return 圆形图
 */
+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color;

/**
 *  圆角图
 *
 *  @param image     原图
 *  @param corner    corner大小
 *  @param imageSize size
 *
 *  @return 圆角图
 */
+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize;

/**
 *  方形图
 *
 *  @param width  宽度
 *  @param height 高度
 *  @param color  色值
 *
 *  @return 方形图
 */
+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color;

/**
 *  生成方形图
 *
 *  @param color 色值
 *  @param size  size
 *
 *  @return 方形图
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  切割图片
 *
 *  @param image 原图
 *  @param size  切割size
 *
 *  @return 切割后的图片
 */
+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size;

/**
 *  切割图片(和上面的切割方式不同)
 *
 *  @param image 原图
 *  @param size  切割size
 *
 *  @return 切割后的图片
 */
+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size;

/**
 *  切割图片(和上面的切割方式不同)
 *
 *  @param image 原图
 *  @param size  切割size
 *
 *  @return 切割后的图片
 */
+ (UIImage *)cutVerticalImage:(UIImage *)image size:(CGSize)size;

/**
 *  动态切割图片
 *
 *  @param originalImage 原图
 *  @param size          切割size
 *
 *  @return 切割后的图片
 */
+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;

/**
 *  压缩图片（指定压缩质量）
 *
 *  @param compressionQuality 压缩质量
 *
 *  @return 压缩后的NSData
 */
- (NSData *)compressedData:(CGFloat)compressionQuality;

/**
 *  压缩质量
 *
 *  @return 压缩质量
 */
- (CGFloat)compressionQuality;

/**
 *  压缩图片（默认）
 *
 *  @return 压缩后的NSData
 */
- (NSData *)compressedData;
/**
 *  重新设置图片大小
 *  @return设置设置后图片
 */
+ (UIImage *)resizeImage:(NSString *)imageName;

+ (UIImage *)placeHolderImageWithSize:(CGSize)imageSize
                            Alignment:(BOOL)bVertical;

@end
