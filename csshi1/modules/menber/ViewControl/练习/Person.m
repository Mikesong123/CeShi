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

@end
