//
//  CuoWuTiaoShiViewController.m
//  csshi1
//
//  Created by 高 on 16/3/21.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CuoWuTiaoShiViewController.h"

@interface CuoWuTiaoShiViewController () {
    NSMutableArray *outParams;
}

@end

@implementation CuoWuTiaoShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    outParams = [NSMutableArray array];
    [self cuowu];
    [self yichang];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Apple虽然同时提供了错误处理（NSError）和异常处理（exception）两种机制
- (void)cuowu{
    //如果返回的报文是错误信息，则抛出错误
    if([outParams count] <= 0)
    {
//        [NSException raise:@"WebService error" format:@"%@",@"hahah"];// returnJson4SOAP];
    }
}
- (void)yichang{
    //从soap 信息中解析出CusotmerDetail 对象
    @try
    {
        NSString *log = outParams[2];
    } @catch (NSException * e) {
        NSLog(@"数据越界");
        NSLog(@"%@",e);
        return;
    }
}


@end
