//
//  Student.m
//  csshi1
//
//  Created by 高 on 16/2/17.
//  Copyright © 2016年 高. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.studentnum forKey:@"num"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.studentnum = [aDecoder decodeObjectForKey:@"num"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}


@end
