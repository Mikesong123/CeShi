//
//  FilmCommentRequest.m
//  FilmSiteClient
//
//  Created by 高 on 15/12/10.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "FilmCommentRequest.h"

@implementation FilmCommentRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/Comment/commentList";
    self.METHOD = @"GET";
    self.needCheckCode = NO;
}

@end
