//
//  Action.m
//  csshi1
//
//  Created by 高 on 15/12/22.
//  Copyright © 2015年 高. All rights reserved.
//

#import "Action.h"
#import "Request.h"
#import "TMCache.h"

@interface Action()
@property(nonatomic,assign)BOOL cacheEnable;
@property(nonatomic,assign)BOOL dataFromCache;

@property(nonatomic,retain)NSString *HOST_URL;//服务端域名:端口
@property(nonatomic,retain)NSString *CLIENT;//自定义客户端识别
@property(nonatomic,retain)NSString *CODE_KEY;//错误码key,支持路径 如 data/code
@property(nonatomic,assign)NSUInteger RIGHT_CODE;//正确校验码
@property(nonatomic,retain)NSString *MSG_KEY;//消息提示msg,支持路径 如 data/msg
@property(nonatomic,retain)NSString *DATA_KEY;//数据的key,支持路径 如 data

@end

@implementation Action
M1905_SYNTHESIZE_SINGLETON_FOR_CLASS(Action)
+ (void)actionConfigHost:(NSString *)host client:(NSString *)client codeKey:(NSString *)codeKey rightCode:(NSInteger)rightCode msgKey:(NSString *)msgKey dataKey:(NSString *)dataKey
{
    [Action sharedInstance].HOST_URL = host;
    [Action sharedInstance].CLIENT = client;
    [Action sharedInstance].CODE_KEY = codeKey;
    [Action sharedInstance].RIGHT_CODE = rightCode;
    [Action sharedInstance].MSG_KEY = msgKey;
    [Action sharedInstance].DATA_KEY = dataKey;
}

//
+(id)Action{
    return [[[self class] alloc] init];
}
- (id)init
{
    self = [super init];
    if(self){
        _cacheEnable = NO;
        _dataFromCache = NO;
    }
    return self;
}

- (id)initWithCache
{
    self = [self init];
    _cacheEnable = YES;
    return self;
}
//缺少实例化
-(void)useCache{
    _cacheEnable = YES;
}

