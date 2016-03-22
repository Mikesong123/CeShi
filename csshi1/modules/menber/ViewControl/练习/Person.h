//
//  Person.h
//  csshi1
//
//  Created by 高 on 16/3/22.
//  Copyright © 2016年 高. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,assign)NSInteger age;

@property (nonatomic ,strong)NSString *classname;
@property (nonatomic ,strong)NSString *title;

+ (id)personWithName:(NSString *)name andAge:(NSInteger)age;

@end
