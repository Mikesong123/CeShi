//
//  AppInfoSceneModel.h
//  csshi1
//
//  Created by 高 on 16/1/4.
//  Copyright © 2016年 高. All rights reserved.
//

#import "SceneModel.h"
#import "GetAppInfoRequest.h"
#import "AppInfoData.h"

@interface AppInfoSceneModel : SceneModel

@property (nonatomic, strong) GetAppInfoRequest *request;
@property (nonatomic, strong) AppInfoData *info;

@end
