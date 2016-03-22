//
//  CeShiViewController.m
//  csshi1
//
//  Created by 高 on 16/2/16.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CeShiViewController.h"
#import "Student.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ceshi1ViewController.h"
#import "MapViewController.h"
#import "CuoWuTiaoShiViewController.h"

@interface CeShiViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    UILabel *wezhilable;
    CLLocationManager *_locationmanager;
    // 指南针图片
    UIImageView  *_compasspointer;
}

@end

@implementation CeShiViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"yici");
//    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIImage *image = [UIImage imageNamed:@"vip月卡"];
    UIImageView *img = [[UIImageView alloc]initWithImage:image];
    img.backgroundColor = [UIColor greenColor];
    img.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@74);
        make.left.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    //
    UIImage *twoimg = [self scaleToSize:image size:CGSizeMake(100, 100)];
    UIImageView *imgtwo = [[UIImageView alloc]initWithImage:image];
    imgtwo.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imgtwo];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.size.mas_equalTo(twoimg.size);
    }];
    UIButton *cbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cbutton.backgroundColor = [UIColor greenColor];
    [cbutton setTitle:@"动画" forState:UIControlStateNormal];
    [cbutton addTarget:self action:@selector(ceshiVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbutton];
    [cbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@-40);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    UIButton *mbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    mbutton.backgroundColor = [UIColor greenColor];
    [mbutton setTitle:@"地图" forState:UIControlStateNormal];
    [mbutton addTarget:self action:@selector(mapVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mbutton];
    [mbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@-40);
        make.bottom.equalTo(cbutton.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    UIButton *cuobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cuobutton.backgroundColor = [UIColor greenColor];
    [cuobutton setTitle:@"地图" forState:UIControlStateNormal];
    [cuobutton addTarget:self action:@selector(cuoVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cuobutton];
    [cuobutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@-40);
        make.bottom.equalTo(mbutton.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    //
//    NSLog(@"%f",twoimg.size.width);
    UIImageWriteToSavedPhotosAlbum(twoimg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    [self ceshiSave];
//    [self performSelector:@selector(qushuju) withObject:@"shuju" afterDelay:3];
     dispatch_time_t delaytime =  dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_queue_t que = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delaytime, que, ^{
        NSLog(@"haode")
        [self qushuju];
    });
    [self testPlace];
  //  [self zhinanzhen];
}
- (void)ceshiVC{
    ceshi1ViewController *ces1 = [[ceshi1ViewController alloc] init];
    [self.navigationController pushViewController:ces1 animated:YES];
}
- (void)mapVC{
    MapViewController *map = [[MapViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}
- (void)cuoVC{
    CuoWuTiaoShiViewController *cap = [[CuoWuTiaoShiViewController alloc] init];
    [self.navigationController pushViewController:cap animated:YES];
}
//将自定义类型数据存入 NSUserDefaults 中
- (void)ceshiSave{
    Student *stu = [[Student alloc]init];
    stu.name = @"haha";
    stu.studentnum = @"123";
    stu.sex = @"nan";
    
    NSMutableArray *dataarray = [NSMutableArray arrayWithCapacity:5];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:stu];
    
    [dataarray addObject:data];
    //存单个数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:@"onestudent"];
    //所有数据
    NSArray *array = [NSArray arrayWithArray:dataarray];
    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
    [uuu setObject:array forKey:@"allstudent"];
}
- (void)qushuju
{
    //还原
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *datq = [user objectForKey:@"onestudent"];
    Student *stu = [NSKeyedUnarchiver unarchiveObjectWithData:datq];
    NSLog(@"%@,%@,%@",stu.name,stu.studentnum,stu.sex);
    
}
//需要回调方法或者检验是否存入成功：
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL) {
        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [photoSave show];
        [photoSave dismissWithClickedButtonIndex:0 animated:YES];
    }else {
        UIAlertView *photoSave = [[UIAlertView alloc] initWithTitle:@"\n\n保存成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [photoSave show];
        [photoSave dismissWithClickedButtonIndex:0 animated:YES];
    }
}
//感觉图片尺寸太大，想压缩成小一点像素的。我们可以自己写个方法。
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scelImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scelImg;
}

#pragma mark -=====自定义截屏位置大小的逻辑代码=====-
-(void)doScreenShotWtihSuccess:(void(^)(UIImage * pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler{
    @try {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.width, self.view.height), YES, 0);     //设置截屏大小
        [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //        CGImageRef imageRef = viewImage.CGImage;
        //        //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
        //        CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);//这里可以设置想要截图的区域
        //        CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
        //        UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
        UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//保存图片到照片库
        NSData *imageViewData = UIImagePNGRepresentation(viewImage);
//        NSString *savedImagePath =[[FileHelper new] dirDoc:kSharePath];
//        NSLog(@"截屏路径打印: %@", savedImagePath);
//        
//        [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
        //        CGImageRelease(imageRefRect);
        //结束之后(回传image)
        pSuccessHandler(viewImage);
    }
    @catch (NSException *exception) {
        pErrorHandler(exception);
    }
    @finally {
        
    }
}

//消除被编码过的标点符号
- (NSString *) changeHtml:(NSString *)changeStr
{
    NSString *result = [changeStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    result = [result stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;nbsp;" withString:@" "];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;amp;" withString:@"&"];
    result = [result stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    //处理单引号bug
    //    result = [result stringByReplacingOccurrencesOfString:@"\'" withString:@"\""];
    result = [result stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    return result;
}
//存到相册
//UIImageWriteToSavedPhotosAlbum(aImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

//位置
- (void)testPlace
{
    wezhilable = [[UILabel alloc] init];
    wezhilable.text = @"等待定位中....";
    wezhilable.backgroundColor = [UIColor grayColor];
    wezhilable.font = [UIFont systemFontOfSize:16];
    wezhilable.textColor = [UIColor redColor];
    [self.view addSubview:wezhilable];
    [wezhilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-10);
    }];

    _locationmanager = [[CLLocationManager alloc] init];
    [_locationmanager setDelegate:self];
    [_locationmanager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //
    // 判断是否是iOS8
    if([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
    {
        NSLog(@"是iOS8");
        // 主动要求用户对我们的程序授权, 授权状态改变就会通知代理
        //
        [_locationmanager requestAlwaysAuthorization]; // 请求前台和后台定位权限
        //        [self.mgr requestWhenInUseAuthorization];// 请求前台定位权限
    }else
    {
        NSLog(@"是iOS7");
        // 3.开始监听(开始获取位置)
        [_locationmanager startUpdatingLocation];
    }

    
}
// 错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error");
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse)
        
    {
        NSLog(@"授权成功");
        // 开始定位
        [_locationmanager startUpdatingLocation];
        
    }else
    {
        NSLog(@"授权失败");
    }

}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"locationcount:--%lu",(unsigned long)[locations count]);
    CLLocation *newlocation = locations[0];
    CLLocationCoordinate2D oldcoorinate = newlocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldcoorinate.longitude,oldcoorinate.latitude);
    //    CLLocation *newLocation = locations[1];
    //    CLLocationCoordinate2D newCoordinate = newLocation.coordinate;
    //    NSLog(@"经度：%f,纬度：%f",newCoordinate.longitude,newCoordinate.latitude);
    
    // 计算两个坐标距离
    //    float distance = [newLocation distanceFromLocation:oldLocation];
    //    NSLog(@"%f",distance);
    [_locationmanager stopUpdatingLocation];
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:oldcoorinate.latitude longitude:oldcoorinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            wezhilable.text = place.name;
            NSLog(@"name:%@",place.name);
        }
    }];
}
//指南针
- (void)zhinanzhen{
    UIImageView *iv = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"bg_compasspointer"]];
    iv.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:iv];
    _compasspointer = iv;
    CLLocationManager* mgr = [[CLLocationManager alloc] init];
    mgr.delegate = self;
    //
    [mgr startUpdatingHeading];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
      CGFloat angle = newHeading.magneticHeading * M_PI / 180;
      _compasspointer.transform = CGAffineTransformMakeRotation(-angle);
}
@end
