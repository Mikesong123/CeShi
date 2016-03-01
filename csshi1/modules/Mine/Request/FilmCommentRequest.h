//
//  FilmCommentRequest.h
//  FilmSiteClient
//
//  Created by 高 on 15/12/10.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "Request.h"

@interface FilmCommentRequest : Request

/**
 *  用户id
 */
@property (nonatomic,strong) NSString * usercode;
/**
 *  第几页
 */
@property (nonatomic, assign) NSInteger pi;

/**
 *  每页数量
 */
@property (nonatomic, assign) NSInteger ps;
/**
 *
 */
@property (nonatomic, assign) NSInteger notDes;

@end
