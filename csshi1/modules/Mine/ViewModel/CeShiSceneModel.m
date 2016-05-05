//
//  CeShiSceneModel.m
//  csshi1
//
//  Created by 高 on 16/5/3.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CeShiSceneModel.h"

@implementation CeShiSceneModel

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    @weakify(self);
    _request = [FilmCommentRequest RequestWithBlock:^{
        @strongify(self)
        [self SEND_NO_CACHE_ACTION:self.request];
    }];
    
    [[RACObserve(self.request,state) filter:^BOOL(NSNumber *state) {
        @strongify(self);
        return self.request.succeed;
    }] subscribeNext:^(NSNumber *state) {
        @strongify(self);
        if (self.request.output != nil && [self.request.output isKindOfClass:[NSDictionary class]])
        {
//            self.commentModel = [FilmCommentBaseClass modelObjectWithDictionary:[(NSDictionary *)self.request.output objectForKey:@"data"]];
        }
    }];
}

@end
