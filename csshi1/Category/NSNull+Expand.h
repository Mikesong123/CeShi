//
//  NSNull+develop_develop_develop_Expand.h
//  FilmSite
//
//  Created by 罗 何 on 14-6-16.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNull (Expand)

- (int)zeroValue;
- (char)charValue;
- (unsigned char)unsignedCharValue;
- (short)shortValue;
- (unsigned short)unsignedShortValue;
- (int)intValue;
- (unsigned int)unsignedIntValue;
- (long)longValue;
- (unsigned long)unsignedLongValue;
- (long long)longLongValue;
- (unsigned long long)unsignedLongLongValue;
- (float)floatValue;
- (double)doubleValue;
- (BOOL)boolValue;
- (NSInteger)integerValue NS_AVAILABLE(10_5, 2_0);
- (NSUInteger)unsignedIntegerValue NS_AVAILABLE(10_5, 2_0);

- (NSString *)stringValue;
- (NSString *)descriptionWithLocale:(id)locale;
- (BOOL)isEqualToString:(NSString* )str;
@end


@interface NSArray (Expand)
- (id)objectAtIndex_conver:(int)index;
@end

@interface NSDictionary (Expand)
- (id)objectForKey_conver:(id)aKey;

@end

@interface NSString (Expand)
- (id)objectAtIndex:(NSUInteger)index;
- (id)objectForKey:(id)aKey;
- (id)objectAtIndex_conver:(NSUInteger)index;
- (id)objectForKey_conver:(id)aKey;
@end
