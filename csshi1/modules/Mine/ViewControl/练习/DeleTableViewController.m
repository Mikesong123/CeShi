//
//  DeleTableViewController.m
//  csshi1
//
//  Created by 高 on 16/5/5.
//  Copyright © 2016年 高. All rights reserved.
//

#import "DeleTableViewController.h"

@interface DeleTableViewController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_maintableview;
    NSMutableArray *_allDatary;
}

@end

@implementation DeleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self setLeftBarItemWithBackImage];
    [self setRightBarItemWithTitle:@"编辑" selector:@selector(changeSelectStates)];
    // Do any additional setup after loading the view.
    [self showUI];
    [self getData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)showUI {
    _maintableview = [[UITableView alloc] init];
    _maintableview.backgroundColor = [UIColor whiteColor];
    _maintableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _maintableview.delegate = self;
    _maintableview.dataSource = self;
    _maintableview.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:_maintableview];
    [_maintableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(@0);
    }];
}

- (void)changeSelectStates {
    [_maintableview setEditing:!_maintableview.isEditing animated:YES];
    _maintableview.allowsMultipleSelectionDuringEditing = YES;
}

- (void)getData {
    _allDatary = [NSMutableArray array];
    NSString *str = @"说的对，还有一种方式是 在XIB中拖入一个 TextField ，在Attributes Inspecter 中把 Secure ";
    for (int i = 0; i<10; i++) {
        [_allDatary addObject:str];
    }
    
    [_maintableview reloadData];
}

- (void)deleteBT {
    NSArray *indexpath = [_maintableview indexPathsForSelectedRows];
    NSMutableArray*dele = [NSMutableArray array];
    for (NSIndexPath *index in indexpath) {
        [dele addObject:_allDatary[index.row]];
    }
}

#pragma mark --tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allDatary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //    CGFloat scalar = 127.5;
//    CGFloat cellHeigh;
    //    if (size.height > scalar) {
    //        cellHeigh = scalar;
    //    } else {
//    cellHeigh = size.height;
    //    }
    //    if (_selectedCellIndex == indexPath) {
    //        cellHeigh = size.height;
    //    }
    //
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellaaa"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellaaa"];
    
    }
    cell.textLabel.text = _allDatary[indexPath.row];
        return cell;
  
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    SetNormalModel *model = _allDatary[indexPath.row];
//    if ([model.title isEqualToString:@"消息提示"]) {
//        return indexPath;
//    } else {
//        return nil;
//    }
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld---",(long)indexPath.row);
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (_selectedCellIndex != indexPath) {
//        _selectedCellIndex = indexPath;
//    } else {
//        _selectedCellIndex = nil;
//    }
//    [_maintableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//}

@end
