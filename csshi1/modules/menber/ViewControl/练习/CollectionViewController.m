//
//  CollectionViewController.m
//  csshi1
//
//  Created by 高 on 16/3/14.
//  Copyright © 2016年 高. All rights reserved.
//

#import "CollectionViewController.h"
#import "siyoubianliang.h"
#import "Quartz2dViewController.h"
#import "WeiYuShiYongViewController.h"
#import "Person.h"

@interface CollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIImageView *_imgview;
    NSMutableArray *_nameary;
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
    [_mainCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview"];
    
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
    _nameary = [NSMutableArray array];
    Person *person1 = [[Person alloc] init];
    Person *person2 = [[Person alloc] init];
    Person *person3 = [[Person alloc] init];
    person1.classname = @"Quartz2dViewController";
    person1.title = @"画图";
    person2.classname = @"WeiYuShiYongViewController";
    person2.title = @"谓语使用";
    person3.classname = @"wannengtiaozhuanViewController";
    person3.title = @"界面跳转";
    [_nameary addObject:person1];
    [_nameary addObject:person2];
    [_nameary addObject:person3];
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.width, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *headView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headv = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headview" forIndexPath:indexPath];  //dequeueReusableCellWithReuseIdentifier:@"headview" forIndexPath:indexPath];
        UIImageView *img = [[UIImageView alloc] init];
        [headv addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(@0);
        }];
        img.animationImages = _dataary;
        img.animationRepeatCount = 1;
        img.animationDuration = 3;
        [img startAnimating];
//    }
    return headv;
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
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row < _nameary.count) {
        Person *person = (Person *)_nameary[indexPath.row];
        [self changeViewControl:person.classname];
    }
}
//
- (void)dianjikekan{
    siyoubianliang *model = [[siyoubianliang alloc] init];
    [model setValue:@"在别处可以访问" forKey:@"_username"];

    //
    Ivar username = class_getClassVariable([model class], "_username");
    NSString *user = object_getIvar(model, username);
    NSLog(@"------%@",user);

    //累村问题
    for (int i = 0; i < 100000; ++i) {
        @autoreleasepool {
            NSString *str = @"Abc";
            str = [str lowercaseString];
            str = [str stringByAppendingString:@"xyz"];
            
            NSLog(@"%@", str);
        }
    }
}

- (void)changeViewControl:(NSString *)classname{
    Class theVC = NSClassFromString(classname);
    if (theVC && [theVC isSubclassOfClass:[UIViewController class]]) {
        UIViewController *VC = [[theVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        
//        [self presentViewController:VC animated:YES completion:nil];
//        [self dismissViewControllerAnimated:<#(BOOL)#> completion:<#^(void)completion#>]
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        UIViewController *VC = [[theVC alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
@end
