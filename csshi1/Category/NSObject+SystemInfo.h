//
//  NSObject+SystemInfo.h
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationObject @"kNotificationObject"

@interface NSObject (SystemInfo)

/**
 *  获取对象属性列表
 *
 *  @return 属性列表数组
 */
- (NSMutableArray *)attributeList;

/**
 *  设备基本信息
 *
 *  @return 设备信息字符串【设备别名:,设备型号:,系统名称:,系统版本号:】
 */
+ (NSString *)currentDeviceInfo;

/**
 *  获取当前版本
 *
 *  @return 当前版本字符串
 */
- (NSString *)version;

/**
 *  设备相关
 *
 *  @return 当前设备的系统版本号
 */
- (float)deviceSystemVersion;

/**
 *  设备相关
 *
 *  @return 当前设备型号
 */
- (NSString *)deviceModel;

/**
 *  设备相关
 *
 *  @return 当前设备名称
 */
- (NSString *)deviceName;

/**
 *  设备相关
 *
 *  @return 当前设备是否为iPad
 */
- (BOOL)deviceIsPad;

/**
 *  设备相关
 *
 *  @return 当前设备是否为iPhone
 */
- (BOOL)deviceIsPhone;

/**
 *  设备相关
 *
 *  @return 当前设备是否为iPod touch
 */
- (BOOL)deviceIsTouch;

/**
 *  设备相关
 *
 *  @return 当前设备是否为视网膜屏
 */
- (BOOL)deviceIsRetina;

/**
 *  设备相关
 *
 *  @return 判断是否为iPhone5
 */
- (BOOL)deviceIsPhone5;

/**
 *  设备相关
 *
 *  @return 判断是否为iPhone 3.5inch
 */
- (BOOL)deviceIsMinPhone_3_5;

/**
 *  网络信息
 *
 *  @return 网络信息字符串
 */
- (NSString *)networkInfo;

/**
 *  md5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5;

/**
 *  当前系统语言
 *
 *  @return 当前系统语言字符串
 */
- (NSString *)appleLanguages;

/**
 *  判断是否为字符串
 *
 *  @return 是否是字符串的布尔值
 */
- (BOOL)isString;

/**
 *  判断是否为NSArray
 *
 *  @return 是否是NSArray的布尔值
 */
- (BOOL)isArray;

/**
 *  判断是否为空的NSArray
 *
 *  @return 是否为空的NSArray
 */
- (BOOL)isEmptyArray;

/**
 *  判断是否为不为空的NSArray
 *
 *  @return 是否为不为空的NSArray
 */
- (BOOL)isNotEmptyArray;

/**
 *  判断是否为NSDictionary
 *
 *  @return 是否为NSDictionary
 */
- (BOOL)isDictionary;

/**
 *  判断是否为不为空的NSDictionary
 *
 *  @return 是否为不为空的NSDictionary
 */
- (BOOL)isNotEmptyDictionary;

/**
 *  注册成为指定消息的观察者
 *
 *  @param name 观察者名称
 */
- (void)observeNotificaiton:(NSString *)name;

/**
 *  注册成为指定消息的观察者(带selector)
 *
 *  @param name     指定观察者名称
 *  @param selector 选择子
 */
- (void)observeNotificaiton:(NSString *)name selector:(SEL)selector;

/**
 *  移除指定观察者名称
 *
 *  @param name 观察者名称
 */
- (void)unobserveNotification:(NSString *)name;

/**
 *  移除所有通知
 */
- (void)unobserveAllNotification;

/**
 *  发送通知
 *
 *  @param name 通知名
 */
- (void)postNotification:(NSString *)name;

/**
 *  发送通知
 *
 *  @param name   通知名
 *  @param object 对象
 */
- (void)postNotification:(NSString *)name object:(id)object;

/**
 *  发送通知
 *
 *  @param name     通知名
 *  @param userInfo userInfo
 */
- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo;

/**
 *  发送通知
 *
 *  @param name     通知名
 *  @param object   对象
 *  @param userInfo userInfo
 */
- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

/**
 *  发送通知
 *
 *  @param name   通知名
 *  @param object object
 */
- (void)postNotification:(NSString *)name withObject:(id)object;

/**
 *  获取字体高度
 *
 *  @param font 字体
 *
 *  @return 返回字体高度
 */
- (CGFloat)getFontHeight:(UIFont *)font;

/**
 *  打开url
 *
 *  @param url url地址
 *
 *  @return 打开成功、失败BOOL值
 */
- (BOOL)openURL:(NSURL *)url;

/**
 *  发送邮件
 *
 *  @param mail 收件人
 */
- (void)sendMail:(NSString *)mail;

/**
 *  发送短信
 *
 *  @param number 电话号码
 */
- (void)sendSMS:(NSString *)number;

/**
 *  打电话
 *
 *  @param number 电话号码
 */
- (void)callNumber:(NSString *)number;

/**
 *  程序目录
 *
 *  @return 程序主目录
 */
- (NSString *)applicationDirectory;

/**
 *  程序Document目录
 *
 *  @return 程序Document目录
 */
- (NSString *)applicationDocumentsDirectory;

/**
 *  保存在本地数据
 *
 *  @param object 值
 *  @param key    键
 */
- (void)setNsuserDefault:(id)object forKey:(NSString*)key;

/**
 *  获取文件路径的图片
 *
 *  @param directory 文件路径
 *  @param hash      子路径
 *
 *  @return UIImage
 */
- (UIImage *)imagePath:(NSString*)directory file:(NSString *)hash;

/**
 *  获取字符串路径
 *
 *  @param directory 路径
 *  @param hash      hash
 *
 *  @return 文件路径
 */
- (NSString *)getFilePath:(NSString*)directory file:(NSString *)hash;

/**
 *  获取磁盘剩余空间
 *
 *  @return 返回剩余空间大小
 */
- (uint64_t)getFreeDiskspace;

/**
 *  获取磁盘总空间
 *
 *  @return 返回文件总空间大小
 */
- (uint64_t)getTotalDiskspace;

/**
 *  获取当前时间戳
 *
 *  @return 当前时间戳
 */
- (long long int)getNowTime;

/**
 *  获取设备DPI
 *
 *  @return 返回设备DPI字符串
 */
- (NSString *)getDevieceDPI;

/**
 *  获取设备宽高比
 *
 *  @return 返回设备宽高比
 */
- (CGFloat)getDevieceW_Hbili;

/**
 *  获取设备屏幕大小
 *
 *  @return 设备屏幕大小
 */
- (CGSize )getDevieceSize;

/**
 *  replaceNullData
 *
 *  @param nullData nullData
 *
 *  @return 字符串
 */
- (NSString *)replaceNullData:(NSString *)nullData;

/**
 *  sha1加密方式
 *
 *  @param srcString 源字符串
 *
 *  @return 加密后的字符串
 */
- (NSString *)getSha1String:(NSString *)srcString;

/**
 *  时间戳转化为时间
 *
 *  @param timestring 要转化的时间戳
 *
 *  @return 返回转化得到的时间 格式为yyyy-MM-dd HH:mm:ss
 */
- (NSString *)timeToTranslate:(NSString *)timestring;

/**
 *  将秒转化为 时分秒
 *
 *  @param time
 *
 *  @return 转换后的字符串
 */
- (NSString *)timeToTranslateToHours:(float )time;

/**
 *  获取当前设备详细型号
 *
 *  @return 详细型号字符串
 */
+ (NSString *)getCurrentDeviceModel;
/**
 *  获取浏览器userAgent;
 */
+ (NSString *)getUserAgent;
/**
 *  获取APPid
 */
+(NSString *)getAppId;
/**
 *  获取identifier
 */
+(NSString *)getIdentifier;
+(NSString *)getShortVersion;
+(NSString *)getSystemName;
+(NSString *)getSystemModel;
+(NSString *)getUDID;

@end
