//
//  UserInfo.h
//  Dingding
//
//  Created by 陈欢 on 14-3-5.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNull+Expand.h"

@interface UserInfo : NSObject <NSCoding>

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *cancelorder;
@property (nonatomic, strong) NSString *commentcount;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *m1905_vip;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *neworder;
@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *paidorder;
@property (nonatomic, strong) NSString *refundorder;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *sp;
@property (nonatomic, strong) NSString *successorder;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *usercode;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *vip_end_time;
@property (nonatomic, strong) NSString *vip_start_time;

@property (nonatomic, assign) NSTimeInterval timeStamp;

+ (UserInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
