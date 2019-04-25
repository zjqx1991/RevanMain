//
//  RevanNavigationBar.m
//  RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/11/28.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanNavigationBar.h"

@implementation RevanNavigationBar

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)revan_setGlobalBackGroundImage: (UIImage *)globalImg {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"RevanNavigationController"), nil];
//    [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[NSClassFromString(@"RevanNavigationController")]];
    [navBar setBackgroundImage:globalImg forBarMetrics:UIBarMetricsDefault];
}
/**
 *  设置全局导航栏标题颜色
 *
 *  @param globalTextColor 全局导航栏标题颜色
 */
+ (void)revan_setGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize  {
    if (globalTextColor == nil) {
        return;
    }
    if (fontSize < 6 || fontSize > 40) {
        fontSize = 16;
    }
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"RevanNavigationController"), nil];
//    [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[NSClassFromString(@"RevanNavigationController")]];
    // 设置导航栏颜色
    NSDictionary *titleDic = @{
                               NSForegroundColorAttributeName: globalTextColor,
                               NSFontAttributeName: [UIFont systemFontOfSize:fontSize]
                               };
    [navBar setTitleTextAttributes:titleDic];
}

@end
