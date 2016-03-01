//
//  RecommendHeadCollectionViewCell.m
//  csshi1
//
//  Created by 高 on 15/12/17.
//  Copyright © 2015年 高. All rights reserved.
//

#import "RecommendHeadCollectionViewCell.h"

@implementation RecommendHeadCollectionViewCell
{
    UIImageView *_cellimage;
    UILabel     *_cellname;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self showInterface];
    }
    return self;
}
- (void)showInterface
{
    _cellimage = [[UIImageView alloc] init];
    [self.contentView addSubview:_cellimage];
    _cellimage.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 90);
    //
    _cellname = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, self.contentView.frame.size.width, 10)];
    [self.contentView addSubview:_cellname];

}
- (void)setImg:(UIImage *)img
{
    _img = img;
    _cellimage.image = img;
}
- (void)setName:(NSString *)name
{
    _name = name;
    _cellname.text = name;
}

@end
