//
//  RevanMainAPI.m
//  Pods-RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/12/21.
//

#import "RevanMainAPI.h"
#import "RevanTabBarController.h"
#import "RevanTabBar.h"
#import "RevanNavigationBar.h"



@implementation RevanMainAPI

/**
 销毁RevanTabBarController
 */
+ (void)destroyInstance {
    [RevanTabBarController destroyInstance];
}


+ (instancetype)shareInstance {
    static RevanMainAPI *_shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [self new];
    });
    return _shareInstance;
}


+ (RevanTabBarController *)revanAPI_rootTabBarController {
    return [RevanTabBarController shareInstance];
}


+ (void)revanAPI_addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired {
    
    [[RevanTabBarController shareInstance] revan_addChildVC:vc normalImageName:normalImageName selectedImageName:selectedImageName isRequiredNavController:isRequired];
    
}


+ (void)revanAPI_setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {
    
    RevanTabBar *tabbar = (RevanTabBar *)[RevanTabBarController shareInstance].tabBar;
    tabbar.middleClickBlock = middleClickBlock;
    
}

/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)revanAPI_setNavBarGlobalBackGroundImage: (UIImage *)globalImg {
    [RevanNavigationBar revan_setGlobalBackGroundImage:globalImg];
}
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)revanAPI_setNavBarGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize {
    
    [RevanNavigationBar revan_setGlobalTextColor:globalTextColor andFontSize:fontSize];
    
}

/**
 监听tabbarItem点击初始化方法
 */
+ (void)revanAPI_TabBarItemInit {
    
    RevanTabBar *tabbar = (RevanTabBar *)[RevanTabBarController shareInstance].tabBar;
    RevanTabBarController *tabBarVC = [RevanTabBarController shareInstance];
    NSArray *tabbarSubVC = tabBarVC.childViewControllers;
    //初始化
    if ([RevanMainAPI shareInstance].selectTabBarCallBack) {
        [RevanMainAPI shareInstance].selectTabBarCallBack(tabbarSubVC.firstObject, 0);
    }
    [RevanMainAPI shareInstance].curNavVC = tabbarSubVC.firstObject;
    //触发回调
    tabbar.selectTabBarItemBlock = ^(UITabBarItem *tabBarItem) {
        RevanTabBar *tabbar2 = (RevanTabBar *)[RevanTabBarController shareInstance].tabBar;
        RevanTabBarController *tabBarVC2 = [RevanTabBarController shareInstance];
        NSArray *tabbarSubVC2 = tabBarVC2.childViewControllers;
        NSArray *tabBarItems2 = tabbar2.items;
        NSInteger index = [tabBarItems2 indexOfObject:tabBarItem];
        UINavigationController *navigation = [tabbarSubVC2 objectAtIndex:index];
        if ([RevanMainAPI shareInstance].selectTabBarCallBack) {
            [RevanMainAPI shareInstance].selectTabBarCallBack(navigation, index);
            NSLog(@"tabbar:%@-->%zd", navigation, index);
        }
        [RevanMainAPI shareInstance].curNavVC = navigation;
    };
    
}
@end
