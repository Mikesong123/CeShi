//
//  Person.h
//  csshi1
//
//  Created by 高 on 16/3/22.
//  Copyright © 2016年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic ,copy)NSString *name;//copy ,strong区别，copy不会改变原值，strong会改变
@property (nonatomic ,assign)NSInteger age;

@property (nonatomic ,strong)NSString *classname;
@property (nonatomic ,strong)NSString *title;

+ (id)personWithName:(NSString *)name andAge:(NSInteger)age;

@end
