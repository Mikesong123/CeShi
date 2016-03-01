//
//  AppInfoData.m
//
//  Created by   on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AppInfoData.h"


NSString *const kAppInfoDataVersionpicx = @"versionpicx";
NSString *const kAppInfoDataVersionpicy = @"versionpicy";
NSString *const kAppInfoDataShowUpdate = @"ShowUpdate";
NSString *const kAppInfoDataSplashaction = @"splashaction";
NSString *const kAppInfoDataVerifyvid = @"verifyvid";
NSString *const kAppInfoDataVerify = @"verify";
NSString *const kAppInfoDataNeedupdate = @"needupdate";
NSString *const kAppInfoDataApplication = @"application";
NSString *const kAppInfoDataMoviename = @"moviename";
NSString *const kAppInfoDataVersionname = @"versionname";
NSString *const kAppInfoDataSplashstyle = @"splashstyle";
NSString *const kAppInfoDataPostcrashlog = @"postcrashlog";
NSString *const kAppInfoDataVersioncode = @"versioncode";
NSString *const kAppInfoDataVersionlab = @"versionlab";
NSString *const kAppInfoDataForbidden = @"forbidden";
NSString *const kAppInfoDataVersionmini = @"versionmini";
NSString *const kAppInfoDataInfo = @"info";


@interface AppInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AppInfoData

