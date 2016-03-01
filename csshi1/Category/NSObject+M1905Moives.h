//
//  NSObject+M1905Moives.h
//  FilmSiteClient
//
//  Created by XQD on 15/8/12.
//  Copyright (c) 2015年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  剪切图片相关
 */
typedef NS_ENUM(NSUInteger, M1905CutImageMode) {
    /**
     *  原始尺寸
     */
    M1905CutImageModeOrgin = 0,
    /**
     *  先将宽或高等比缩放至目标高宽，再从图片左上角向右下剪裁至指定大小
     */
    M1905CutImageModeWidthOrHeight = 1,
    /**
     *  先进行等比缩放，再从图片中心向外剪裁至指定大小
     */
    M1905CutImageModeCenter = 2
};

/**
 *  图片裁剪之后的质量
 */
typedef NS_ENUM(NSUInteger, M1905CutImageQuality) {
    /**
     *  压缩质量95%（默认）
     */
    M1905CutImageQualityDefault = 0,
    /**
     *  压缩质量60%
     */
    M1905CutImageQuality60Percent = 3,
    /**
     *  压缩质量70%
     */
    M1905CutImageQuality70Percent = 4,
    /**
     *  压缩质量80%
     */
    M1905CutImageQuality80Percent = 5,
    /**
     *  压缩质量90%
     */
    M1905CutImageQuality90Percent = 6
};

/**
 *  角标相关
 */
typedef NS_ENUM(NSInteger, CornerMarkBmonth) {
    /**
     *  Limit
     */
    CornerMarkBmonthLimit = 0,
    /**
     *  付费
     */
    CornerMarkBmonthFilm = 1,
    /**
     *  包月
     */
    CornerMarkBmonthMonthly = 2,
};

/**
 *  CornerMarkType
 */
typedef NS_ENUM(NSInteger, CornerMarkType) {
    /**
     *  预告
     */
    CornerMarkTypeNotice = 1,
    /**
     *  免费
     */
    CornerMarkTypeFree = 2,
    /**
     *  vip
     */
    CornerMarkTypeVip = 7,
};

/**
 *  CornerMarkFreeTime
 */
typedef NS_ENUM(NSInteger, CornerMarkFreeTime) {
    /**
     *  限免
     */
    CornerMarkFreeTimeLimit = 1,
    /**
     *  预售
     */
    CornerMarkFreeTimeAdvance = 2,
};

@interface NSObject (M1905Moives)

/**
 *  图片大小剪裁方法
 *
 *  @param url        原图片地址   （必填）
 *  @param size       需要裁剪的大小（必填）
 *  @param mode       剪裁模式（必填） 可选值：0，1，2
 *  @param quality    压缩质量（可选） 可选值：0，3，4，5，6
 注意：只有在图片格式为jpg/jpeg时该参数才有效果
 *  @param isForceCut 是否强制切割（必填） 可选值：YES，NO
 *
 *  @return 裁剪之后的图片地址
 */
- (NSString *)customImageWithImgUrl:(NSString *)url
                               Size:(CGSize)size
                        contentMode:(M1905CutImageMode)mode
                            quality:(M1905CutImageQuality)quality
                         isForceCut:(BOOL)isForceCut;

/**
 *  设置角标
 *
 *  @param type         类型
 *  @param bmonth       bmonth
 *  @param freetime     freetime
 *  @param advanceVideo advanceVideo
 *
 *  @return UIImage
 */
- (UIImage *)getCornerMarkImageWithType:(NSString *)type
                                 bmonth:(NSString *)bmonth
                               freetime:(NSString *)freetime
                           advanceVideo:(BOOL)advanceVideo;

@end
