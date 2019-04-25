//
//  RevanMiddleView.m
//  RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanMiddleView.h"
#import "CALayer+RevanLayerAimate.h"
#import "UIImage+RevanImage.h"

/**
 加载 mainBundle中的xib文件
 @param xibName xib文件名称
 */
#define RevanLoadingMainNib(xibName) [[[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil] firstObject]

/**
 加载组件中的xib文件
 
 @param Class xib当前类
 @param xibName xib文件名称
 */
#define RevanLoadingCurrentNib(Class, xibName) [[[NSBundle bundleForClass:Class] loadNibNamed:[NSString stringWithFormat:@"%@/%@", @"RevanMainModule.bundle", xibName] owner:nil options:nil] firstObject]


@interface RevanMiddleView()
/** 背景阴影图片 */
@property (weak, nonatomic) IBOutlet UIImageView *middleBgShadowImageView;
/** 正常情况下图片 */
@property (weak, nonatomic) IBOutlet UIImageView *middleBgNormalImageView;
/** 正常情况下播放标识 */
@property (weak, nonatomic) IBOutlet UIImageView *middleBgPlayImageView;
/** 当前正在播放图片 */
@property (weak, nonatomic) IBOutlet UIImageView *middleCurrentPlayingImageView;
/** 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playButton;
/** 中间图片 */
@property (nonatomic, strong) UIImage *middleImage;
/** normal图片 */
@property (weak, nonatomic) IBOutlet UIImageView *normalMiddleImageView;

@end

RevanMiddleType _middleType;

@implementation RevanMiddleView

static RevanMiddleView *share_Instance;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareInstanceWithType:(RevanMiddleType)type {
    if (share_Instance == nil) {
        share_Instance = [RevanMiddleView middleViewWithType:type];
    }
    return share_Instance;
}

+ (instancetype)middleViewWithType:(RevanMiddleType)type {
    _middleType = type;
    if (type == RevanMiddleTypeAnimation) {
        RevanMiddleView *middleView = RevanLoadingCurrentNib(self, @"RevanMiddleView");
        return middleView;
    }
    RevanMiddleView *middleView = RevanLoadingCurrentNib(self, @"RevanMiddleNormalView");
    return middleView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_middleType == RevanMiddleTypeNormal) {
        UIImage *img =[UIImage revan_originImageWithName:@"tabbar_pasture_normal"];
        self.normalMiddleImageView.image = img;
        return;
    }
    self.middleCurrentPlayingImageView.layer.masksToBounds = YES;
    self.middleImage = self.middleCurrentPlayingImageView.image;
    
    [self.middleCurrentPlayingImageView.layer removeAnimationForKey:@"playAnnimation"];
    CABasicAnimation *basicAnnimation = [[CABasicAnimation alloc] init];
    basicAnnimation.keyPath = @"transform.rotation.z";
    basicAnnimation.fromValue = @0;
    basicAnnimation.toValue = @(M_PI * 2);
    basicAnnimation.duration = 30;
    basicAnnimation.repeatCount = MAXFLOAT;
    basicAnnimation.removedOnCompletion = NO;
    [self.middleCurrentPlayingImageView.layer addAnimation:basicAnnimation forKey:@"playAnnimation"];
    [self.middleCurrentPlayingImageView.layer revan_pauseAnimate];
    
    // 监听播放状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayerPlay:) name:@"playState" object:nil];
    
    // 监听播放图片的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPlayImage:) name:@"playImage" object:nil];
    
    self.middleBgNormalImageView.image = [UIImage revan_assetImageName:@"tabbar_np_normal" inDirectoryBundleName:@"RevanMainModule" commandClass:[self class]];
    
    self.middleBgShadowImageView.image = [UIImage revan_assetImageName:@"tabbar_np_shadow" inDirectoryBundleName:@"RevanMainModule" commandClass:[self class]];
    
    self.middleBgPlayImageView.image = [UIImage revan_assetImageName:@"tabbar_np_playshadow" inDirectoryBundleName:@"RevanMainModule" commandClass:[self class]];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (_middleType == RevanMiddleTypeNormal) {
        return;
    }
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
}

/** 更新中间图片 */
- (void)revan_updateMiddleImage:(UIImage *)middleImage {
    if (_middleType == RevanMiddleTypeNormal) {
        self.normalMiddleImageView.image = middleImage;
        return;
    }
    self.middleImage = middleImage;
    self.middleCurrentPlayingImageView.image = middleImage;
}


- (void)playButtonClick:(UIButton *)btn {
    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }
}

- (void)setIsPlaying:(BOOL)isPlaying {
    
    if (_isPlaying == isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playButton setImage:nil forState:UIControlStateNormal];
        [self.middleCurrentPlayingImageView.layer revan_resumeAnimate];
        
    }
    else {
        UIImage *image = [UIImage imageNamed:@"tabbar_np_play"];
        [self.playButton setImage:image forState:UIControlStateNormal];
        [self.middleCurrentPlayingImageView.layer revan_pauseAnimate];
    }
}



#pragma mark - 监听通知方法
- (void)isPlayerPlay:(NSNotification *)notification {
    BOOL isPlay = [notification.object boolValue];
    self.isPlaying = isPlay;
}

- (void)setPlayImage:(NSNotification *)notification {
    UIImage *image = notification.object;
    self.middleImage = image;
}


@end
