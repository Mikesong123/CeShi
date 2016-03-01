//
//  FilmCommentTableViewCell.m
//  FilmSiteClient
//
//  Created by 高 on 15/11/26.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#import "FilmCommentTableViewCell.h"
#import "FilmCommentComments.h"
#import "UIImageView+WebCache.h"

@implementation FilmCommentTableViewCell
{
    UILabel     *_commentlab;
    UIImageView *_recommimg;
    UILabel     *_timelable;
    UIImageView *_filmimage;
    UILabel     *_titlelabel;
    UILabel     *_stauslabel;
    UILabel     *_placelabel;
    UIButton    *_recommendBt;
    NSMutableArray *stararray;
    //
    UIImageView *_cornerImg;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        stararray = [[NSMutableArray alloc] init];
        [self loadInterface];
    }
    return self;
}
- (void)loadInterface
{
    _commentlab = [[UILabel alloc]init];
    _commentlab.backgroundColor = [UIColor clearColor];
    _commentlab.textColor = M1905_UIColorFromRGB(0x333333);
    _commentlab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_commentlab];
    [_commentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.left.equalTo(@9);
        make.width.mas_equalTo(self.contentView.width-20);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = M1905_UIColorFromRGB(0xe2e2e2);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.right.equalTo(@0);
        make.top.equalTo(@59.5);
        make.height.mas_equalTo(1);
    }];
    
    //
    for (int i = 0; i < 5; i++) {
        UIImageView * starimg = [[UIImageView alloc] init];
        [self.contentView addSubview:starimg];
        [stararray addObject:starimg];
    }
    UIImageView *starimg1 = [stararray  objectAtIndex:0];
    [starimg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentlab.mas_bottom).offset(10);
        make.left.equalTo(@9);
    }];
    UIImageView *starimg2 = [stararray  objectAtIndex:1];
    [starimg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starimg1);
        make.left.equalTo(starimg1.mas_right).offset(2);
    }];
    UIImageView *starimg3 = [stararray  objectAtIndex:2];
    [starimg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starimg1);
        make.left.equalTo(starimg2.mas_right).offset(2);
    }];
    UIImageView *starimg4 = [stararray  objectAtIndex:3];
    [starimg4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starimg1);
        make.left.equalTo(starimg3.mas_right).offset(2);
    }];
    UIImageView *starimg5 = [stararray  objectAtIndex:4];
    [starimg5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starimg1);
        make.left.equalTo(starimg4.mas_right).offset(2);
    }];
    //
    _recommendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recommendBt setTitle:@"推荐" forState:UIControlStateNormal];
    _recommendBt.titleLabel.font = [UIFont systemFontOfSize:7];
    [_recommendBt setTitleColor:M1905_UIColorFromRGB(0x4d9ee4) forState:UIControlStateNormal];
    [_recommendBt setBackgroundImage:[UIImage imageNamed:@"yingpin_biaoqian_icon_normal"] forState:UIControlStateNormal];
    UIImage *img = [UIImage imageNamed:@"yingpin_biaoqian_icon_normal"];
    [self.contentView addSubview:_recommendBt];
    [_recommendBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(starimg1);
        make.left.equalTo(starimg5.mas_right).offset(3);
        make.size.mas_equalTo(img.size);
    }];
    _timelable = [[UILabel alloc]init];
    _timelable.backgroundColor = [UIColor clearColor];
    _timelable.textColor = M1905_UIColorFromRGB(0x666666);
    _timelable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_timelable];
    [_timelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_recommendBt);
        make.right.equalTo(@-9);
    }];

    
    _filmimage = [[UIImageView alloc]init];
    [self.contentView addSubview:_filmimage];
    [_filmimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.top.equalTo(line.mas_bottom).offset(13);
        //
        make.size.mas_equalTo(CGSizeMake(110, 60));
    }];
    //
    _cornerImg = [[UIImageView alloc]init];
    _cornerImg.backgroundColor = [UIColor clearColor];
    [_filmimage addSubview:_cornerImg];
    [_cornerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    _titlelabel = [[UILabel alloc]init];
    _titlelabel.backgroundColor = [UIColor clearColor];
    _titlelabel.textColor = M1905_UIColorFromRGB(0x333333);
    _titlelabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titlelabel];
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_filmimage.mas_right).offset(8);
        make.top.equalTo(_filmimage).offset(4);
    }];
    
    _stauslabel = [[UILabel alloc]init];
    _stauslabel.backgroundColor = [UIColor clearColor];
    _stauslabel.text = @"已失效";
    _stauslabel.textColor = M1905_UIColorFromRGB(0x666666);
    _stauslabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_stauslabel];
    [_stauslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titlelabel);
        make.top.equalTo(_titlelabel.mas_bottom).offset(10);
    }];
    
    _placelabel = [[UILabel alloc]init];
    _placelabel.backgroundColor = [UIColor clearColor];
    _placelabel.text = @"已失效";
    _placelabel.textColor = M1905_UIColorFromRGB(0x666666);
    _placelabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_placelabel];
    [_placelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titlelabel);
        make.top.equalTo(_stauslabel.mas_bottom).offset(5);
    }];
    UIView *bottomview = [[UIView alloc]init];
    bottomview.backgroundColor = M1905_UIColorFromRGB(0xf2f2f2);
    [self.contentView addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(_filmimage.mas_bottom).offset(13);
    }];
}
#pragma mark -- Action
- (void)setCellData:(FilmCommentComments *)cellData
{
    _cellData = cellData;
    //
    NSString *imgUrl = [self customImageWithImgUrl:cellData.img Size:CGSizeMake(110, 60) contentMode:M1905CutImageModeCenter quality:M1905CutImageQualityDefault isForceCut:YES];
    //
    _commentlab.text = cellData.content;
    [self scoreAndStar:[cellData.score integerValue]];
    [_recommendBt setTitle:[self scoreRecommend:[cellData.score integerValue]] forState:UIControlStateNormal];
    _timelable.text = [self timeChange:[cellData.ctime integerValue]];
    [_filmimage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    _titlelabel.text = cellData.relatename;
    NSString * stausstring = [cellData.mtype stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    _stauslabel.text = stausstring;
    _placelabel.text = cellData.clime;
    //
    NSString *type = [NSString stringWithFormat:@"%@",cellData.type];
    NSString *bmoth = [NSString stringWithFormat:@"%@",cellData.bmonth];
    NSString *freetime = [NSString stringWithFormat:@"%@",cellData.freetime];
    NSString *leftfreetime = [NSString stringWithFormat:@"%@",cellData.freeLefttime];
//    [_cornerImg setCornerMarkImageWithType:type bmoth:bmoth freetime:freetime leftFreeTime:leftfreetime];
}

- (NSString *)scoreRecommend:(NSInteger)score
{
    NSInteger i = (score-1)/2;
    NSMutableArray *allRE = [NSMutableArray arrayWithObjects:@"差劲",@"一般",@"还行",@"推荐",@"力荐", nil];
    NSString *restring = allRE[i];
    return restring;
}
- (void)scoreAndStar:(NSInteger)score
{
    NSInteger  allstarnum = score/2;
    NSInteger  banstarnum = score%2;
    NSInteger  kongstarnum = 5-allstarnum-banstarnum;
    //
    for (int i = 0 ; i<allstarnum; i++) {
        UIImageView *img = [stararray objectAtIndex:i];
        [img setImage:[UIImage imageNamed:@"yingpin_pinglun_xing_normal"]];
    }
    for (int i = 0; i <banstarnum; i++) {
        UIImageView *img = [stararray objectAtIndex:i+allstarnum];
        [img setImage:[UIImage imageNamed:@"yingping_pinglun_banxing_normal"]];
    }
    for (int i = 0; i <kongstarnum; i++) {
        UIImageView *img = [stararray objectAtIndex:i+allstarnum+banstarnum];
        [img setImage:[UIImage imageNamed:@"yingping_pinglun_kongxing_normal"]];
    }
}
- (NSString *)timeChange:(NSInteger)time
{
    NSDate *tdate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSString *timestring = [format stringFromDate:tdate];
    return timestring;
}

@end