-(void)readFromCache{
    _dataFromCache = YES;
}
-(void)notReadFromCache{
    _dataFromCache = NO;
}
//下载
- (AFHTTPRequestOperation *)Download:(Request *)msg
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:msg.downloadUrl]];
    if(msg.timeoutInterval!= 0){
        manager.requestSerializer.timeoutInterval = msg.timeoutInterval;
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:msg.downloadUrl]];
    [self sending:msg];
    @weakify(msg,self);
    AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        @strongify(msg,self);
        msg.output = [NSDictionary dictionary];
        [self success:msg];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        @strongify(msg,self);
        msg.error = error;
        [self failed:msg];
    }];
    op.outputStream = [NSOutputStream outputStreamToFileAtPath:msg.targetPath append:NO];
    [op setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        @strongify(msg,self);
        msg.totalBytesRead = totalBytesRead;
        msg.totalBytesExpectedToRead = totalBytesExpectedToRead;
        msg.progress = (CGFloat)totalBytesRead/(CGFloat)totalBytesExpectedToRead;
        [self progressing:msg];
    }];
    msg.url = op.request.URL;
    msg.op = op;
    [op start];
    return op;
}
-(AFHTTPRequestOperation *)Send:(Request *)msg{
    if([msg.METHOD isEqualToString:@"GET"] || [msg.METHOD isEqualToString:@"ENCGET"]){
        return [self GET:msg];
    }else{
        return [self POST:msg];
    }
}
- (AFHTTPRequestOperation *)GET:(Request *)msg
{
    NSString *url = @"";
    NSMutableDictionary *requestParams = nil;
    if (msg.STATICPATH.isNotEmpty) {
        url = msg.STATICPATH;
    }else{
        if (msg.SCHEME.isNotEmpty && msg.HOST.isNotEmpty) {
            url = [NSString stringWithFormat:@"%@://%@%@",msg.SCHEME,msg.HOST,msg.PATH];
        }else{
            url = [NSString stringWithFormat:@"http://%@%@",[Action sharedInstance].HOST_URL,msg.PATH];
        }
        if (msg.appendPathInfo.isNotEmpty) {
            url= [url stringByAppendingString:msg.appendPathInfo];
        }else{
            if ([msg.METHOD isEqualToString:@"ENCGET"]) {
                requestParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:[msg.requestParams objectForKey:@"request"],@"request", nil];
            }else{
                requestParams = [NSMutableDictionary dictionaryWithDictionary:msg.requestParams];
                [requestParams removeObjectForKey:@"request"];
                if ([[requestParams allKeys]containsObject:@"internalBaseClassIdentifier"]) {
                    [requestParams setObject:[requestParams objectForKey:@"internalBaseClassIdentifier"] forKey:@"id"];
                    [requestParams removeObjectForKey:@"internalBaseClassIdentifier"];
                }
            }
        }
    }
    [self sending:msg];
    //
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (msg.httpHeaderFields.isNotEmpty) {
        NSLog(@"%@",msg.httpHeaderFields);
        [msg.httpHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    if (msg.timeoutInterval != 0) {
        manager.requestSerializer.timeoutInterval = msg.timeoutInterval;
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (msg.acceptableContentTypes.isNotEmpty) {
        manager.responseSerializer.acceptableContentTypes = msg.acceptableContentTypes;
    }
    @weakify(msg,self)
    AFHTTPRequestOperation *op = [manager GET:url parameters:requestParams success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        @strongify(msg,self);
        id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingAllowFragments error:nil];
        //
        if (NO == [jsonDic isNotEmptyDictionary]) {
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseObject = [NSString TripleDES:responseString encryptOrDecrypt:kCCDecrypt key:SERVER_DES_KEY];
            NSError *deserror = nil;
            NSData *desResponseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            jsonDic = [NSJSONSerialization JSONObjectWithData:desResponseData
                                                      options:NSJSONReadingAllowFragments
                                                        error:&deserror];
        }
        if (_cacheEnable && [self doCheckCode:msg]) {
            [[TMCache sharedCache] setObject:jsonDic forKey:msg.cacheKey block:^(TMCache *cache, NSString *key, id object) {
                NSLog(@"%@ has cache",url);
            }];
        }
        msg.output = jsonDic;
        [self checkCode:msg];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        @strongify(msg,self);
        msg.error = error;
        [self failed:msg];
    }];
    msg.url = op.request.URL;
    msg.op = op;
    msg.output = [[TMCache sharedCache] objectForKey:msg.cacheKey];
    if (_dataFromCache == YES && msg.output != nil) {
        [[GCDQueue mainQueue]queueBlock:^{
            [self checkCode:msg];
        } afterDelay:0.1f];
    }
    return op;
}
- (AFHTTPRequestOperation *)POST:(Request *)msg
{
    NSString *url = @"";
    NSMutableDictionary *requestParams = nil;
    if(msg.STATICPATH.isNotEmpty){
        url = msg.STATICPATH;
    }else{
        if(msg.SCHEME.isNotEmpty && msg.HOST.isNotEmpty){
            url = [NSString stringWithFormat:@"%@://%@%@",msg.SCHEME,msg.HOST,msg.PATH];
        }else{
            url = [NSString stringWithFormat:@"http://%@%@",[Action sharedInstance].HOST_URL,msg.PATH];
        }
        if(msg.appendPathInfo.isNotEmpty){
            url = [url stringByAppendingString:msg.appendPathInfo];
        }else{
            requestParams = [NSMutableDictionary dictionaryWithDictionary:msg.requestParams];
            if ([[requestParams allKeys] containsObject:@"internalBaseClassIdentifier"]) {
                [requestParams setObject:[requestParams objectForKey:@"internalBaseClassIdentifier"] forKey:@"id"];
                [requestParams removeObjectForKey:@"internalBaseClassIdentifier"];
            }
        }
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if(msg.httpHeaderFields.isNotEmpty){
        [msg.httpHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }];
    }
    if (msg.timeoutInterval != 0) {
        manager.requestSerializer.timeoutInterval = msg.timeoutInterval;
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (msg.acceptableContentTypes.isNotEmpty) {
        manager.responseSerializer.acceptableContentTypes = msg.acceptableContentTypes;
    }
    [self sending:msg];
    @weakify(msg,self);
    
    NSDictionary *file = msg.requestFiles;
    AFHTTPRequestOperation *op = [manager POST:url parameters:requestParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [file enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURL class]]) {
                [formData appendPartWithFileURL:obj name:key error:nil];
            }else if ([obj isKindOfClass:[NSData class]]){
                [formData appendPartWithFormData:obj name:key];
            }else if ([obj isKindOfClass:[NSString class]]){
                [formData appendPartWithFileURL:[NSURL URLWithString:obj] name:key error:nil];
            }
        }];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        @strongify(msg,self);
        NSError *error = nil;
        id jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error];
        
        // 若是未能转换为json数据，则先尝试一次解密
        if (NO == [jsonDic isNotEmptyDictionary])
        {
            NSString *responseString =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            responseString = [NSString TripleDES:responseString encryptOrDecrypt:kCCDecrypt key:@"iufles8787rewjk1qkq9dj76"];
            NSError *desError = nil;
            NSData *desResponseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            jsonDic = [NSJSONSerialization JSONObjectWithData:desResponseData
                                                      options:NSJSONReadingAllowFragments
                                                        error:&desError];
        }
        if([file count] == 0 && _cacheEnable && [self doCheckCode:msg]){
            [[TMCache sharedCache] setObject:jsonDic forKey:msg.cacheKey block:^(TMCache *cache, NSString *key, id object) {
                NSLog(@"%@ has cached",url);
            }];
        }
        msg.output = jsonDic;
        [self checkCode:msg];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        @strongify(msg,self);
        msg.error = error;
        [self failed:msg];
    }];
    msg.url = op.request.URL;
    msg.op = op;
    if (file.count>0) {
        [op setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            @strongify(msg,self);
            msg.totalBytesWritten = totalBytesWritten;
            msg.totalBytesExpectedToWrite = totalBytesExpectedToWrite;
            msg.progress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
            [self progressing:msg];
        }];
    }else{
        msg.output = [[TMCache sharedCache] objectForKey:msg.cacheKey];
        if (_dataFromCache == YES && msg.output != nil) {
            [[GCDQueue mainQueue] queueBlock:^{
                [self checkCode:msg];
            } afterDelay:0.1f];
        }
    }
    return op;
}
//
- (void)processResponseCode:(Request *)msg
{
    msg.codeKey = [NSString fromInteger:NET_RES_SUCCESS];
    if ([msg.output isNotEmptyDictionary]) {
        NSNumber *statecode = [msg.output objectAtPath:[Action sharedInstance].CODE_KEY];
        if (nil != statecode) {
            msg.codeKey = [NSString fromInteger:[statecode integerValue]];
        }
    }
}
- (void)checkCode:(Request *)msg
{
    [self processResponseCode:msg];
    if ([self doCheckCode:msg]) {
        [self success:msg];
    }else{
        [self error:msg];
    }
}

