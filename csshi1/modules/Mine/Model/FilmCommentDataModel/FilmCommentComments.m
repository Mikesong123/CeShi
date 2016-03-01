//
//  FilmCommentComments.m
//
//  Created by 高  on 15/12/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FilmCommentComments.h"


NSString *const kFilmCommentCommentsFreetime = @"freetime";
NSString *const kFilmCommentCommentsDescription = @"description";
NSString *const kFilmCommentCommentsMtype = @"mtype";
NSString *const kFilmCommentCommentsCtime = @"ctime";
NSString *const kFilmCommentCommentsImg = @"img";
NSString *const kFilmCommentCommentsScore = @"score";
NSString *const kFilmCommentCommentsRelatename = @"relatename";
NSString *const kFilmCommentCommentsCrossImg = @"cross_img";
NSString *const kFilmCommentCommentsStares = @"stares";
NSString *const kFilmCommentCommentsType = @"type";
NSString *const kFilmCommentCommentsIsGyt = @"is_gyt";
NSString *const kFilmCommentCommentsPraisenum = @"praisenum";
NSString *const kFilmCommentCommentsTranspond = @"transpond";
NSString *const kFilmCommentCommentsAppname = @"appname";
NSString *const kFilmCommentCommentsFreeLefttime = @"free_lefttime";
NSString *const kFilmCommentCommentsUid = @"uid";
NSString *const kFilmCommentCommentsVipid = @"vipid";
NSString *const kFilmCommentCommentsBmonth = @"bmonth";
NSString *const kFilmCommentCommentsUser = @"user";
NSString *const kFilmCommentCommentsUserFace = @"user_face";
NSString *const kFilmCommentCommentsClime = @"clime";
NSString *const kFilmCommentCommentsWeiboId = @"weibo_id";
NSString *const kFilmCommentCommentsRelateid = @"relateid";
NSString *const kFilmCommentCommentsComment = @"comment";
NSString *const kFilmCommentCommentsPrice = @"price";
NSString *const kFilmCommentCommentsMovieid = @"movieid";
NSString *const kFilmCommentCommentsContent = @"content";


@interface FilmCommentComments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FilmCommentComments

