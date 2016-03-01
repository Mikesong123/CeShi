//
//  SettingInfoModel.h
//  FilmSiteClient
//
//  Created by 高 on 15/11/23.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL      isswich;
@property (nonatomic, strong) NSString *classname;

@end
