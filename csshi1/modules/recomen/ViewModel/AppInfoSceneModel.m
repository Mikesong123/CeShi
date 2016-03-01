//
//  AppInfoSceneModel.m
//  csshi1
//
//  Created by 高 on 16/1/4.
//  Copyright © 2016年 高. All rights reserved.
//

#import "AppInfoSceneModel.h"

@implementation AppInfoSceneModel

- (void)loadSceneModel
{
    [super loadSceneModel];
    @weakify(self);
    _request = [GetAppInfoRequest RequestWithBlock:^{
        @strongify(self)
        [self SEND_NO_CACHE_ACTION:self.request];
    }];
    
    [[RACObserve(self.request, state)filter:^BOOL(NSNumber *value) {
        @strongify(self);
        return self.request.succeed;
    }] subscribeNext:^(NSNumber *state) {
        @strongify(self);
        if (self.request.output != nil) {
            self.info = [AppInfoData modelObjectWithDictionary:self.request.output];
        }
    }];
}

@end
