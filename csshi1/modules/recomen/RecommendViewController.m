//
//  RecommendViewController.m
//  csshi1
//
//  Created by 高 on 15/12/16.
//  Copyright © 2015年 高. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendHeadCollectionViewCell.h"
#import "HMSegmentedControl.h"
#import "RecommendTableView.h"
#import "EntertainTableView.h"
#import "SpecialTableView.h"


@interface RecommendViewController ()<UIScrollViewDelegate>
{
    UITableView     *_tableview;
    UIView          *_headView;
    UIImageView     *_headimg;
    NSMutableArray  *_headimgary;
    NSMutableArray  *_headnameary;
    UICollectionView *_collectview;
}
@property (nonatomic ,strong) HMSegmentedControl *segement;
@property (nonatomic ,strong) UIScrollView *basescroll;
@property (nonatomic ,strong) UIView *contentview;
@end

@implementation RecommendViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *titleAry = [NSArray arrayWithObjects:@"精选",@"专题",@"关注",nil];
    NSDictionary *titleStyle = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:M1905_UIColorFromRGB(0x333333)};
    NSDictionary *titleSelect = @{NSForegroundColorAttributeName:M1905_UIColorFromRGB(0xd9fe5),NSFontAttributeName:[UIFont systemFontOfSize:15]};
    self.segement = [[HMSegmentedControl alloc] initWithSectionTitles:titleAry];
    self.segement.titleTextAttributes = titleStyle;
    self.segement.selectedTitleTextAttributes = titleSelect;
    self.segement.backgroundColor = [UIColor whiteColor];
    self.segement.selectionIndicatorHeight = 2.0f;
    self.segement.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.segement addTarget:self action:@selector(segementValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segement];
    // segmentedControl约束
    [self.segement mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.segement.superview.mas_top).offset(M1905_NAVIGATION_BAR_HEIGHT);
        make.left.equalTo(self.segement.superview.mas_left);
        make.right.equalTo(self.segement.superview.mas_right);
        make.height.equalTo(@30);
    }];
    self.basescroll = [[UIScrollView alloc] init];
    self.basescroll.delegate = self;
    self.basescroll.pagingEnabled = YES;
    self.basescroll.bounces = NO;
    [self.view addSubview:self.basescroll];
    [self.basescroll mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.equalTo(self.segement.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    self.contentview  = [[UIView alloc] init];
    [self.basescroll addSubview:self.contentview];
    [self.contentview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.basescroll);
//        make.height.mas_equalTo(self.basescroll.height);
//        make.width.mas_equalTo(self.basescroll.width*3);
        make.left.equalTo(self.basescroll);
        make.right.equalTo(self.basescroll);
        make.top.equalTo(self.segement.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    NSUInteger count = titleAry.count;
    if (count > 0) {
        
        [titleAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                RecommendTableView *recomentable = [[RecommendTableView alloc] init];
                recomentable.backgroundColor = M1905_UIColorFromRGB(0xf2f2f2);
                [self.contentview addSubview:recomentable];
                [recomentable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(@0);
                    make.left.equalTo(@(idx * self.view.width));
                    make.width.equalTo(@(self.view.width));
                }];
            }if (idx == 1) {
                EntertainTableView *entertable = [[EntertainTableView alloc] init];
                entertable.backgroundColor = M1905_UIColorFromRGB(0xe7fef7);
                [self.contentview addSubview:entertable];
                [entertable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(@0);
                    make.left.equalTo(@(idx * self.view.width));
                    make.width.equalTo(@(self.view.width));
                }];
            }if (idx == 2) {
                SpecialTableView *specialtable = [[SpecialTableView alloc] init];
                specialtable.backgroundColor = [UIColor grayColor];
                [self.contentview addSubview:specialtable];
                [specialtable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(@0);
                    make.left.equalTo(@(idx * self.view.width));
                    make.width.equalTo(@(self.view.width));
                    make.right.equalTo(self.contentview);
                }];
            }
        }];
    }
}

#pragma mark -- Action
- (void)segementValueChange:(HMSegmentedControl *)control
{
	[self.basescroll setContentOffset:CGPointMake(self.view.width * self.segement.selectedSegmentIndex, 0) animated:YES];
}
#pragma mark -- delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewith = scrollView.size.width;
    NSInteger page = scrollView.contentOffset.x / pagewith;
    [self.segement setSelectedSegmentIndex:page animated:YES];
}
@end
