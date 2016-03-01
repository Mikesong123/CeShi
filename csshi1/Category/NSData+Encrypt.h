//
//  NSData+Encrypt.h
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encrypt)

/**
*  md5加密
*
*  @return 加密后的字符串
*/
- (NSString *)md5;

/**
 *  base64加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)base64Encoded;

/**
 *  base64 解密
 *
 *  @return 解密后的字符串
 */
- (NSData *)base64Decoded;

/**
 *  AES256加密
 *
 *  @param key 密钥
 *
 *  @return 加密的数据
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/**
 *  AES256解密
 *
 *  @param key 密钥
 *
 *  @return 解密后的数据
 */
- (NSData *)AES256DecryptWithKey:(NSString *)key;

/**
 *  追加64编码
 *
 *  @return 加密后的数据
 */
- (NSString *)newStringInBase64FromData;

/**
 *  同上64编码
 *
 *  @param str 加密
 *
 *  @return 编码返回
 */
+ (NSString*)base64encode:(NSString*)str;

@end
