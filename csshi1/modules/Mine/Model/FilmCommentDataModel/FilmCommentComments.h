//
//  FilmCommentComments.h
//
//  Created by 高  on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FilmCommentComments : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *freetime;
@property (nonatomic, strong) NSString *commentsDescription;
@property (nonatomic, strong) NSString *mtype;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *relatename;
@property (nonatomic, strong) NSString *crossImg;
@property (nonatomic, assign) double stares;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *isGyt;
@property (nonatomic, strong) NSString *praisenum;
@property (nonatomic, strong) NSString *transpond;
@property (nonatomic, strong) NSString *appname;
@property (nonatomic, strong) NSString *freeLefttime;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *vipid;
@property (nonatomic, strong) NSString *bmonth;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *userFace;
@property (nonatomic, strong) NSString *clime;
@property (nonatomic, strong) NSString *weiboId;
@property (nonatomic, strong) NSString *relateid;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *movieid;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