@synthesize versionpicx = _versionpicx;
@synthesize versionpicy = _versionpicy;
@synthesize showUpdate = _showUpdate;
@synthesize splashaction = _splashaction;
@synthesize verifyvid = _verifyvid;
@synthesize verify = _verify;
@synthesize needupdate = _needupdate;
@synthesize application = _application;
@synthesize moviename = _moviename;
@synthesize versionname = _versionname;
@synthesize splashstyle = _splashstyle;
@synthesize postcrashlog = _postcrashlog;
@synthesize versioncode = _versioncode;
@synthesize versionlab = _versionlab;
@synthesize forbidden = _forbidden;
@synthesize versionmini = _versionmini;
@synthesize info = _info;


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
            self.versionpicx = [self objectOrNilForKey:kAppInfoDataVersionpicx fromDictionary:dict];
            self.versionpicy = [self objectOrNilForKey:kAppInfoDataVersionpicy fromDictionary:dict];
            self.showUpdate = [self objectOrNilForKey:kAppInfoDataShowUpdate fromDictionary:dict];
            self.splashaction = [self objectOrNilForKey:kAppInfoDataSplashaction fromDictionary:dict];
            self.verifyvid = [self objectOrNilForKey:kAppInfoDataVerifyvid fromDictionary:dict];
            self.verify = [self objectOrNilForKey:kAppInfoDataVerify fromDictionary:dict];
            self.needupdate = [[self objectOrNilForKey:kAppInfoDataNeedupdate fromDictionary:dict] doubleValue];
            self.application = [[self objectOrNilForKey:kAppInfoDataApplication fromDictionary:dict] doubleValue];
            self.moviename = [self objectOrNilForKey:kAppInfoDataMoviename fromDictionary:dict];
            self.versionname = [self objectOrNilForKey:kAppInfoDataVersionname fromDictionary:dict];
            self.splashstyle = [self objectOrNilForKey:kAppInfoDataSplashstyle fromDictionary:dict];
            self.postcrashlog = [self objectOrNilForKey:kAppInfoDataPostcrashlog fromDictionary:dict];
            self.versioncode = [self objectOrNilForKey:kAppInfoDataVersioncode fromDictionary:dict];
            self.versionlab = [self objectOrNilForKey:kAppInfoDataVersionlab fromDictionary:dict];
            self.forbidden = [[self objectOrNilForKey:kAppInfoDataForbidden fromDictionary:dict] doubleValue];
            self.versionmini = [self objectOrNilForKey:kAppInfoDataVersionmini fromDictionary:dict];
            self.info = [self objectOrNilForKey:kAppInfoDataInfo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.versionpicx forKey:kAppInfoDataVersionpicx];
    [mutableDict setValue:self.versionpicy forKey:kAppInfoDataVersionpicy];
    [mutableDict setValue:self.showUpdate forKey:kAppInfoDataShowUpdate];
    [mutableDict setValue:self.splashaction forKey:kAppInfoDataSplashaction];
    [mutableDict setValue:self.verifyvid forKey:kAppInfoDataVerifyvid];
    [mutableDict setValue:self.verify forKey:kAppInfoDataVerify];
    [mutableDict setValue:[NSNumber numberWithDouble:self.needupdate] forKey:kAppInfoDataNeedupdate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.application] forKey:kAppInfoDataApplication];
    [mutableDict setValue:self.moviename forKey:kAppInfoDataMoviename];
    [mutableDict setValue:self.versionname forKey:kAppInfoDataVersionname];
    [mutableDict setValue:self.splashstyle forKey:kAppInfoDataSplashstyle];
    [mutableDict setValue:self.postcrashlog forKey:kAppInfoDataPostcrashlog];
    [mutableDict setValue:self.versioncode forKey:kAppInfoDataVersioncode];
    [mutableDict setValue:self.versionlab forKey:kAppInfoDataVersionlab];
    [mutableDict setValue:[NSNumber numberWithDouble:self.forbidden] forKey:kAppInfoDataForbidden];
    [mutableDict setValue:self.versionmini forKey:kAppInfoDataVersionmini];
    [mutableDict setValue:self.info forKey:kAppInfoDataInfo];

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

    self.versionpicx = [aDecoder decodeObjectForKey:kAppInfoDataVersionpicx];
    self.versionpicy = [aDecoder decodeObjectForKey:kAppInfoDataVersionpicy];
    self.showUpdate = [aDecoder decodeObjectForKey:kAppInfoDataShowUpdate];
    self.splashaction = [aDecoder decodeObjectForKey:kAppInfoDataSplashaction];
    self.verifyvid = [aDecoder decodeObjectForKey:kAppInfoDataVerifyvid];
    self.verify = [aDecoder decodeObjectForKey:kAppInfoDataVerify];
    self.needupdate = [aDecoder decodeDoubleForKey:kAppInfoDataNeedupdate];
    self.application = [aDecoder decodeDoubleForKey:kAppInfoDataApplication];
    self.moviename = [aDecoder decodeObjectForKey:kAppInfoDataMoviename];
    self.versionname = [aDecoder decodeObjectForKey:kAppInfoDataVersionname];
    self.splashstyle = [aDecoder decodeObjectForKey:kAppInfoDataSplashstyle];
    self.postcrashlog = [aDecoder decodeObjectForKey:kAppInfoDataPostcrashlog];
    self.versioncode = [aDecoder decodeObjectForKey:kAppInfoDataVersioncode];
    self.versionlab = [aDecoder decodeObjectForKey:kAppInfoDataVersionlab];
    self.forbidden = [aDecoder decodeDoubleForKey:kAppInfoDataForbidden];
    self.versionmini = [aDecoder decodeObjectForKey:kAppInfoDataVersionmini];
    self.info = [aDecoder decodeObjectForKey:kAppInfoDataInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_versionpicx forKey:kAppInfoDataVersionpicx];
    [aCoder encodeObject:_versionpicy forKey:kAppInfoDataVersionpicy];
    [aCoder encodeObject:_showUpdate forKey:kAppInfoDataShowUpdate];
    [aCoder encodeObject:_splashaction forKey:kAppInfoDataSplashaction];
    [aCoder encodeObject:_verifyvid forKey:kAppInfoDataVerifyvid];
    [aCoder encodeObject:_verify forKey:kAppInfoDataVerify];
    [aCoder encodeDouble:_needupdate forKey:kAppInfoDataNeedupdate];
    [aCoder encodeDouble:_application forKey:kAppInfoDataApplication];
    [aCoder encodeObject:_moviename forKey:kAppInfoDataMoviename];
    [aCoder encodeObject:_versionname forKey:kAppInfoDataVersionname];
    [aCoder encodeObject:_splashstyle forKey:kAppInfoDataSplashstyle];
    [aCoder encodeObject:_postcrashlog forKey:kAppInfoDataPostcrashlog];
    [aCoder encodeObject:_versioncode forKey:kAppInfoDataVersioncode];
    [aCoder encodeObject:_versionlab forKey:kAppInfoDataVersionlab];
    [aCoder encodeDouble:_forbidden forKey:kAppInfoDataForbidden];
    [aCoder encodeObject:_versionmini forKey:kAppInfoDataVersionmini];
    [aCoder encodeObject:_info forKey:kAppInfoDataInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    AppInfoData *copy = [[AppInfoData alloc] init];
    
    if (copy) {

        copy.versionpicx = [self.versionpicx copyWithZone:zone];
        copy.versionpicy = [self.versionpicy copyWithZone:zone];
        copy.showUpdate = [self.showUpdate copyWithZone:zone];
        copy.splashaction = [self.splashaction copyWithZone:zone];
        copy.verifyvid = [self.verifyvid copyWithZone:zone];
        copy.verify = [self.verify copyWithZone:zone];
        copy.needupdate = self.needupdate;
        copy.application = self.application;
        copy.moviename = [self.moviename copyWithZone:zone];
        copy.versionname = [self.versionname copyWithZone:zone];
        copy.splashstyle = [self.splashstyle copyWithZone:zone];
        copy.postcrashlog = [self.postcrashlog copyWithZone:zone];
        copy.versioncode = [self.versioncode copyWithZone:zone];
        copy.versionlab = [self.versionlab copyWithZone:zone];
        copy.forbidden = self.forbidden;
        copy.versionmini = [self.versionmini copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
