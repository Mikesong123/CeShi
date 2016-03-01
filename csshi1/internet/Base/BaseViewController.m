//
//  BaseViewController.m
//  FilmSiteClient
//
//  Created by 陈虎 on 15/10/16.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Extension.h"
#import "UIViewController+Navigate.h"


@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigateBarBackImage:[UIImage imageWithColor:M1905_UIColorFromRGB(0x4e9ee5) size:CGSizeMake(M1905_SCREEN_WIDTH, M1905_NAVIGATION_BAR_HEIGHT)]];
     
     NSDictionary *textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,
                              [UIFont systemFontOfSize:20],NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = textDic;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
}

@end
