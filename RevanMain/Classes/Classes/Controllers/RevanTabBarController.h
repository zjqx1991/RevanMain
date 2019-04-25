//
//  RevanTabBarController.h
//  RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanTabBarController : UITabBarController
/**
 获取单例对象
 
 @return TabBarController
 */
+ (instancetype)shareInstance;

/**
 销毁RevanTabBarController
 */
+ (void)destroyInstance;

/**
 添加子控制器的block
 
 @param addVCBlock 添加代码块
 
 @return TabBarController
 */
+ (instancetype)revan_tabBarControllerWithAddChildVCsBlock: (void(^)(RevanTabBarController *tabBarC))addVCBlock;

/**
 添加子控制器
 
 @param vc                子控制器
 @param normalImageName   普通状态下图片
 @param selectedImageName 选中图片
 @param isRequired        是否需要包装导航控制器
 */
- (void)revan_addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;
@end
