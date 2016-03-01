//
//  NSObject+M1905Moives.m
//  FilmSiteClient
//
//  Created by XQD on 15/8/12.
//  Copyright (c) 2015年 陈欢. All rights reserved.
//

#import "NSObject+M1905Moives.h"

@implementation NSObject (M1905Moives)

- (NSString *)customImageWithImgUrl:(NSString *)url Size:(CGSize)size contentMode:(M1905CutImageMode)mode quality:(M1905CutImageQuality)quality isForceCut:(BOOL)isForceCut {
    // 地址长度为0 返回nil
    if (url.length == 0) {
        return nil;
    }
    
    // 图片地址复制给临时变量
    NSString *imgUrl = [url lowercaseString];//小写字母
    
    // 判断是否是图片
    NSError *isImageError = NULL;
    NSRegularExpression *isImageRegex = [NSRegularExpression regularExpressionWithPattern:@"\\.(jpg|png|gif)$" options:NSRegularExpressionCaseInsensitive error:&isImageError];
    NSTextCheckingResult *result = [isImageRegex firstMatchInString:imgUrl options:0 range:NSMakeRange(0, [imgUrl length])];
    if (!result) {   //不是图片地址
        return nil;
    }
    
    // 判断是否是已经切割的图片(是已经切割的图片&&不需要强制切割->返回原始图片地址)
    NSRange range = [imgUrl rangeOfString:@"thumb_" options:NSRegularExpressionSearch];
    if ((range.location != NSNotFound) && isForceCut == NO) {
        return imgUrl;
    }
    
    // 切割尺寸大小的判断
    if ((size.width == 0) || (size.height == 0)) {
        return nil;
    }
    
    // 获取url前半部分
    NSError *beforeUrlError = NULL;
    NSRegularExpression *beforeUrlRegex = [NSRegularExpression regularExpressionWithPattern:@"^.*/" options:NSRegularExpressionCaseInsensitive error:&beforeUrlError];
    NSTextCheckingResult *beforeUrlResult = [beforeUrlRegex firstMatchInString:imgUrl options:0 range:NSMakeRange(0, [imgUrl length])];
    NSString *beforeUrl = [imgUrl substringWithRange:beforeUrlResult.range];
    
    // 获取url后半部分
    NSError *afterUrlError = NULL;
    NSRegularExpression *afterUrlRegex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+\\.(jpg|png|gif)$" options:NSRegularExpressionCaseInsensitive error:&afterUrlError];
    NSTextCheckingResult *afterUrlResult = [afterUrlRegex firstMatchInString:imgUrl options:0 range:NSMakeRange(0, [imgUrl length])];
    NSString *afterUrl = [imgUrl substringWithRange:afterUrlResult.range];
    
    if ((beforeUrl.length == 0) || (afterUrl.length == 0)) {
        return nil;
    }
    
    
    NSString *qualityStr = @"";
    if (M1905CutImageQualityDefault != quality) {
        qualityStr = [NSString stringWithFormat:@"%ld_", (long)quality];
    }
    
    return [NSString stringWithFormat:@"%@thumb_%lu_%ld_%ld_%@%@", beforeUrl, (unsigned long)mode, (long)size.width, (long)size.height, qualityStr, afterUrl];
}

- (UIImage *)getCornerMarkImageWithType:(NSString *)type bmonth:(NSString *)bmonth freetime:(NSString *)freetime advanceVideo:(BOOL)advanceVideo
{
    UIImage * image = nil;
    
    if (freetime.integerValue == CornerMarkFreeTimeLimit) //限免
    {
        image = [UIImage imageNamed:@"Show_Back_TimeLimitFree"];
    }
    else if (freetime.integerValue == CornerMarkFreeTimeAdvance) //预售
    {
        image = [UIImage imageNamed:@"Show_Back_presell"];
    }
    else if (type.integerValue == CornerMarkTypeFree)//免费
    {

    }
    else if (type.integerValue == CornerMarkTypeNotice)//预告
    {
        image = [UIImage imageNamed:@"Show_Back_Trailer"];
        if (!advanceVideo) {
            image = nil;
        }
    }
    else if (type.integerValue == CornerMarkTypeVip)//VIP
    {
        if (bmonth.integerValue == CornerMarkBmonthFilm||bmonth.integerValue == CornerMarkBmonthLimit)//付费
        {
            image = [UIImage imageNamed:@"Show_Back_Pay"];
        }
        else//VIP
        {
            image = [UIImage imageNamed:@"Show_Back_vip"];
        }
    } else {

    }
    
    return image;
}
@end
