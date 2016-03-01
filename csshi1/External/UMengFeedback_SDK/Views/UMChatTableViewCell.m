//
//  UMChatTableViewCell.m
//  Feedback
//
//  Created by amoblin on 14/7/31.
//  Copyright (c) 2014年 umeng. All rights reserved.
//

#import "UMChatTableViewCell.h"
#import "UMOpenMacros.h"
//#import "UserInfo.h"
//#import "UserTransaction.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"




@interface UMChatTableViewCell ()
{
//    UserInfo  *userinfo;
}

@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UIImageView *headimage;
@property (strong, nonatomic) UIImageView *messageBackgroundView;

@end

@implementation UMChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.backgroundColor = M1905_UIColorFromRGB(0xf2f2f2);
//        userinfo = [[UserTransaction sharedInstance] currentUser];
//        self.headimage = [[UIImageView alloc]init];
//        self.headimage.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:self.headimage];
//        
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        self.messageBackgroundView = [[UIImageView alloc] init];
//        self.messageBackgroundView.clipsToBounds  = YES;
//        [self.contentView addSubview:self.messageBackgroundView];
//        
//        self.messageLabel = [[UILabel alloc] init];
//        self.messageLabel.backgroundColor = [UIColor clearColor];
//        self.messageLabel.font = [UIFont systemFontOfSize:14.0f];
//        self.messageLabel.numberOfLines = 0;
//        [self.messageBackgroundView addSubview:self.messageLabel];
        
    }
    return self;
}


- (void)configCell:(NSDictionary *)info {
    self.messageLabel.text = info[@"content"];

    if ([info[@"type"] isEqualToString:@"user_reply" ]) {
        // ME
//        self.iconImageView.backgroundColor = UM_UIColorFromHex(0xDBDBDB);
    } else {
        // DEV
//        self.iconImageView.backgroundColor = UM_UIColorFromHex(0x0FB0AA);
    }

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[info[@"created_at"] doubleValue] / 1000];
    self.detailTextLabel.text = [self humanableInfoFromDate:date];
    
    [self loadInterface];
    
}

- (void)loadInterface
{

//    CGSize labelSize = [self.messageLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
    NSDictionary *atttrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
    CGRect lrect = [self.messageLabel.text boundingRectWithSize:CGSizeMake(self.contentView.size.width-100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:atttrbute context:nil];
    CGSize labelSize = lrect.size;
    
    if (self.isRightAlign) {
        self.messageLabel.textColor = [UIColor whiteColor];
//        [self.headimage sd_setImageWithURL:[NSURL URLWithString:userinfo.avatar] placeholderImage:[UIImage imageNamed:@"zhanghu_touxiang_icon_normal"]];
        self.messageBackgroundView.image=[[UIImage imageNamed:@"fankui_yonghu_bg_normal"] stretchableImageWithLeftCapWidth:10 topCapHeight:30];
//         [[self.messageBackgroundView setBackgroundImage:[UIImage resizeImage:@""] forState:UIControlStateNormal];
//        [self.messageBackgroundView setBackgroundImage:[UIImage resizeImage:@"fankui_yonghu_bg_normal"]];
        //
        [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.top.equalTo(@5);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.messageBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headimage.mas_left).offset(-10);
            make.centerY.equalTo(@0);
            make.width.mas_equalTo(labelSize.width + 20);
            make.height.mas_equalTo(labelSize.height + 20);
        }];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@0);
            make.right.equalTo(@-10);
        }];

    } else {
//        [self.headimage setImage:[UIImage imageNamed:@""];
        self.messageLabel.textColor = [UIColor blackColor];
        self.messageBackgroundView.image=[[UIImage imageNamed:@"fankui_kefu_bg_normal"] stretchableImageWithLeftCapWidth:10 topCapHeight:30];
        [self.headimage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.messageBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headimage.mas_right).offset(10);
            make.centerY.equalTo(@0);
            make.width.mas_equalTo(labelSize.width + 20);
            make.height.mas_equalTo(labelSize.height + 20);
        }];
        [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(@0);
            make.right.equalTo(@-10);
        }];
    }

}

- (NSString *)humanableInfoFromDate: (NSDate *) theDate {
    NSString *info;

    NSTimeInterval delta = - [theDate timeIntervalSinceNow];
    if (delta < 60) {
        // 1分钟之内
        info = UM_Local(@"Just now");
    } else {
        delta = delta / 60;
        if (delta < 60) {
            // n分钟前
            info = [NSString stringWithFormat:UM_Local(@"%d minutes ago"), (NSUInteger)delta];
        } else {
            delta = delta / 60;
            if (delta < 24) {
                // n小时前
                info = [NSString stringWithFormat:UM_Local(@"%d hours ago"), (NSUInteger)delta];
            } else {
                delta = delta / 24;
                if ((NSInteger)delta == 1) {
                    //昨天
                    info = UM_Local(@"Yesterday");
                } else if ((NSInteger)delta == 2) {
                    info = UM_Local(@"The day before yesterday");
                } else {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM-dd"];
                    info = [dateFormatter stringFromDate:theDate];
//                    info = [NSString stringWithFormat:@"%d天前", (NSUInteger)delta];
                }
            }
        }
    }
    return info;
}
@end
