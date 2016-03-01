//
//  FilmCommentViewModels.h
//  FilmSiteClient
//
//  Created by 高 on 15/12/10.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "SceneModel.h"
#import "FilmCommentRequest.h"
@class FilmCommentBaseClass;
@interface FilmCommentViewModels : SceneModel

@property (nonatomic,strong) FilmCommentRequest * request;
@property (nonatomic,strong) FilmCommentBaseClass  * commentModel;

@end
