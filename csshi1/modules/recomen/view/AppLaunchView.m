//
//  AppLaunchView.m
//  csshi1
//
//  Created by 高 on 16/1/4.
//  Copyright © 2016年 高. All rights reserved.
//
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "AppInfoSceneModel.h"

#import "AppLaunchView.h"

#define STARIMAGE @"StarImage"//文件夹
#define IMAGENAME @"StartImageName"//图片名字
#define IMAGETYPE @"ImageType"//图片是否是GIF
#define DURATIONTIME 3//闪图持续时间


#define BOTTOMVIEWHEIGHT 117//底部VIEW的高度

CGFloat const kAdLabelH = 25;
CGFloat const kAdLabelW = 90;
@interface AppLaunchView ()
{
    UIView *_bottonback;
}

@property (nonatomic, strong) FLAnimatedImageView *animatedImageView;

//@property (nonatomic, strong) LaunchBottomView *bottomView;

//@property (nonatomic, strong) M1905AdView *AdView;
@property (nonatomic, strong) UILabel *AdTimeLabel;
@property (nonatomic, assign)  NSInteger AdTime;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) AppInfoSceneModel *sceneModel;

@property (nonatomic, copy)  NSString *fileName;

@end

@implementation AppLaunchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, M1905_SCREEN_WIDTH, M1905_SCREEN_HEIGHT - BOTTOMVIEWHEIGHT)];
        [self addSubview:self.animatedImageView];
        [self bottonView];
        
        [self startPic];
        [self initNetWork];
        
        //广告持续时间   针对 除广电通以外的广告商
        self.AdTime = 10;
    }
    return  self;
}
/**
 *  闪图网络请求
 */
- (void)initNetWork {
    @weakify(self)
    self.sceneModel = [AppInfoSceneModel SceneModel];
    self.sceneModel.request.requestNeedActive = YES;
    [[RACObserve(self.sceneModel, info) filter:^BOOL(id value) {
        return value != nil;
    }] subscribeNext:^(AppInfoData *appInfo) {
        @strongify(self);
        self.imgUrl = [NSURL URLWithString:appInfo.versionpicy];
    }];
}
//
- (void)bottonView
{
    _bottonback  = [[UIView alloc] init];
    _bottonback.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottonback];
    [_bottonback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.height.mas_equalTo(BOTTOMVIEWHEIGHT);
    }];

    UIImageView *nameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qidong_logo_icon_normal"]];
    [_bottonback addSubview:nameImg];
    [nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.size.mas_equalTo(nameImg.image.size);
    }];
    UIImageView *versonimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qidong_banben_icon_normal"]];
    [_bottonback addSubview:versonimg];
    [versonimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@31);
        make.left.equalTo(nameImg.mas_right).offset(3);
        make.size.mas_equalTo(versonimg.image.size);
    }];
    UILabel *versonlb = [[UILabel alloc] init];
    versonlb.backgroundColor = [UIColor clearColor];
    versonlb.textColor = [UIColor whiteColor];
    versonlb.font = [UIFont systemFontOfSize:7.5];
    versonlb.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [versonimg addSubview:versonlb];
    [versonlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
}

/**
 *  开始显示闪图
 */
- (void)startPic {
    NSString *imagename = [[NSUserDefaults standardUserDefaults] objectForKey:IMAGENAME];
    NSString *documentDictionry = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagepath = [documentDictionry stringByAppendingPathComponent:STARIMAGE];
    imagepath = [imagepath stringByAppendingPathComponent:IMAGENAME];
    BOOL isGiF = [[NSUserDefaults standardUserDefaults] boolForKey:IMAGETYPE];
    if (![imagename isNotEmpty]) {
        [self showDefaultImage];
    }else{
        NSData *imageData = [NSData dataWithContentsOfFile:imagepath];
        if (imageData.length > 0) {
            if (isGiF) {
                FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:imageData];
                self.animatedImageView.animatedImage = image;
            }else{
                UIImage *image = [UIImage imageWithData:imageData];
                self.animatedImageView.image = image;
            }
            [self performSelector:@selector(ShowAdView) withObject:self afterDelay:DURATIONTIME];
        }else{
            [self showDefaultImage];
        }
    }
}
/**
 *  检查本地是否存在闪图
 */
- (void)loadFilePath {
    NSString *filepath = [self getFilePath:STARIMAGE file:self.fileName];
    if ([self checkFileFloder]) {
        BOOL fileExists = [self checkFile:filepath];
        if (!fileExists) {
            [self downloadImage];
        }else{
            [self setNsuserDefault:self.fileName forKey:IMAGENAME];
        }
    }else{
        [self downloadImage];
    }
}
//
/**
 *  检查启动闪图是否存在
 */
