//
//  FilmCommentViewController.m
//  FilmSiteClient
//
//  Created by 高 on 15/11/26.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "FilmCommentViewController.h"
#import "FilmCommentTableViewCell.h"
//#import "UserTransaction.h"
#import "UserInfo.h"
#import "FilmCommentViewModels.h"
#import "FilmCommentBaseClass.h"
#import "FilmCommentComments.h"
//#import "DetailViewController.h"
#import "MJRefresh.h"
//#import "PrevueDetailViewController.h"

@interface FilmCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UserInfo       *userinfo;
    UITableView    *_tableview;
    NSMutableArray *_tableData;
    NSInteger      piNum;
    NSInteger      totalPage;
    BOOL           _isheadRefr;//判断上拉刷新还是下拉刷新。为了释放
//    M1905NoNetWorkTipView *_netWorkView;
}
@property (nonatomic ,strong) FilmCommentViewModels *filmcommentSceneModel;
@end

@implementation FilmCommentViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        piNum = 1;
        totalPage = 1;
        _isheadRefr = YES;
//        userinfo = [UserTransaction sharedInstance].currentUser;
        _tableData = [NSMutableArray array];
        _filmcommentSceneModel = [FilmCommentViewModels SceneModel];
        //
        @weakify(self);
        
        [[RACObserve(self.filmcommentSceneModel, commentModel)
          filter:^BOOL(FilmCommentBaseClass * value) {
              return value != nil;
          }]
         subscribeNext:^(FilmCommentBaseClass * value) {
             @strongify(self);
//             if (_netWorkView) {
//                 [_netWorkView removeFromSuperview];
//             }
//             [M1905TipView hideProgressView:self.view];
             [self filmcommentSuccess:value];
         }];
        
        [[RACObserve(self.filmcommentSceneModel.request, state)
          filter:^BOOL(NSNumber *state) {
              @strongify(self);
              return self.filmcommentSceneModel.request.failed;
          }]
         subscribeNext:^(id x) {
//             if (_netWorkView) {
//                 [_netWorkView removeFromSuperview];
//             }
//             _netWorkView = [[M1905NoNetWorkTipView alloc] initWithFrame:CGRectMake(0, 0, M1905_SCREEN_WIDTH, M1905_SCREEN_HEIGHT)];
//             [_netWorkView setRefreshBlock:^{
//                 @strongify(self);
//                 [self filmCommentRequest];
//             }];
//             [self.view addSubview:_netWorkView];
             
             if (_isheadRefr) {
                 [_tableview.header endRefreshing];
             }else{
                 [_tableview.footer endRefreshing];
             }
//             [M1905TipView hideProgressView:self.view];
//             [M1905TipView showMessage:@"网络超时,请重试"];
         }];
    
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _tableData = [NSMutableArray array];
    self.title = @"我的影评";
//    [self setLeftBarItemWithBackImage];
    // Do any additional setup after loading the view.
    _tableview = [[UITableView alloc] init];
    _tableview.backgroundColor = M1905_UIColorFromRGB(0xf2f2f2);
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    
    _tableview.header = [MJRefreshHeader headerWithRefreshingBlock:^{
        piNum = 1;
        _isheadRefr = YES;
        [self filmCommentRequest];
    }];
    _tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        piNum = piNum + 1;
        _isheadRefr = NO;
       [self filmCommentRequest];
    }];
    //
    [_tableview.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark -- Action
- (void)filmCommentRequest
{
    self.filmcommentSceneModel.request.usercode = @"9543345";//userinfo.usercode;
    self.filmcommentSceneModel.request.pi = piNum;
    self.filmcommentSceneModel.request.ps = 10;
    self.filmcommentSceneModel.request.notDes = 1;//测试时用,回传数据没加密,测试可能用上
    self.filmcommentSceneModel.request.timeoutInterval = 10;
    self.filmcommentSceneModel.request.requestNeedActive = YES;
}
- (void)filmcommentSuccess:(FilmCommentBaseClass *)dat
{
    if (totalPage < piNum) {
//        [M1905TipView showMessage:@"已无更多影评"];
        [_tableview.footer endRefreshing];
   
        MJRefreshAutoNormalFooter *footer = _tableview.footer;
        [footer setTitle:@"没有更多影评" forState:MJRefreshStateIdle];

        return;
    }
    if (_isheadRefr) {
        [_tableview.header endRefreshing];
        [_tableData removeAllObjects];
    }else{
        [_tableview.footer endRefreshing];
    }
    //
    if (dat) {
        [_tableData addObjectsFromArray:dat.comments];
        totalPage = dat.totalPages;
    }else{
//        [M1905TipView showMessage:@"请求失败"];
    }
    [_tableview reloadData];
}
#pragma mark -- tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilmCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentcell"];
    if (!cell) {
        cell = [[FilmCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellData = _tableData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilmCommentComments * cellData = _tableData[indexPath.row];
//    if ([cellData.type isEqualToString:@"1"]) {//预告片
//        PrevueDetailViewController *preVC = [[PrevueDetailViewController alloc] init];
//        preVC.movieId = cellData.movieid;
//        [self.navigationController pushViewController:preVC animated:YES];
//    }else{
//        DetailViewController *detailVc = [[DetailViewController alloc] init];
//        detailVc.filmId = cellData.vipid;//cellData[@"vipid"];//服务器要求
//        detailVc.movieId = cellData.movieid;//cellData[@"movieid"];
//        if ([cellData.type isEqualToString:@"7"]) {
//            detailVc.isVip = YES;
//        }else{
//            detailVc.isVip = NO;
//        }
//        [self pushController:detailVc];
//    }
//    DetailViewController *detailVc = [[DetailViewController alloc] init];
//    detailVc.filmId = cellData.vipid;//cellData[@"vipid"];//服务器要求
//    detailVc.movieId = cellData.movieid;//cellData[@"movieid"];
//    if ([cellData.type isEqualToString:@"7"]) {
//        detailVc.isVip = YES;
//    }else{
//        detailVc.isVip = NO;
//    }
//    [self pushController:detailVc];
}

@end
