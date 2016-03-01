//
//  NSObject+SystemInfo.m
//  socialDemo
//
//  Created by 陈欢 on 13-12-30.
//  Copyright (c) 2013年 陈欢. All rights reserved.
//

#import "NSObject+SystemInfo.h"
#import <objc/runtime.h>
#import "NSString+Extension.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CommonCrypto/CommonDigest.h>

#include <sys/types.h>
#include <sys/sysctl.h>
#import <mach/mach.h>

@implementation NSObject (SystemInfo)

- (NSMutableArray *)attributeList {
    static NSMutableDictionary *classDictionary = nil;
    if (classDictionary == nil) {
        classDictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSString *className = NSStringFromClass(self.class);
    
    NSMutableArray *propertyList = [classDictionary objectForKey:className];
    
    if (propertyList != nil) {
        return propertyList;
    }
    
    propertyList = [[NSMutableArray alloc] init];
    
    id theClass = object_getClass(self);
    [self getPropertyList:theClass forList:&propertyList];
    
    [classDictionary setObject:propertyList forKey:className];
#if !__has_feature(objc_arc)
    [propertyList release];
#endif
    return propertyList;
}

- (void)getPropertyList:(id)theClass forList:(NSMutableArray **)propertyList {
    id superClass = class_getSuperclass(theClass);
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &count);
    for (i=0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        if (propertyName != nil) {
            [*propertyList addObject:propertyName];
#if !__has_feature(objc_arc)
            [propertyName release];
#endif
            propertyName = nil;
        }
    }
    free(properties);
    
    if (superClass != [NSObject class]) {
        [self getPropertyList:superClass forList:propertyList];
    }
}

- (NSString *)version
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

/*设备相关*/
- (float)deviceSystemVersion {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    return version;
}

- (NSString *)deviceModel {
    NSString *model = [[UIDevice currentDevice] model];
    model = [model stringByReplacingOccurrencesOfString: @" " withString:@"_"];
    return model;
}

- (NSString *)deviceName {
    NSString *name = [[UIDevice currentDevice] name];
    return name;
}

- (BOOL)deviceIsPad {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)deviceIsPhone {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

- (BOOL)deviceIsTouch {
    return [[self deviceModel] rangeOfString:@"iPod touch"].length > 0;
}

- (BOOL)deviceIsRetina {
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)deviceIsPhone5 {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size):NO);
}

- (BOOL)deviceIsMinPhone_3_5 {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size):NO);
}



/*md5 加密*/
- (NSString *)md5 {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data md5];
}

- (NSString *)appleLanguages {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
}

- (void)observeNotificaiton:(NSString *)name {
    [self observeNotificaiton:name selector:@selector(handleNotification:)];
}

- (void)observeNotificaiton:(NSString *)name selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}

- (void)unobserveNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)unobserveAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name {
    [self postNotification:name object:nil];
}

- (void)postNotification:(NSString *)name object:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [self postNotification:name object:nil userInfo:userInfo];
}

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:object
                                                      userInfo:userInfo];
}

- (void)postNotification:(NSString *)name withObject:(id)object {
    if (object == nil) {
        object = @"";
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:kNotificationObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)handleNotification:(NSNotification *)noti {
    if ([self respondsToSelector:@selector(handleNotification:object:userInfo:)]) {
        [self handleNotification:noti.name object:noti.object userInfo:noti.userInfo];
    }
}

- (void)handleNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    
}

- (BOOL)isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isArray {
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isNotEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isDictionary {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotEmptyDictionary {
    if ([self isDictionary]) {
        NSDictionary *tempDict = (NSDictionary *)self;
        if ([tempDict allKeys].count > 0) {
            return YES;
        }
    }
    return NO;
}

- (CGFloat)getFontHeight:(UIFont *)font
{
    NSString *tmpString = @"0";
    return [tmpString getDrawHeightWithFont:font Width:CGFLOAT_MAX];
}

- (BOOL)openURL:(NSURL *)url {
    return [[UIApplication sharedApplication] openURL:url];
}

- (void)sendMail:(NSString *)mail {
    NSString *url = [NSString stringWithFormat:@"mailto://%@", mail];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)sendSMS:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"sms://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}

- (void)callNumber:(NSString *)number {
    NSString *url = [NSString stringWithFormat:@"tel://%@", number];
    [self openURL:[NSURL URLWithString:url]];
}

- (NSString *)applicationDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByReplacingOccurrencesOfString:@"/Documents" withString:@""];
    return basePath;
}

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

