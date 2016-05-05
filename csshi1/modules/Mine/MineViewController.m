//
//  MineViewController.m
//  csshi1
//
//  Created by 高 on 15/12/16.
//  Copyright © 2015年 高. All rights reserved.
//

#import "MineViewController.h"
#import "FilmCommentViewController.h"
//#import "ceshi-Swift.h"
#import "csshi1-Swift.h"
#import "DeleTableViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *view = []
    // Do any additional setup after loading the view.
}

- (IBAction)clickBT:(UIButton *)sender {
    FilmCommentViewController *VC = [[FilmCommentViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (IBAction)clickSetBT:(id)sender {
    SettingViewController *sett = [[SettingViewController alloc] init];
    sett.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sett animated:YES];
}
- (IBAction)textAction:(id)sender {
    DeleTableViewController *sett = [[DeleTableViewController alloc] init];
    sett.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sett animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
