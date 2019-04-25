//
//  RevanTabBar.h
//  RevanMain_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanTabBar : UITabBar
/**
 点击中间按钮的执行代码块
 */
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);

/** 选中UITabBarItem */
@property (nonatomic, copy) void(^selectTabBarItemBlock)(UITabBarItem *tabBarItem);

- (void)revan_updateMiddleImageName:(NSString *)middleImageName;
@end
