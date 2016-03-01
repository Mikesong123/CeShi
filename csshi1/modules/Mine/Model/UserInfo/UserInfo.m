//
//  UserInfo.m
//  Dingding
//
//  Created by 陈欢 on 14-3-5.
//  Copyright (c) 2014年 陈欢. All rights reserved.
//

#import "UserInfo.h"

NSString *const kUserInfoAvatar = @"avatar";
NSString *const kUserInfoCancelorder = @"cancelorder";
NSString *const kUserInfoCommentcount = @"commentcount";
NSString *const kUserInfoEmail = @"email";
NSString *const kUserInfoM1905_vip = @"m1905_vip";
NSString *const kUserInfoMobile = @"mobile";
NSString *const kUserInfoNeworder = @"neworder";
NSString *const kUserInfoNickname = @"nickname";
NSString *const kUserInfoPaidorder = @"paidorder";

NSString *const kUserInfoRefundorder = @"refundorder";
NSString *const kUserInfoSite = @"site";
NSString *const kUserInfoSp = @"sp";
NSString *const kUserInfoSuccessorder = @"successorder";
NSString *const kUserInfoToken = @"token";
NSString *const kUserInfoUsercode = @"usercode";
NSString *const kUserInfoUsername = @"username";
NSString *const kUserInfoVip_end_time = @"vip_end_time";
NSString *const kUserInfoVip_start_time = @"vip_start_time";

NSString *const kUserInfoTimeStamp = @"kUserInfoStamp";

@interface UserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfo

