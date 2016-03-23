//
//  CuoWuTiaoShiViewController.m
//  csshi1
//
//  Created by 高 on 16/3/21.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CuoWuTiaoShiViewController.h"

@interface CuoWuTiaoShiViewController ()<NSStreamDelegate> {
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
//
//-(void)doTestInputStream{
//    NSString*path=@"/Users/usr/Desktop/stream.txt";
//    NSInputStream *readStream=[[NSInputStream alloc]initWithFileAtPath:path];
//    [readStream setDelegate:self];
//    [CFReadStreamScheduleWithRunLoop(readStream, [NSRunLoop currentRunLoop], NSRunLoopCommonModes)];
//    //      [CFReadStreamScheduleWithRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    [readStream open];//调用open开始读文件
//}
//
//-(void)stream:(NSStream*)aStream handleEvent:(NSStreamEvent)eventCode{
//    switch(eventCode){
//        caseNSStreamEventHasBytesAvailable:{
//            uint8_t(1024);
//            NSInputStream * reads=(NSInputStream*)aStream;
//            NSInteger blength=[reads read:bufmaxLength:sizeof(buf)];//把流的数据放入
//            bufferNSData * data=[NSData dataWithBytes:(void*)buflength:blength];
//            NSString *string=[[NSStringalloc]initWithData:dataencoding:NSUTF8StringEncoding];NSLog(@"%@",string);
//        }
//            break;//错误和无事件处理
//        caseNSStreamEventErrorOccurred:{
//        }
//            break;
//        caseNSStreamEventNone:
//            break;//打开完成
//        caseNSStreamEventOpenCompleted:{
//            NSLog(@"NSStreamEventOpenCompleted");
//        }
//            break;
//            
//        default:
//            
//        break;
//    }
//}
@end