- (BOOL)doCheckCode:(Request *)msg{
    if (msg.needCheckCode) {
        msg.codeKey = [msg.output objectAtPath:[Action sharedInstance].CODE_KEY];
        if ([msg.output objectAtPath:[Action sharedInstance].CODE_KEY] && [[msg.output objectAtPath:[Action sharedInstance].CODE_KEY]intValue] == [Action sharedInstance].RIGHT_CODE) {
            return true;
        }else{
            return false;
        }
    }else{
        return true;
    }
}
- (void)sending:(Request *)msg{
    msg.state = RequestStateSending;
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        [self.aDelegaete handleActionMsg:msg];
    }
}
- (void)success:(Request *)msg{
    msg.message = [msg.output objectAtPath:[Action sharedInstance].MSG_KEY]?:@"";
    msg.state = RequestStateSuccess;
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        [self.aDelegaete handleActionMsg:msg];
    }
}
- (void)failed:(Request *)msg{
    if(msg.error.userInfo!= nil && [msg.error.userInfo objectForKey:@"NSLocalizedDescription"]){
        msg.message = [msg.error.userInfo objectForKey:@"NSLocalizedDescription"];
    }
    msg.state = RequestStateFailed;
    if (msg.error.code == -1001) {
        msg.isTimeout = YES;
    }
    NSLog(@"Failed:%@",msg.error);
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        [self.aDelegaete handleActionMsg:msg];
    }
}
- (void)error:(Request *)msg
{
    if([msg.output objectAtPath:[Action sharedInstance].MSG_KEY]){
        msg.message = [msg.output objectAtPath:[Action sharedInstance].MSG_KEY];
        NSLog(@"Error:%@",msg.message);
    }
    msg.state = RequestStateError;
    if([self.aDelegaete respondsToSelector:@selector(handleActionMsg:)]){
        [self.aDelegaete handleActionMsg:msg];
    }
}
-(void)progressing:(Request *)msg{
    if([self.aDelegaete respondsToSelector:@selector(handleProgressMsg:)]){
        [self.aDelegaete handleProgressMsg:msg];
    }
}

@end
