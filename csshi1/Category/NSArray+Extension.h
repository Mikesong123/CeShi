//
//  NSArray+Extension.h
//  Dingding
//
//  Created by 陈欢 on 14-2-27.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

/**
 *  对空数组做偏移不抛异常
 *
 *  @param offset 偏移位置
 *
 *  @return 新数组
 */
- (NSArray *)offsetRangesInArrayBy:(NSUInteger)offset;

@end
