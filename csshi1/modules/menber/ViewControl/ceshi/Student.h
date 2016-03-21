//
//  Student.h
//  csshi1
//
//  Created by 高 on 16/2/17.
//  Copyright © 2016年 高. All rights reserved.
//

#import <Foundation/Foundation.h>
//，NSUserDefaults 本身不支持自定义对象的存储，不过它支持NSData的类型
@interface Student : NSObject<NSCoding,MKAnnotation>
//<NSCoding>
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *studentnum;
@property(nonatomic,retain)NSString *sex;
@property(nonatomic,assign)NSInteger  age;
//
/**
 *  大头针的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/**
 *  大头针标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  大头针的子标题
 */
@property (nonatomic, copy) NSString *subtitle;

@end
