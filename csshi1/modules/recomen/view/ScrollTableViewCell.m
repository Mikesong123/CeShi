
//
//  ScrollTableViewCell.m
//  csshi1
//
//  Created by 高 on 16/1/6.
//  Copyright © 2016年 高. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "SDCycleScrollView.h"
@interface ScrollTableViewCell ()<SDCycleScrollViewDelegate>
{
    UILabel *_title;
    SDCycleScrollView *_scrollview;
    NSMutableArray  *_headnameary;
}
@end
@implementation ScrollTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)showInterface
{
     _headnameary = [NSMutableArray arrayWithObjects:@"代金券",@"观影记录",@"观影记录(删除)",@"观影券",@"交易记录", nil];
    _scrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, M1905_SCREEN_WIDTH, M1905_SCREEN_WIDTH * 0.469) delegate:self placeholderImage:[UIImage placeHolderImageWithSize:CGSizeMake(M1905_SCREEN_WIDTH, M1905_SCREEN_WIDTH * 0.469) Alignment:NO]];
    _scrollview.autoScrollTimeInterval = 3.0f;
    _scrollview.localizationImagesGroup = _headnameary;
    _scrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _scrollview.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.contentView addSubview:_scrollview];
}
#pragma mark -- delegate


@end
