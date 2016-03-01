//
//  M1905MacroDefinition.h
//  Test
//
//  Created by Mac Server on 14-8-21.
//  Copyright (c) 2014年 chenhu. All rights reserved.
//

#ifndef M1905MacroDefinition_h
#define M1905MacroDefinition_h


//-------------------获取设备大小-------------------------
// NavigationBar高度
#define M1905_NAVIGATION_BAR_HEIGHT 64

// Tabbar高度
#define M1905_TAB_BAR_HEIGHT 49

// StatusBar高度
#define M1905_STATUS_BAR_HEIGHT 20

// 获取屏幕宽度和高度
#define M1905_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define M1905_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 获取设备屏幕宽度与iPhone6的倍率
#define M1905_SCREEN_WIDTH_RATIO ([UIScreen mainScreen].bounds.size.width/375)
#define M1905_SCREEN_WIDTH_RATIO_SMALL ((([UIScreen mainScreen].bounds.size.width/375))>1?(1):([UIScreen mainScreen].bounds.size.width/375))   // 只针对4、4s、5、5s做倍率缩放
#define M1905_SCREEN_WIDTH_RATIO_LARGE ((([UIScreen mainScreen].bounds.size.width/375))>1?([UIScreen mainScreen].bounds.size.width/375):(1))      // 只针对6p、6sp做倍率缩放
//-------------------获取设备大小-------------------------


//-------------------打印日志----------------------------
// DEBUG模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// DEBUG模式下打印日志,当前行、并弹出一个警告
#ifdef DEBUG
#define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif
//-------------------打印日志----------------------------


//-------------------重写NSLog--------------------------
// 重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
//-------------------重写NSLog--------------------------


//----------------------系统----------------------------
// 获取系统版本
#define M1905_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]     //浮点型
#define M1905_CURRENT_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]       //字符串型

// 获取当前语言
#define M1905_CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])

// 判断当前设备屏幕大小对应的设备
#define M1905_IsIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define M1905_IsIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define M1905_IsIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define M1905_IsIPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define M1905_IsIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 检查系统版本，调用方式 M1905_SYSTEM_VERSION_LESS_THAN(@"7.0")
#define M1905_IOS7 ([[UIDevice currentDevice].systemVersion integerValue]<8.f)
#define M1905_IOS8 (([[UIDevice currentDevice].systemVersion integerValue]>=8.f)&&([[UIDevice currentDevice].systemVersion integerValue]<9.f))
#define M1905_IOS9 (([[UIDevice currentDevice].systemVersion integerValue]>=9.f)&&([[UIDevice currentDevice].systemVersion integerValue]<10.f))
#define M1905_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define M1905_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define M1905_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define M1905_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define M1905_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//----------------------系统----------------------------


//----------------------图片----------------------------
// 读取本地图片
#define M1905_LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

// 读取本地图片
#define M1905_IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]]

// 定义UIImage对象
#define M1905_IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

// 定义UIImage对象
#define M1905_ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------


//----------------------颜色类---------------------------
// RGB颜色转换（16进制->10进制）
#define M1905_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB颜色转换（16进制->10进制）带alpha
#define M1905_UIColorFromRGBA(rgbValue, A) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:A]

// 带有RGBA的颜色设置
#define M1905_COLOR_RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 带有RGB的颜色设置
#define M1905_COLOR_RGB(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.f]
//----------------------颜色类--------------------------


//----------------------其他----------------------------
// 应用代理
#define M1905_APP ((AppDelegate*)[UIApplication sharedApplication].delegate)

// 设置IOS7的translucent为NO
#define M1905_NavTranslucentNo self.navigationController.navigationBar.translucent = NO

// 系统字体定义
#define M1905_SystemFONT(F) [UIFont systemFontOfSize:F]

// 设置View的tag属性
#define M1905_VIEW_WITH_TAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

// 程序的本地化,引用国际化的文件
#define M1905_MyLocal(x, ...) NSLocalizedString(x, nil)

// GCD
#define M1905_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define M1905_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// NSUserDefaults实例化
#define M1905_USER_DEFAULT [NSUserDefaults standardUserDefaults]

// NSUserDefaults Key
#define KEY_IN_USERDEFAULT(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

// 弱引用
#define M1905_WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//----------------------其他----------------------------

#endif
