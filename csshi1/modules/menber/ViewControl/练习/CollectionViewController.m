//
//  CollectionViewController.m
//  csshi1
//
//  Created by 高 on 16/3/14.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIImageView *_imgview;
}

@property (nonatomic ,strong) UICollectionView *mainCollection;
@property (nonatomic ,strong) NSMutableArray *dataary;

@end

@implementation CollectionViewController
- (NSMutableArray *)dataary{
    if (!_dataary) {
        _dataary = [NSMutableArray array];
    }
    return _dataary;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    //
    _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:flowLayout];
    _mainCollection.delegate = self;
    _mainCollection.backgroundColor = [UIColor grayColor];
//    _mainCollection.pagingEnabled = YES;
    _mainCollection.dataSource = self;
    _mainCollection.showsHorizontalScrollIndicator = NO;
    _mainCollection.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    _mainCollection.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [_mainCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"bigImageCell"];
    
    [self.view addSubview:_mainCollection];
    //
    _dataary = [NSMutableArray array];
    [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
     [_dataary addObject:[UIImage imageNamed:@"意见反馈1"]];
     [_dataary addObject:[UIImage imageNamed:@"我的账户（修改昵称）"]];
     [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
     [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
     [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
     [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
    for (int i = 0; i<20; i++) {
        [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
    }
     [_dataary addObject:[UIImage imageNamed:@"vip月卡"]];
    
}
#pragma mark --delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataary.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.size.width-40)/3, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bigImageCell" forIndexPath:indexPath];
    for (UIView *view in [cell.contentView subviews]) {
        [view removeFromSuperview];
    }
    _imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.size.height)];
    _imgview.backgroundColor = [UIColor clearColor];
    _imgview.clipsToBounds = YES;
    _imgview.image = _dataary[indexPath.row];
    [cell.contentView addSubview:_imgview];
    return cell;
}
//
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}
//



@end
