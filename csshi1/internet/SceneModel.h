//
//  SceneModel.h
//  csshi1
//
//  Created by 高 on 15/12/23.
//  Copyright © 2015年 高. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@interface SceneModel : NSObject
@property (nonatomic, strong)Action *action;
+ (id)SceneModel;
- (void)handleActionMsg:(Request *)msg;
- (void)DO_DOWNLOAD:(Request *)req;
- (void)SEND_ACTION:(Request *)req;
- (void)SEND_CACHE_ACTION:(Request *)req;
- (void)SEND_NO_CACHE_ACTION:(Request *)req;
- (void)SEND_IQ_ACTION:(Request *)req;
- (void)loadSceneModel;
@end
