//
//  NSArray+Extension.m
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSArray *)offsetRangesInArrayBy:(NSUInteger)offset
{
    NSUInteger aOffset = 0;
    NSUInteger prevLength = 0;
    
    NSMutableArray *ranges = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(NSInteger i = 0; i < [self count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[self objectAtIndex:i] rangeValue];
            prevLength    = range.length;
            
            range.location -= aOffset;
            range.length    = offset;
            [ranges addObject:[NSValue valueWithRange:range]];
            
            aOffset = aOffset + prevLength - offset;
        }
    }
    
    return ranges;
}

@end
