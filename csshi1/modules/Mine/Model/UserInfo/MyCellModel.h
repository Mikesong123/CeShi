//
//  MyCellModel.h
//  LoginView
//
//  Created by sam on 15/12/14.
//  Copyright © 2015年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const cellTypeHeader;
extern NSString *const cellTypeNormal;
extern NSString *const cellTypeWatchHistory;
extern NSString *const cellTypeVip;
@interface MyCellModel : NSObject
@property (nonatomic, copy)  NSString *cellType;
@property (nonatomic, copy)  NSString *cellImgName;
@property (nonatomic, copy)  NSString *cellTitle;
@property (nonatomic, copy)  NSString *cellBtnTitle;
@property (nonatomic, assign)  CGFloat cellHeight;
@property (nonatomic, copy)  NSMutableArray *cellDataSource;

@property (nonatomic, copy)  NSString *clazzName;
@end
