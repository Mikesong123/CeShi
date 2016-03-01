//
//  UIImage+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-3-3.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UIImage+Extension.h"
#import <Accelerate/Accelerate.h>

#define kCompresseionDataLength (500000.0f) //最大压缩大小(50k)
#define FILMTILE_IMAGE_BACKGROUND_COLOR [UIColor colorWithRed:40.f/255.f green:40.f/255.f blue:40.f/255.f alpha:1]

static CGFloat const kNetTipViewPlaceHolderRatioHorizon = 0.33f;
static CGFloat const kNetTipViewPlaceHolderRatioVertical = 0.46f;

@implementation UIImage (Extension)

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, inset);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255.f green:255.f blue:255.f alpha:.6].CGColor);
	CGRect rect = CGRectMake(inset, inset, imageSize.width - inset * 2.0f, imageSize.height - inset * 2.0f);
	CGContextAddEllipseInRect(context, rect);
	CGContextClip(context);
	
	[image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
	CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)cornerImage:(UIImage*)image withParam:(CGFloat)corner withSize:(CGSize)imageSize
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect rect = CGRectMake(0,
                             0,
                             imageSize.width,
                             imageSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(corner,
                                                                            corner)];
	CGContextAddPath(context, [path CGPath]);
	CGContextClip(context);
	
	[image drawInRect:rect];

    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage*)circleImageWithRadius:(CGFloat)radius Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(radius, radius);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddEllipseInRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage*)verticalBarWithWidth:(CGFloat)width Height:(CGFloat)height Color:(UIColor *)color
{
    //在retian屏幕上要使用这个函数，才能保证不失真
    CGSize imageSize = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
	CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddRect(context, rect);
	CGContextFillPath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
+ (UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = (originSize.width - imageSize.width)/2;
    frame.origin.y = (originSize.height - imageSize.height)/2;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    if(originSize.width < imageSize.width)
    {
        originSize.height *= imageSize.width/originSize.width;
        originSize.width = imageSize.width;
    }
    if(originSize.height < imageSize.height){
        originSize.width *= imageSize.height/originSize.height;
        originSize.height = imageSize.height;
    }
    
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

/**
 *  竖切图片
 *
 *  @param image    图片
 *  @param size     需要调整的大小
 *
 *  @return
 */
+ (UIImage *)cutVerticalImage:(UIImage *)image size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize originSize = CGSizeMake(image.size.width, image.size.height);
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    CGRect frame;
    
    
    if (originSize.width/originSize.height <= imageSize.width/imageSize.height)
    {
        originSize.width *= imageSize.width/originSize.width;
        originSize.height *= imageSize.width/originSize.width;

        frame.origin.y = (originSize.height - imageSize.height)/2;
        frame.origin.x = 0;
    }
    else
    {

        originSize.width *= imageSize.height/originSize.height;
        originSize.height *= imageSize.height/originSize.height;

        
        frame.origin.x = (originSize.width - imageSize.width)/2;
        frame.origin.y = 0;
    }
    
    



     
    UIGraphicsBeginImageContext(originSize);
    
    [image drawInRect:CGRectMake(0, 0, originSize.width, originSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    frame.size = imageSize;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(scaledImage.CGImage, frame);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, frame, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[smallImage size].width,[smallImage size].height);
    
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    

    return smallImage;
}

+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize imageSize = CGSizeMake(size.width * scale, size.height * scale);
    
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width < imageSize.width && originalsize.height < imageSize.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width > imageSize.width && originalsize.height > imageSize.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/imageSize.width;
        CGFloat heightRate = originalsize.height/imageSize.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-imageSize.height*rate/2, originalsize.width, imageSize.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-imageSize.width*rate/2, 0, imageSize.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(imageSize);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, imageSize.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, imageSize.width, imageSize.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height > imageSize.height || originalsize.width > imageSize.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height > imageSize.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-imageSize.height/2, originalsize.width, imageSize.height));//获取图片整体部分
        }
        else if (originalsize.width>imageSize.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-imageSize.width/2, 0, imageSize.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(imageSize);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, imageSize.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, imageSize.width, imageSize.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}

- (NSData *)compressedData:(CGFloat)compressionQuality
{
    if (compressionQuality<=1.0 && compressionQuality >=0)
    {
        return UIImageJPEGRepresentation(self, compressionQuality);
    }
    else
    {
        return UIImageJPEGRepresentation(self, 1.f);
    }
}

- (CGFloat)compressionQuality
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    NSUInteger dataLength = [data length];
    if(dataLength>kCompresseionDataLength)
    {
        return 1.0-kCompresseionDataLength/dataLength;
    }
    else
    {
        return 1.0;
    }
}

- (NSData *)compressedData {
    CGFloat quality = [self compressionQuality];
    return [self compressedData:quality];
}
+ (UIImage *)resizeImage:(NSString *)imageName
{
//    UIImage *image = [UIImage imageNamed:imageName];
//    CGFloat imageW = image.size.width * 0.5;
//    CGFloat imageH = image.size.height * 0.5;
//    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeStretch];
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = 10;
    CGFloat imageH = 10;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
}

+ (UIImage *)placeHolderImageWithSize:(CGSize)imageSize
                            Alignment:(BOOL)bVertical
{
    UIImage *placeHolderImage = [UIImage imageNamed:@"logo_video"];
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, imageSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetFillColorWithColor(context, FILMTILE_IMAGE_BACKGROUND_COLOR.CGColor);
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGContextAddRect(context, rect);
    CGContextFillPath(context);
    
    CGSize placeImageSize = placeHolderImage.size;
    CGFloat scaleRatio = 1.f;
    if (NO == bVertical)
    {
        CGFloat drawWidth = imageSize.width * kNetTipViewPlaceHolderRatioHorizon;
        scaleRatio = drawWidth / placeImageSize.width;
    }
    else
    {
        CGFloat drawWidth = imageSize.width * kNetTipViewPlaceHolderRatioVertical;
        scaleRatio = drawWidth / placeImageSize.width;
    }
    placeImageSize = CGSizeMake(placeImageSize.width *
                                scaleRatio,
                                placeImageSize.height *
                                scaleRatio);
    CGRect drawSize = CGRectMake((imageSize.width -
                                  placeImageSize.width) / 2,
                                 (imageSize.height -
                                  placeImageSize.height) /2,
                                 placeImageSize.width,
                                 placeImageSize.height);
    CGContextDrawImage(context, drawSize, placeHolderImage.CGImage);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

@end