- (BOOL)checkFile:(NSString *)filePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL b = [fm fileExistsAtPath:filePath];
    if (b) {
        return YES;
    }
    return NO;
}
/**
 *  下载启动闪图
 */
- (void)downloadImage {
    NSString *imgUrlString = _imgUrl.absoluteString;
    if (imgUrlString.length == 0 || _imgUrl == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:IMAGENAME];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:IMAGETYPE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    NSOperationQueue *quene = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL:_imgUrl];
        if ([imageData writeToFile:[self getFilePath:STARIMAGE file:self.fileName] atomically:YES]) {
            NSLog(@"写入成功");
        }else {
            NSLog(@"写入失败");
        }
        [self setNsuserDefault:self.fileName forKey:IMAGENAME];
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        BOOL isGif = [_imgUrl.absoluteString hasSuffix:@".gif"];
        if (isGif) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IMAGETYPE];
        }else{
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:IMAGETYPE];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [operation2 addDependency:operation1];
    [quene addOperation:operation1];
    [quene addOperation:operation2];
}
/**
 *  显示默认启动闪图
 */
- (void)showDefaultImage {
    self.animatedImageView.image = [UIImage imageNamed:@"BBA0F88E-CFC8-4647-A33F-9DCE57E16CBF"];
    [self performSelector:@selector(ShowAdView) withObject:self afterDelay:DURATIONTIME];
}
/**
 *  检查启动闪图文件夹是否存在   存在不处理  不存在自动创建
 */
- (BOOL)checkFileFloder {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    BOOL isDir = NO;
    BOOL isDirExit = [fileManager fileExistsAtPath:[documentpath stringByAppendingPathComponent:STARIMAGE] isDirectory:&isDir];
    if (!isDirExit) {
        BOOL creatDir = [fileManager createDirectoryAtPath:[documentpath stringByAppendingPathComponent:STARIMAGE] withIntermediateDirectories:YES attributes:nil error:nil];
        if (creatDir) {
            NSLog(@"创建文件夹成功");
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}
/**
 *  显示广告视图
 */
- (void)ShowAdView {
    [self addAdView];
}
- (void)addAdView{
//    if ([ad]) {
//        <#statements#>
//    }
}
- (void)removeAdView {
    
}
- (void)updateAdTime {
    
}
- (void)removeAdViewWithTime {
    
}
/**
 *  广点通开屏广告结束的时候  移除当前view
 */
- (void)closeAd {
    //[self removeFromSuperview];
}
/**
 *  广电通开屏广告加载成功使当前view透明
 */
- (void)loadAdSuccess {
//    self.animatedImageView.alpha = 0;
//    self.bottomView.alpha = 0;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateAdTimeLabel {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"跳过广告  %ld", self.AdTime]];
    [str addAttribute:NSForegroundColorAttributeName value:M1905_UIColorFromRGB(0xcccccc) range:NSMakeRange(0, 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    [str addAttribute:NSForegroundColorAttributeName value:M1905_UIColorFromRGB(0xeec948) range:NSMakeRange(4, str.length - 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(4, str.length - 4)];
    self.AdTimeLabel.attributedText = str;
}
#pragma mark ----setter-----
- (void)setImgUrl:(NSURL *)imgUrl
{
    _imgUrl = imgUrl;
    self.fileName = [NSString stringWithFormat:@"%lu",(unsigned long)_imgUrl.description.hash];
    [self loadFilePath];
}
#pragma mark -----getter----
/**
 *  拿到当前控制器
 *
 */
- (UIViewController *)currentVC {
    if (_currentVC == nil) {
        _currentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return _currentVC;
}
- (UILabel *)AdTimeLabel {
    if (_AdTimeLabel == nil) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAdViewWithTime)];
        _AdTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(M1905_SCREEN_WIDTH - kAdLabelW - 10, 20, kAdLabelW, kAdLabelH)];
        _AdTimeLabel.textAlignment = NSTextAlignmentCenter;
        _AdTimeLabel.layer.cornerRadius = 5;
        _AdTimeLabel.clipsToBounds = YES;
        _AdTimeLabel.userInteractionEnabled = YES;
        _AdTimeLabel.backgroundColor = M1905_UIColorFromRGBA(0x000000, 0.7);
        [_AdTimeLabel addGestureRecognizer:tap];
    }
    return _AdTimeLabel;
}
@end