/*保存在本地数据*/
- (void)setNsuserDefault:(id)object forKey:(NSString*)key
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:object forKey:key];
    [user synchronize];
}

/*获取文件夹路径*/
- (UIImage *)imagePath:(NSString*)directory file:(NSString *)hash{
    NSString *imagePath=[self getFilePath:directory file:hash];
    NSFileManager *fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:imagePath]){
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        return image;
    }
    return nil;
    
}

- (NSString *)getFilePath:(NSString*)directory file:(NSString *)hash{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *imagePath=[documentDirectory stringByAppendingPathComponent:directory];
    imagePath=[imagePath stringByAppendingPathComponent:hash];
    return imagePath;
}

- (uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    else
    {
        
    }
    
    return totalFreeSpace;
}

- (uint64_t)getTotalDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    else
    {
        
    }
    
    return totalSpace;
}

- (NSString *)networkInfo
{
    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
    return telephonyInfo.currentRadioAccessTechnology;
}

- (long long int)getNowTime
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    return date;
}

- (NSString *)getDevieceDPI
{
    //屏幕尺寸
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGSize size = rect.size;
    
    CGFloat width = size.width;
    
    CGFloat height = size.height;
    

    //分辨率
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    NSString *dpi = [NSString stringWithFormat:@"%0.0fx%0.0f",width*scale_screen,height*scale_screen];
    return dpi;
}

- (CGFloat)getDevieceW_Hbili
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGSize size = rect.size;
    
    CGFloat width = size.width;
    
    CGFloat height = size.height;
    
    return width/height;
}

- (CGSize )getDevieceSize
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGSize size = rect.size;
    
    return size;
}

- (NSString *)replaceNullData:(NSString *)nullData
{
    if ([[self converString:nullData]isEqualToString:@"空"]) {
        return @"";
    }else{
        return nullData;
    }
    return @"";
}

- (NSString *)converString:(NSObject *)obj{
    NSString *str=(NSString *)obj;
    
    if([[obj class] isSubclassOfClass:[NSNumber class]]){
        str=[obj description];
    }
    else if([[obj class] isSubclassOfClass:[NSNull  class]]
            || (obj==nil)
            || ([[obj class] isSubclassOfClass:[NSString class]] && ([(NSString *)obj isEqualToString:@"(null)"]  || [(NSString*)obj isEqualToString:@""]))
            ){
        str= @"空";
    }
    return str.description;
}

//sha1加密方式
- (NSString *)getSha1String:(NSString *)srcString{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    NSString *upperString = [[NSString alloc]initWithString:result];
    
    upperString = [upperString uppercaseString];
    
    return upperString;
}

- (NSString *)timeToTranslate:(NSString *)timestring
{
    NSTimeInterval time=[timestring doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];

    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}

- (NSString *)timeToTranslateToHours:(float )time
{
    NSString *string = [NSString stringWithFormat:@"%li天%02li时%02li分%02li秒",
                        lround(floor(time / (24 *3600.))),
                        lround(floor(time / 3600.)) % 24,
                        lround(floor(time / 60.)) % 60,
                        lround(floor(time/1.)) % 60];
    return string;
}

+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (NSString *)currentDeviceInfo
{
    return [NSString stringWithFormat:@"设备别名:%@,设备型号:%@,系统名称:%@,系统版本号:%@",[[UIDevice currentDevice] name],
                                                                                     [NSObject getCurrentDeviceModel],
                                                                                     [[UIDevice currentDevice] systemName],
                                                                                     [[UIDevice currentDevice] systemVersion]];
}
@end
