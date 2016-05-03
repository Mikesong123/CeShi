//
//  Person.m
//  csshi1
//
//  Created by 高 on 16/3/22.
//  Copyright © 2016年 高. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (id)personWithName:(NSString *)name andAge:(NSInteger)age {
    Person *person = [[Person alloc] init];
    person.name = name;
    person.age = age;
    return person;
}

- (NSString *)description{
    NSString *s = [NSString stringWithFormat:@"name = %@ , age = %ld",_name , (long)_age];
    return s;
}


//NSArray values = @[@"slp", @"nan", @"22", @"simd"];    NSArray keys = @[@"name", @"sex", @"age", @"discription"];    NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:keys];

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//当然，因为可能有时候会多余的json字段你用不到，你可以写如下的方法：
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
