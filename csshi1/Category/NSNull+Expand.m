//
//  NSNull+develop_develop_develop_Expand.m
//  FilmSite
//
//  Created by 罗 何 on 14-6-16.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSNull+Expand.h"

@implementation NSNull (Expand)

- (int)zeroValue{return 0;}
- (char)charValue{return [self zeroValue];}
- (unsigned char)unsignedCharValue{return [self zeroValue];}
- (short)shortValue{return [self zeroValue];}
- (unsigned short)unsignedShortValue{return [self zeroValue];}
- (int)intValue{return [self zeroValue];}
- (unsigned int)unsignedIntValue{return [self zeroValue];}
- (long)longValue{return [self zeroValue];}
- (unsigned long)unsignedLongValue{return [self zeroValue];}
- (long long)longLongValue{return [self zeroValue];}
- (unsigned long long)unsignedLongLongValue{return [self zeroValue];}
- (float)floatValue{return [self zeroValue];}
- (double)doubleValue{return [self zeroValue];}
- (BOOL)boolValue{return [self zeroValue];}
- (NSInteger)integerValue{return [self zeroValue];}
- (NSUInteger)unsignedIntegerValue{return [self zeroValue];}

- (NSString *)stringValue{return @"";}
- (NSString *)descriptionWithLocale:(id)locale{return @"";}
- (NSString *)description{return @"";}
- (BOOL)isEqualToString:(NSString* )str{return NO;}

@end

@implementation NSDictionary (Expand)

- (id)objectForKey_conver:(id)aKey{
    id obj = [self objectForKey:aKey];
    if([[obj class] isSubclassOfClass:[NSNull class]]) return nil;
    if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        NSDictionary *temp = (NSDictionary *)obj;
        if(temp.count < 1)return nil;
        else return obj;
    }
    if([[obj class] isSubclassOfClass:[NSArray class]]) {
        NSArray *temp = (NSArray *)obj;
        if(temp.count < 1) return nil;
        else return obj;
    }
    return obj ;
}
@end

@implementation NSArray (Expand)

- (id)objectAtIndex_conver:(int)index
{
    if(index + 1 > self.count || index < 0) return nil;
    id obj = [self objectAtIndex:index];
    if([[obj class] isSubclassOfClass:[NSNull class]]) return nil;
    if([[obj class] isSubclassOfClass:[NSDictionary class]]){
        NSDictionary *temp = (NSDictionary *)obj;
        if(temp.count < 1)return nil;
        else return obj;
    }
    if([[obj class] isSubclassOfClass:[NSArray class]]) {
        NSArray *temp = (NSArray *)obj;
        if(temp.count < 1) return nil;
        else return obj;
    }
    return obj ;
}

@end

@implementation NSString (Expand)
- (id)objectAtIndex:(NSUInteger)index{
    return nil;
}
- (id)objectForKey:(id)aKey{
    return nil;
}
- (id)objectAtIndex_conver:(NSUInteger)index{
    return nil;
}
- (id)objectForKey_conver:(id)aKey{
    return nil;
}

@end
