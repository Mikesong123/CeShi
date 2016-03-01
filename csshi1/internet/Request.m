//
//  Request.m
//  csshi1
//
//  Created by 高 on 15/12/18.
//  Copyright © 2015年 高. All rights reserved.
//

#import "Request.h"
#import <objc/runtime.h>
#import "Datainterfaceparam.h"
#import "OpenUDID.h"


NSString * const RequestStateSuccess = @"RequestDidSuccess";
NSString * const RequestStateFailed = @"RequestDidFailed";
NSString * const RequestStateSending = @"RequestDidSending";
NSString * const RequestStateError = @"RequestDidError";
NSString * const RequestStateCancle = @"RequestDidCancle";

@implementation Request

+(id)Request{
    return [[self alloc]initRequest];
}

+(id)RequestWithBlock:(EZVoidBlock)voidBlock{
    return [[self alloc]initRequestWithBlock:voidBlock];
}

-(id)initRequest{
    self = [self init];
    if(self){
        [self loadRequest];
    }
    return self;
}

-(id)initRequestWithBlock:(EZVoidBlock)voidBlock{
    self = [self init];
    if(self){
        self.requestInActiveBlock = voidBlock;
        [self loadRequest];
    }
    return self;
}

-(void)loadRequest{
    self.output = nil;
    self.message = @"";
    self.progress = 0.0f;
    self.freezable = NO;
    self.SCHEME = @"";
    self.HOST = @"";
    self.PATH = @"";
    self.METHOD = @"GET";
    self.needCheckCode = YES;
    self.params = [NSMutableDictionary dictionary];
    self.isFirstRequest = YES;
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    self.httpHeaderFields = [NSDictionary dictionaryWithObjectsAndKeys:
                             [Request key_header],@"key",
                             [Request did_header],@"did",
                             [Request ver_header],@"ver",
                             [Request pid_header],@"pid",
                             nil];
    [self loadActive];
}

- (void)loadActive{
    self.requestNeedActive = NO;
    @weakify(self);
    [[RACObserve(self,requestNeedActive)
      filter:^BOOL(NSNumber *active) {
          return [active boolValue];
      }]
     subscribeNext:^(NSNumber *active) {
         @strongify(self);
         if (self.requestInActiveBlock) {
             self.requestInActiveBlock();
         }
         self.requestNeedActive = NO;
     }];
}

- (BOOL)succeed
{
    if(self.output == nil){
        return NO;
    }
    return RequestStateSuccess == _state ? YES : NO;
}
- (BOOL)failed
{
    return RequestStateFailed == _state || RequestStateError == _state ? YES : NO;
}
- (BOOL)sending
{
    return RequestStateSending == _state ? YES : NO;
}
- (BOOL)cancled{
    return RequestStateCancle == _state ? YES : NO;
}

- (void)cancle{
    if(self.op.isNotEmpty && self.op.isExecuting){
        [self.op cancel];
        if(self.op.isCancelled){
            self.state = RequestStateCancle;
        }
    }
}

+(NSString *)requestKey{
    return NSStringFromClass([self class]);
}
-(NSString *)requestKey{
    return NSStringFromClass([self class]);
}

#pragma mark ==============================
#pragma mark 【通用请求heder】
#pragma mark ==============================
+ (NSString *)key_header {
    NSString *key = [NSString stringWithFormat:@"%@%@",[Request did_header],SERVER_HEADER_KEY];
    return [[key md5] lowercaseString];
}

+ (NSString *)did_header {
    return [OpenUDID value];
}

+ (NSString *)ver_header {
    return [NSString stringWithFormat:@"%d/%d/%@",VERSIONID,VERSIONCODE,VERSIONMINI];
}

+ (NSString *)pid_header{
    return PID;
}
- (NSString *)paramOfEncGet:(NSDictionary *)param {
    NSString *paramString = @"";
    if (param != nil) {
        NSUInteger length = [[param allKeys] count];
        
        NSString    *key;
        id          value;
        NSString    *separate = @"&";
        
        for (int i=0; i<length; i++) {
            key = [[param allKeys] objectAtIndex:i];
            value = [param valueForKey:key];
            if (i == length-1) {
                separate = @"";
            }
            paramString = [NSString stringWithFormat:@"%@%@=%@%@", paramString, key, value, separate];
        }
        paramString = [NSString TripleDES:paramString encryptOrDecrypt:kCCEncrypt key:SERVER_DES_KEY];
    }
    
    return paramString;
}
-(NSMutableDictionary *)requestParams{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *propertyList = [self getPropertyList:[self class]];
    [propertyList each:^(NSString *key) {
        NSObject *object = [self valueForKey:key];
        if(object.isNotEmpty){
            [dict setObject:[self valueForKey:key] forKey:key];
        }
    }];
    if (self.params.isNotEmpty) {
        [dict addEntriesFromDictionary:self.params];
    }
    return dict;
}

-(NSString *)appendPathInfo{
    __block NSString *pathInfo = self.pathInfo;
    if(pathInfo.isNotEmpty){
        [self.requestParams enumerateKeysAndObjectsUsingBlock:^(NSString* key, id value, BOOL *stop) {
            NSString *par = [NSString stringWithFormat:@"(\\{%@\\})",key];
            NSString *str = [NSString stringWithFormat:@"%@",value];
            
            pathInfo = [[[NSRegularExpression alloc] initWithPattern:par options:0 error:nil] stringByReplacingMatchesInString:pathInfo options:0 range:NSMakeRange(0, pathInfo.length) withTemplate:str];
        }];
    }
    return pathInfo;
}

-(NSString *)pathInfo{
    return nil;
}

-(NSArray *)getPropertyList:(Class)klass{
    NSMutableArray *propertyNamesArray = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNamesArray addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNamesArray;
}
-(NSString *)cacheKey{
    NSAssert(self.url.isNotEmpty, @"url is empty");
    if([self.METHOD isEqualToString:@"GET"]){
        return self.url.absoluteString.MD5;
    }else if(self.requestParams.isNotEmpty){
        return [NSString stringWithFormat:@"%@%@",self.url,[self.requestParams joinToPath]].MD5;
    }else{
        return [NSString stringWithFormat:@"%@",self.url].MD5;
    }
}

@end
