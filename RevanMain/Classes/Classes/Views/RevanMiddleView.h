//
//  RevanMiddleView.h
//  RevanMain_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RevanDirectoryBundleName @"RevanMain"

/**
 middle类型
 RevanMiddleTypeNormal      :普通
 RevanMiddleTypeAnimation   :旋转动画
 */
typedef NS_ENUM (NSUInteger, RevanMiddleType) {
    RevanMiddleTypeNormal,
    RevanMiddleTypeAnimation
};

@interface RevanMiddleView : UIView

+ (instancetype)shareInstanceWithType:(RevanMiddleType)type;

/**
 快速创建中间视图
 
 @return 中间的视图
 */
+ (instancetype)middleViewWithType:(RevanMiddleType)type;

/**
 更新中间图片

 @param middleImage 中间图片
 */
- (void)revan_updateMiddleImage:(UIImage *)middleImage;

/**
 控制是否正在播放
 */
@property (nonatomic, assign) BOOL isPlaying;

/**
 点击中间按钮的执行代码块
 */
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);


@end
