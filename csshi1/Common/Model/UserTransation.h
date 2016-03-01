//
//  UserTransation.h
//  csshi1
//
//  Created by 高 on 15/12/23.
//  Copyright © 2015年 高. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfo;
@interface UserTransation : NSObject
@property (nonatomic, strong) UserInfo *currentUser;
M1905_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(UserTransation)

- (BOOL)auditModle;

- (BOOL)isUserLogin;

- (BOOL)isUserVip;



//推送
- (BOOL)pushSwitch;
- (void)updatePushSwitch:(BOOL)b;
//数据流量
- (BOOL)isNetwork;
- (void)updateNetworkSwitch:(BOOL)b;

//登录检测
- (int)validataUserName:(NSString *)username errorMsg:(NSString **)msg;
- (int)validataPassWord:(NSString *)password errorMsg:(NSString **)msg;
//登录
- (void)loginWithName:(NSString *)username Password:(NSString *)password;

// 注册 检测
- (int)validateRegisterName:(NSString *)username errorMsg:(NSString **)msg;
// 注册密码，修改密码 检测
- (int)validateRegisterPassword:(NSString *)password errorMsg:(NSString **)msg;

//验证码检测
- (int)validateCaptcha:(NSString *)captcha errorMsg:(NSString **)msg;
//手机号码检测
- (int)validateCheckCodePhoneNum:(NSString *)phoneNum errorMsg:(NSString **)msg;
//昵称检测
- (int)validateModiNickName:(NSString *)name errorMsg:(NSString **)msg;

//设置新的userInfo
- (void)setNewUserInfo:(UserInfo *)newUserInfo;

//更新本地存储的userInfo
- (void)updateUserinfo;

//载入本地的用户信息
- (void)loadCurrentUserInfo;

//刷新用户信息(用于自动登录)
- (void)refreshUserInfo;

//通过token获取到最新的用户信息,并刷新本地的用户信息
- (void)refreshUserToken;

//更新登录信息
- (void)updateLoginInfoWithName:(NSString *)name password:(NSString*)password;

//登出
- (void)loginOut;

//// 播放记录相关
//- (BOOL)addPlayRecord:(CSStructData *)record;
//- (int)isPlayRecord:(NSString *)filmid;
//- (BOOL)deletePlayRecords:(NSIndexSet *)indexSet;
//- (NSArray *)playRecord;
//
//// 收藏记录相关
//- (BOOL)addCollectionRecord:(CSStructData *)record;
//- (int)isCollectioinRecord:(NSString *)filmid;
//- (BOOL)deleteCollectionRecords:(NSIndexSet *)indexSet;
//- (NSArray *)collectionRecord;

@end
