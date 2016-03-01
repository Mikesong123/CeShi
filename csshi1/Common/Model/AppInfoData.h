//
//  AppInfoData.h
//
//  Created by   on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AppInfoData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *versionpicx;
@property (nonatomic, strong) NSString *versionpicy;
@property (nonatomic, strong) NSString *showUpdate;
@property (nonatomic, strong) NSString *splashaction;
@property (nonatomic, strong) NSString *verifyvid;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, assign) double needupdate;
@property (nonatomic, assign) double application;
@property (nonatomic, strong) NSString *moviename;
@property (nonatomic, strong) NSString *versionname;
@property (nonatomic, strong) NSString *splashstyle;
@property (nonatomic, strong) NSString *postcrashlog;
@property (nonatomic, strong) NSString *versioncode;
@property (nonatomic, strong) NSString *versionlab;
@property (nonatomic, assign) double forbidden;
@property (nonatomic, strong) NSString *versionmini;
@property (nonatomic, strong) NSString *info;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
