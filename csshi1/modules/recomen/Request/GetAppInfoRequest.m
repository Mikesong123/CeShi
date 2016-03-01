//
//  GetAppInfoRequest.m
//  csshi1
//
//  Created by 高 on 16/1/4.
//  Copyright © 2016年 高. All rights reserved.
//

#import "GetAppInfoRequest.h"

@implementation GetAppInfoRequest

- (void)loadRequest {
    [super loadRequest];
    //	self.PATH = [NSString stringWithFormat:@"/Html/mobile/ad_%d_%d.html", VERSIONID, VERSIONCODE];
    self.METHOD = @"GET";
    self.PATH = @"/Index/checkupdate";
    //    self.STATICPATH = @"http://m.mapps.m1905.cn/Html/mobile/ad_300_28.html";
    self.needCheckCode = NO;
}

@end
