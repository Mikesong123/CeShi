//
//  MapViewController.m
//  csshi1
//
//  Created by 高 on 16/2/19.
//  Copyright © 2016年 高. All rights reserved.
//

#import "MapViewController.h"
#import "Student.h"

@interface MapViewController ()<MKMapViewDelegate>
{
    MKMapView    *_customMap ;
}

@property(nonatomic, strong)CLLocationManager *mgr;
/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;

@end

@implementation MapViewController

- (CLLocationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice].systemVersion doubleValue] >=8.0) {
        [self.mgr requestAlwaysAuthorization];
    }
    _customMap = [[MKMapView alloc] initWithFrame:self.view.frame];
    // 设置不允许地图旋转
    _customMap.rotateEnabled = NO;
    
    // 成为mapVIew的代理
    _customMap.delegate = self;
    
    // 如果想利用MapKit获取用户的位置, 可以追踪
    _customMap.userTrackingMode =  MKUserTrackingModeFollow;
    [self.view addSubview:_customMap];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Student *stu = [[Student alloc]init];
    stu.title = @"wode";
    stu.subtitle = @"hahha";
    CGFloat latitude = 36.821199 + arc4random_uniform(20);
    CGFloat longitude = 116.858776 + arc4random_uniform(20);
    stu.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    //
    // 添加大头针
    [_customMap addAnnotation:stu];
}
#pragma MKMapViewDelegate
/**
 *  每次更新到用户的位置就会调用(调用不频繁, 只有位置改变才会调用)
 *
 *  @param mapView      促发事件的控件
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
  [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
      CLPlacemark *mark = [placemarks firstObject];
      NSLog(@"获取地理位置成功 name = %@ locality = %@", mark.name, mark.locality);
      userLocation.title = mark.name;
      userLocation.subtitle = mark.locality;
  }];
    // 设置地图显示的区域
    // 获取用户的位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 指定经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(5,5);
    // 将用户当前的位置作为显示区域的中心点, 并且指定需要显示的跨度范围
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    // 设置显示区域
    [_customMap setRegion:region animated:YES];
}

@end
