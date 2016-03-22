//
//  wannengtiaozhuanViewController.m
//  csshi1
//
//  Created by 高 on 16/3/22.
//  Copyright © 2016年 高. All rights reserved.
//

#import "wannengtiaozhuanViewController.h"

@interface wannengtiaozhuanViewController ()
{
    NSDictionary *userInfo;
    UILabel *label;
    NSTimer *timer;
}

@end

@implementation wannengtiaozhuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userInfo = @{
                 @"class": @"Quartz2dViewController",
                 @"property": @{
                         @"ID": @"123",
                         @"type": @"12"
                         }
                 };
//    [self jiemiantiaozhuan];
    //
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    [self nstimerunloop];
}
- (void)viewWillDisappear:(BOOL)animated{
    [timer invalidate];
}
- (void)jiemiantiaozhuan {
    
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", userInfo[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    // 对该对象赋值属性
    NSDictionary * propertys = userInfo[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
        // 利用kvc赋值
        [instance setValue:obj forKey:key];
                }
    }];
    
    // 获取导航控制器
//    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
//    // 跳转到对应的控制器
//    [pushClassStance pushViewController:instance animated:YES];
    [self.navigationController pushViewController:instance animated:YES];
}

- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}

- (void)GCD{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{ /*任务a */ });
    dispatch_group_async(group, queue, ^{ /*任务b */ });
    dispatch_group_async(group, queue, ^{ /*任务c */ });
    dispatch_group_async(group, queue, ^{ /*任务d */ });
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        // 在a、b、c、d异步执行完成后，会回调这里
    });
}

- (void)nstimerunloop{
    
    // 方法签名中保存了方法的名称/参数/返回值，协同NSInvocation来进行消息的转发
    // 方法签名一般是用来设置参数和获取返回值的, 和方法的调用没有太大的关系
    //1、根据方法来初始化NSMethodSignature
//    NSMethodSignature  *signature = [self instanceMethodSignatureForSelector:@selector(run:)];
//    
//    // NSInvocation中保存了方法所属的对象/方法名称/参数/返回值
//    //其实NSInvocation就是将一个方法变成一个对象
//    //2、创建NSInvocation对象
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    //设置方法调用者
//    invocation.target = self;
//    //注意：这里的方法名一定要与方法签名类中的方法一致
//    invocation.selector = @selector(run:);
//    NSString *way = @"byCar";
//    //这里的Index要从2开始，以为0跟1已经被占据了，分别是self（target）,selector(_cmd)
//    [invocation setArgument:&way atIndex:2];
//    //3、调用invoke方法
//    [invocation invoke];
    
   timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(run:) userInfo:@"可不可以" repeats:YES];
                   
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)run:(NSTimer *)time {
    NSString *msg = (NSString *)[time userInfo];
    NSLog(@"++++++%@",msg);
}

@end