+ (UserInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    UserInfo *instance = [[UserInfo alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.avatar = [self objectOrNilForKey:kUserInfoAvatar fromDictionary:dict];
        self.cancelorder = [self objectOrNilForKey:kUserInfoCancelorder fromDictionary:dict];
        self.commentcount = [self objectOrNilForKey:kUserInfoCommentcount fromDictionary:dict];
        self.email = [self objectOrNilForKey:kUserInfoEmail fromDictionary:dict];
        self.m1905_vip = [self objectOrNilForKey:kUserInfoM1905_vip fromDictionary:dict];
        self.mobile = [self objectOrNilForKey:kUserInfoMobile fromDictionary:dict];
        self.neworder = [self objectOrNilForKey:kUserInfoNeworder fromDictionary:dict];
        self.nickname = [self objectOrNilForKey:kUserInfoNickname fromDictionary:dict];
        self.paidorder = [self objectOrNilForKey:kUserInfoPaidorder fromDictionary:dict];
        
        self.refundorder = [self objectOrNilForKey:kUserInfoRefundorder fromDictionary:dict];
        self.site = [self objectOrNilForKey:kUserInfoSite fromDictionary:dict];
        self.sp = [self objectOrNilForKey:kUserInfoSp fromDictionary:dict];
        self.successorder = [self objectOrNilForKey:kUserInfoSuccessorder fromDictionary:dict];
        self.token = [self objectOrNilForKey:kUserInfoToken fromDictionary:dict];
        self.usercode = [self objectOrNilForKey:kUserInfoUsercode fromDictionary:dict];
        self.username = [self objectOrNilForKey:kUserInfoUsername fromDictionary:dict];
        self.vip_end_time = [self objectOrNilForKey:kUserInfoVip_end_time fromDictionary:dict];
        self.vip_start_time = [self objectOrNilForKey:kUserInfoVip_start_time fromDictionary:dict];
        
        self.timeStamp = [[NSDate date] timeIntervalSince1970];;
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.avatar forKey:kUserInfoAvatar];
    [mutableDict setValue:self.cancelorder forKey:kUserInfoCancelorder];
    [mutableDict setValue:self.commentcount forKey:kUserInfoCommentcount];
    [mutableDict setValue:self.email forKey:kUserInfoEmail];
    [mutableDict setValue:self.m1905_vip forKey:kUserInfoM1905_vip];
    [mutableDict setValue:self.mobile forKey:kUserInfoMobile];
    [mutableDict setValue:self.neworder forKey:kUserInfoNeworder];
    [mutableDict setValue:self.nickname forKey:kUserInfoNickname];
    [mutableDict setValue:self.paidorder forKey:kUserInfoPaidorder];

    [mutableDict setValue:self.refundorder forKey:kUserInfoRefundorder];
    [mutableDict setValue:self.site forKey:kUserInfoSite];
    [mutableDict setValue:self.sp forKey:kUserInfoSp];
    [mutableDict setValue:self.successorder forKey:kUserInfoSuccessorder];
    [mutableDict setValue:self.token forKey:kUserInfoToken];
    [mutableDict setValue:self.usercode forKey:kUserInfoUsercode];
    [mutableDict setValue:self.username forKey:kUserInfoUsername];
    [mutableDict setValue:self.vip_end_time forKey:kUserInfoVip_end_time];
    [mutableDict setValue:self.vip_start_time forKey:kUserInfoVip_start_time];
    
    [mutableDict setValue:@(self.timeStamp) forKey:kUserInfoTimeStamp];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.avatar         = [aDecoder decodeObjectForKey:kUserInfoAvatar];
    self.cancelorder    = [aDecoder decodeObjectForKey:kUserInfoCancelorder];
    self.commentcount   = [aDecoder decodeObjectForKey:kUserInfoCommentcount];
    self.email          = [aDecoder decodeObjectForKey:kUserInfoEmail];
    self.m1905_vip      = [aDecoder decodeObjectForKey:kUserInfoM1905_vip];
    self.mobile         = [aDecoder decodeObjectForKey:kUserInfoMobile];
    self.neworder       = [aDecoder decodeObjectForKey:kUserInfoNeworder];
    self.nickname       = [aDecoder decodeObjectForKey:kUserInfoNickname];
    self.paidorder      = [aDecoder decodeObjectForKey:kUserInfoPaidorder];
    self.refundorder    = [aDecoder decodeObjectForKey:kUserInfoRefundorder];
    
    self.site           = [aDecoder decodeObjectForKey:kUserInfoSite];
    self.sp             = [aDecoder decodeObjectForKey:kUserInfoSp];
    self.successorder   = [aDecoder decodeObjectForKey:kUserInfoSuccessorder];
    self.token          = [aDecoder decodeObjectForKey:kUserInfoToken];
    self.usercode       = [aDecoder decodeObjectForKey:kUserInfoUsercode];
    self.username       = [aDecoder decodeObjectForKey:kUserInfoUsername];
    self.vip_end_time = [aDecoder decodeObjectForKey:kUserInfoVip_end_time];
    self.vip_start_time = [aDecoder decodeObjectForKey:kUserInfoVip_start_time];
    
    self.timeStamp = [[aDecoder decodeObjectForKey:kUserInfoTimeStamp] doubleValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_avatar forKey:kUserInfoAvatar];
    [aCoder encodeObject:_cancelorder forKey:kUserInfoCancelorder];
    [aCoder encodeObject:_commentcount forKey:kUserInfoCommentcount];
    [aCoder encodeObject:_email forKey:kUserInfoEmail];
    [aCoder encodeObject:_m1905_vip forKey:kUserInfoM1905_vip];
    [aCoder encodeObject:_mobile forKey:kUserInfoMobile];
    [aCoder encodeObject:_neworder forKey:kUserInfoNeworder];
    [aCoder encodeObject:_nickname forKey:kUserInfoNickname];
    [aCoder encodeObject:_paidorder forKey:kUserInfoPaidorder];
    [aCoder encodeObject:_refundorder forKey:kUserInfoRefundorder];
    [aCoder encodeObject:_site forKey:kUserInfoSite];
    [aCoder encodeObject:_sp forKey:kUserInfoSp];
    [aCoder encodeObject:_successorder forKey:kUserInfoSuccessorder];
    [aCoder encodeObject:_token forKey:kUserInfoToken];
    [aCoder encodeObject:_usercode forKey:kUserInfoUsercode];
    [aCoder encodeObject:_username forKey:kUserInfoUsername];
    [aCoder encodeObject:_vip_end_time forKey:kUserInfoVip_end_time];
    [aCoder encodeObject:_vip_start_time forKey:kUserInfoVip_start_time];
    [aCoder encodeObject:@(_timeStamp) forKey:kUserInfoTimeStamp];
}

@end
