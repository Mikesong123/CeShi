
//
//  MenberViewController.m
//  csshi1
//
//  Created by 高 on 15/12/16.
//  Copyright © 2015年 高. All rights reserved.
//

#import "MenberViewController.h"
#import "SaveDataViewController.h"
#import "FMDBViewController.h"
#import "CeShiViewController.h"
#import "CollectionViewController.h"
#import "siyoubianliang.h"

@interface MenberViewController ()

@end

@implementation MenberViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        siyoubianliang *model = [[siyoubianliang alloc] init];
//        [model setValue:@"在别处可以访问" forKey:@"_username"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"SQLite数据保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveCusstomNUM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    //
    UIButton *fbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    fbutton.backgroundColor = [UIColor greenColor];
    [fbutton setTitle:@"FMDB数据保存" forState:UIControlStateNormal];
    [fbutton addTarget:self action:@selector(savedataFMDB) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fbutton];
    [fbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.mas_bottom).offset(10);
        make.left.right.equalTo(button);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    //
    UIButton *cbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    cbutton.backgroundColor = [UIColor greenColor];
    [cbutton setTitle:@"ceshi保存" forState:UIControlStateNormal];
    [cbutton addTarget:self action:@selector(ceshiVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbutton];
    [cbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fbutton.mas_bottom).offset(10);
        make.left.right.equalTo(button);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    //
    UIButton *lbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    lbutton.backgroundColor = [UIColor greenColor];
    [lbutton setTitle:@"collection" forState:UIControlStateNormal];
    [lbutton addTarget:self action:@selector(lianxiVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lbutton];
    [lbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cbutton.mas_bottom).offset(10);
        make.left.right.equalTo(button);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
}
- (void)lianxiVC{
    CollectionViewController *fmdbVC = [[CollectionViewController alloc] init];
     fmdbVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fmdbVC animated:YES];
}
- (void)saveCusstomNUM{
    SaveDataViewController *saveVC = [[SaveDataViewController alloc] initWithNibName:@"SaveDataViewController" bundle:nil];
    [self.navigationController pushViewController:saveVC animated:YES];
}
- (void)savedataFMDB{
    FMDBViewController *fmdbVC = [[FMDBViewController alloc] init];
    [self.navigationController pushViewController:fmdbVC animated:YES];
}
- (void)ceshiVC{
    CeShiViewController *csshiVC = [[CeShiViewController alloc] init];
    csshiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:csshiVC animated:YES];
}
@end
