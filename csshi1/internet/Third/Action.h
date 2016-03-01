//
//  Action.h
//  csshi1
//
//  Created by 高 on 15/12/22.
//  Copyright © 2015年 高. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "net.h"
#import "AFNetworking.h"
#import "Request.h"
//#import "ActionDelegate.h"
@protocol ActionDelegate <NSObject>
-(void)handleActionMsg:(Request *)msg;
@optional
-(void)handleProgressMsg:(Request *)msg;
@end

@interface Action : NSObject
@property(nonatomic,weak)id<ActionDelegate> aDelegaete;
+(void)actionConfigHost:(NSString *)host client:(NSString *)client codeKey:(NSString *)codeKey rightCode:(NSInteger)rightCode msgKey:(NSString *)msgKey dataKey:(NSString *)dataKey;
+ (id)Action;
- (id)initWithCache;
- (void)success:(Request *)msg;
- (void)error:(Request *)msg;
- (void)failed:(Request *)msg;
- (void)useCache;
- (void)readFromCache;
- (void)notReadFromCache;
- (AFHTTPRequestOperation *)Send:(Request *) msg;
- (AFHTTPRequestOperation *)Download:(Request *)msg;
M1905_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(Action)
@end
