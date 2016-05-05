//
//  CeShiSceneModel.h
//  csshi1
//
//  Created by 高 on 16/5/3.
//  Copyright © 2016年 高. All rights reserved.
//

#import "SceneModel.h"
#import "FilmCommentRequest.h"
@class  Ce1SHiModel;
@interface CeShiSceneModel : SceneModel

@property (nonatomic,strong) FilmCommentRequest * request;
@property (nonatomic,strong) Ce1SHiModel  * commentModel;

@end