@synthesize freetime = _freetime;
@synthesize commentsDescription = _commentsDescription;
@synthesize mtype = _mtype;
@synthesize ctime = _ctime;
@synthesize img = _img;
@synthesize score = _score;
@synthesize relatename = _relatename;
@synthesize crossImg = _crossImg;
@synthesize stares = _stares;
@synthesize type = _type;
@synthesize isGyt = _isGyt;
@synthesize praisenum = _praisenum;
@synthesize transpond = _transpond;
@synthesize appname = _appname;
@synthesize freeLefttime = _freeLefttime;
@synthesize uid = _uid;
@synthesize vipid = _vipid;
@synthesize bmonth = _bmonth;
@synthesize user = _user;
@synthesize userFace = _userFace;
@synthesize clime = _clime;
@synthesize weiboId = _weiboId;
@synthesize relateid = _relateid;
@synthesize comment = _comment;
@synthesize price = _price;
@synthesize movieid = _movieid;
@synthesize content = _content;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.freetime = [self objectOrNilForKey:kFilmCommentCommentsFreetime fromDictionary:dict];
            self.commentsDescription = [self objectOrNilForKey:kFilmCommentCommentsDescription fromDictionary:dict];
            self.mtype = [self objectOrNilForKey:kFilmCommentCommentsMtype fromDictionary:dict];
            self.ctime = [self objectOrNilForKey:kFilmCommentCommentsCtime fromDictionary:dict];
            self.img = [self objectOrNilForKey:kFilmCommentCommentsImg fromDictionary:dict];
            self.score = [self objectOrNilForKey:kFilmCommentCommentsScore fromDictionary:dict];
            self.relatename = [self objectOrNilForKey:kFilmCommentCommentsRelatename fromDictionary:dict];
            self.crossImg = [self objectOrNilForKey:kFilmCommentCommentsCrossImg fromDictionary:dict];
            self.stares = [[self objectOrNilForKey:kFilmCommentCommentsStares fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kFilmCommentCommentsType fromDictionary:dict];
            self.isGyt = [self objectOrNilForKey:kFilmCommentCommentsIsGyt fromDictionary:dict];
            self.praisenum = [self objectOrNilForKey:kFilmCommentCommentsPraisenum fromDictionary:dict];
            self.transpond = [self objectOrNilForKey:kFilmCommentCommentsTranspond fromDictionary:dict];
            self.appname = [self objectOrNilForKey:kFilmCommentCommentsAppname fromDictionary:dict];
            self.freeLefttime = [self objectOrNilForKey:kFilmCommentCommentsFreeLefttime fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kFilmCommentCommentsUid fromDictionary:dict];
            self.vipid = [self objectOrNilForKey:kFilmCommentCommentsVipid fromDictionary:dict];
            self.bmonth = [self objectOrNilForKey:kFilmCommentCommentsBmonth fromDictionary:dict];
            self.user = [self objectOrNilForKey:kFilmCommentCommentsUser fromDictionary:dict];
            self.userFace = [self objectOrNilForKey:kFilmCommentCommentsUserFace fromDictionary:dict];
            self.clime = [self objectOrNilForKey:kFilmCommentCommentsClime fromDictionary:dict];
            self.weiboId = [self objectOrNilForKey:kFilmCommentCommentsWeiboId fromDictionary:dict];
            self.relateid = [self objectOrNilForKey:kFilmCommentCommentsRelateid fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kFilmCommentCommentsComment fromDictionary:dict];
            self.price = [self objectOrNilForKey:kFilmCommentCommentsPrice fromDictionary:dict];
            self.movieid = [self objectOrNilForKey:kFilmCommentCommentsMovieid fromDictionary:dict];
            self.content = [self objectOrNilForKey:kFilmCommentCommentsContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.freetime forKey:kFilmCommentCommentsFreetime];
    [mutableDict setValue:self.commentsDescription forKey:kFilmCommentCommentsDescription];
    [mutableDict setValue:self.mtype forKey:kFilmCommentCommentsMtype];
    [mutableDict setValue:self.ctime forKey:kFilmCommentCommentsCtime];
    [mutableDict setValue:self.img forKey:kFilmCommentCommentsImg];
    [mutableDict setValue:self.score forKey:kFilmCommentCommentsScore];
    [mutableDict setValue:self.relatename forKey:kFilmCommentCommentsRelatename];
    [mutableDict setValue:self.crossImg forKey:kFilmCommentCommentsCrossImg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stares] forKey:kFilmCommentCommentsStares];
    [mutableDict setValue:self.type forKey:kFilmCommentCommentsType];
    [mutableDict setValue:self.isGyt forKey:kFilmCommentCommentsIsGyt];
    [mutableDict setValue:self.praisenum forKey:kFilmCommentCommentsPraisenum];
    [mutableDict setValue:self.transpond forKey:kFilmCommentCommentsTranspond];
    [mutableDict setValue:self.appname forKey:kFilmCommentCommentsAppname];
    [mutableDict setValue:self.freeLefttime forKey:kFilmCommentCommentsFreeLefttime];
    [mutableDict setValue:self.uid forKey:kFilmCommentCommentsUid];
    [mutableDict setValue:self.vipid forKey:kFilmCommentCommentsVipid];
    [mutableDict setValue:self.bmonth forKey:kFilmCommentCommentsBmonth];
    [mutableDict setValue:self.user forKey:kFilmCommentCommentsUser];
    [mutableDict setValue:self.userFace forKey:kFilmCommentCommentsUserFace];
    [mutableDict setValue:self.clime forKey:kFilmCommentCommentsClime];
    [mutableDict setValue:self.weiboId forKey:kFilmCommentCommentsWeiboId];
    [mutableDict setValue:self.relateid forKey:kFilmCommentCommentsRelateid];
    [mutableDict setValue:self.comment forKey:kFilmCommentCommentsComment];
    [mutableDict setValue:self.price forKey:kFilmCommentCommentsPrice];
    [mutableDict setValue:self.movieid forKey:kFilmCommentCommentsMovieid];
    [mutableDict setValue:self.content forKey:kFilmCommentCommentsContent];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.freetime = [aDecoder decodeObjectForKey:kFilmCommentCommentsFreetime];
    self.commentsDescription = [aDecoder decodeObjectForKey:kFilmCommentCommentsDescription];
    self.mtype = [aDecoder decodeObjectForKey:kFilmCommentCommentsMtype];
    self.ctime = [aDecoder decodeObjectForKey:kFilmCommentCommentsCtime];
    self.img = [aDecoder decodeObjectForKey:kFilmCommentCommentsImg];
    self.score = [aDecoder decodeObjectForKey:kFilmCommentCommentsScore];
    self.relatename = [aDecoder decodeObjectForKey:kFilmCommentCommentsRelatename];
    self.crossImg = [aDecoder decodeObjectForKey:kFilmCommentCommentsCrossImg];
    self.stares = [aDecoder decodeDoubleForKey:kFilmCommentCommentsStares];
    self.type = [aDecoder decodeObjectForKey:kFilmCommentCommentsType];
    self.isGyt = [aDecoder decodeObjectForKey:kFilmCommentCommentsIsGyt];
    self.praisenum = [aDecoder decodeObjectForKey:kFilmCommentCommentsPraisenum];
    self.transpond = [aDecoder decodeObjectForKey:kFilmCommentCommentsTranspond];
    self.appname = [aDecoder decodeObjectForKey:kFilmCommentCommentsAppname];
    self.freeLefttime = [aDecoder decodeObjectForKey:kFilmCommentCommentsFreeLefttime];
    self.uid = [aDecoder decodeObjectForKey:kFilmCommentCommentsUid];
    self.vipid = [aDecoder decodeObjectForKey:kFilmCommentCommentsVipid];
    self.bmonth = [aDecoder decodeObjectForKey:kFilmCommentCommentsBmonth];
    self.user = [aDecoder decodeObjectForKey:kFilmCommentCommentsUser];
    self.userFace = [aDecoder decodeObjectForKey:kFilmCommentCommentsUserFace];
    self.clime = [aDecoder decodeObjectForKey:kFilmCommentCommentsClime];
    self.weiboId = [aDecoder decodeObjectForKey:kFilmCommentCommentsWeiboId];
    self.relateid = [aDecoder decodeObjectForKey:kFilmCommentCommentsRelateid];
    self.comment = [aDecoder decodeObjectForKey:kFilmCommentCommentsComment];
    self.price = [aDecoder decodeObjectForKey:kFilmCommentCommentsPrice];
    self.movieid = [aDecoder decodeObjectForKey:kFilmCommentCommentsMovieid];
    self.content = [aDecoder decodeObjectForKey:kFilmCommentCommentsContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_freetime forKey:kFilmCommentCommentsFreetime];
    [aCoder encodeObject:_commentsDescription forKey:kFilmCommentCommentsDescription];
    [aCoder encodeObject:_mtype forKey:kFilmCommentCommentsMtype];
    [aCoder encodeObject:_ctime forKey:kFilmCommentCommentsCtime];
    [aCoder encodeObject:_img forKey:kFilmCommentCommentsImg];
    [aCoder encodeObject:_score forKey:kFilmCommentCommentsScore];
    [aCoder encodeObject:_relatename forKey:kFilmCommentCommentsRelatename];
    [aCoder encodeObject:_crossImg forKey:kFilmCommentCommentsCrossImg];
    [aCoder encodeDouble:_stares forKey:kFilmCommentCommentsStares];
    [aCoder encodeObject:_type forKey:kFilmCommentCommentsType];
    [aCoder encodeObject:_isGyt forKey:kFilmCommentCommentsIsGyt];
    [aCoder encodeObject:_praisenum forKey:kFilmCommentCommentsPraisenum];
    [aCoder encodeObject:_transpond forKey:kFilmCommentCommentsTranspond];
    [aCoder encodeObject:_appname forKey:kFilmCommentCommentsAppname];
    [aCoder encodeObject:_freeLefttime forKey:kFilmCommentCommentsFreeLefttime];
    [aCoder encodeObject:_uid forKey:kFilmCommentCommentsUid];
    [aCoder encodeObject:_vipid forKey:kFilmCommentCommentsVipid];
    [aCoder encodeObject:_bmonth forKey:kFilmCommentCommentsBmonth];
    [aCoder encodeObject:_user forKey:kFilmCommentCommentsUser];
    [aCoder encodeObject:_userFace forKey:kFilmCommentCommentsUserFace];
    [aCoder encodeObject:_clime forKey:kFilmCommentCommentsClime];
    [aCoder encodeObject:_weiboId forKey:kFilmCommentCommentsWeiboId];
    [aCoder encodeObject:_relateid forKey:kFilmCommentCommentsRelateid];
    [aCoder encodeObject:_comment forKey:kFilmCommentCommentsComment];
    [aCoder encodeObject:_price forKey:kFilmCommentCommentsPrice];
    [aCoder encodeObject:_movieid forKey:kFilmCommentCommentsMovieid];
    [aCoder encodeObject:_content forKey:kFilmCommentCommentsContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    FilmCommentComments *copy = [[FilmCommentComments alloc] init];
    
    if (copy) {

        copy.freetime = [self.freetime copyWithZone:zone];
        copy.commentsDescription = [self.commentsDescription copyWithZone:zone];
        copy.mtype = [self.mtype copyWithZone:zone];
        copy.ctime = [self.ctime copyWithZone:zone];
        copy.img = [self.img copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.relatename = [self.relatename copyWithZone:zone];
        copy.crossImg = [self.crossImg copyWithZone:zone];
        copy.stares = self.stares;
        copy.type = [self.type copyWithZone:zone];
        copy.isGyt = [self.isGyt copyWithZone:zone];
        copy.praisenum = [self.praisenum copyWithZone:zone];
        copy.transpond = [self.transpond copyWithZone:zone];
        copy.appname = [self.appname copyWithZone:zone];
        copy.freeLefttime = [self.freeLefttime copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.vipid = [self.vipid copyWithZone:zone];
        copy.bmonth = [self.bmonth copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.userFace = [self.userFace copyWithZone:zone];
        copy.clime = [self.clime copyWithZone:zone];
        copy.weiboId = [self.weiboId copyWithZone:zone];
        copy.relateid = [self.relateid copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.movieid = [self.movieid copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
