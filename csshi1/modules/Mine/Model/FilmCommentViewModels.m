//
//  FilmCommentViewModels.m
//  FilmSiteClient
//
//  Created by 高 on 15/12/10.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "FilmCommentViewModels.h"
#import "FilmCommentBaseClass.h"

@implementation FilmCommentViewModels

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
            self.commentModel = [FilmCommentBaseClass modelObjectWithDictionary:[(NSDictionary *)self.request.output objectForKey:@"data"]];
        }
    }];
}


@end
