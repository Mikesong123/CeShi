//
//  NSString+ThreeDES.h
//  3DE
//
//  Created by Brandon Zhu on 31/10/2012.
//  Copyright (c) 2012 Brandon Zhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (ThreeDES)
+ (NSString*)encrypt:(NSString*)plainText withKey:(NSString*)key;
+ (NSString*)decrypt:(NSString*)encryptText withKey:(NSString*)key;
- (NSString*) sha1;
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key;
@end
