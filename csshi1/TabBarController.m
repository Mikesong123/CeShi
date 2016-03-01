//
//  TabBarController.m
//  csshi1
//
//  Created by 高 on 15/12/16.
//  Copyright © 2015年 高. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "RecommendViewController.h"
#import "MenberViewController.h"
#import "MineViewController.h"

@interface TabBarController ()
@property (nonatomic, strong) BaseNavigationController *recommend;
@property (nonatomic, strong) BaseNavigationController *menber;
@property (nonatomic, strong) BaseNavigationController *mine;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *minvc = [board instantiateViewControllerWithIdentifier:@"MineViewController"];
    
    _recommend = [[BaseNavigationController alloc] initWithRootViewController:[RecommendViewController new]];
    _menber = [[BaseNavigationController alloc] initWithRootViewController:[MenberViewController new]];
    _mine = [[BaseNavigationController alloc] initWithRootViewController:minvc];//[MineViewController new]];
    
    self.viewControllers = [NSArray arrayWithObjects:_recommend,_menber,_mine, nil];
    _recommend.tabBarItem.title = @"推荐";
//    _recommend.tabBarItem.image = [[UIImage imageNamed:@""];
    
    _menber.tabBarItem.title = @"会员";
    //    _recommend.tabBarItem.image = [[UIImage imageNamed:@""];
    
    _mine.tabBarItem.title = @"我的";
    //    _recommend.tabBarItem.image = [[UIImage imageNamed:@""];
}



@end
