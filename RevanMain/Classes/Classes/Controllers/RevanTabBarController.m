//
//  RevanTabBarController.m
//  RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanTabBarController.h"
#import "RevanNavigationController.h"
#import "RevanTabBar.h"
#import "UIImage+RevanImage.h"
#import "RevanMiddleView.h"

@interface RevanTabBarController ()

@end



@implementation RevanTabBarController

static RevanTabBarController *tabbarC = nil;
static dispatch_once_t onceToken;
+ (instancetype)shareInstance {
    dispatch_once(&onceToken, ^{
        tabbarC = [[RevanTabBarController alloc] init];
    });
    return tabbarC;
}

/**
 销毁RevanTabBarController
 */
+ (void)destroyInstance {
    tabbarC = nil;
    onceToken = 0l;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    // 设置tabbar
    [self setUpTabbar];
}

- (void)setUpTabbar {
    [self setValue:[[RevanTabBar alloc] init] forKey:@"tabBar"];
}

+ (instancetype)revan_tabBarControllerWithAddChildVCsBlock: (void(^)(RevanTabBarController *tabBarC))addVCBlock {
    
    RevanTabBarController *tabbarVC = [RevanTabBarController shareInstance];
    if (addVCBlock) {
        addVCBlock(tabbarVC);
    }
    return tabbarVC;
}

/**
 *  根据参数, 创建并添加对应的子控制器
 *
 *  @param vc                需要添加的控制器(会自动包装导航控制器)
 *  @param isRequired             标题
 *  @param normalImageName   一般图片名称
 *  @param selectedImageName 选中图片名称
 */
- (void)revan_addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    if (isRequired) {
        RevanNavigationController *nav = [[RevanNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage revan_originImageWithName:normalImageName] selectedImage:[UIImage revan_originImageWithName:selectedImageName]];
        [self addChildViewController:nav];
    }
    else {
        [self addChildViewController:vc];
    }
}

//- (void)setSelectedIndex:(NSUInteger)selectedIndex {
//    [super setSelectedIndex:selectedIndex];
//    UIViewController *vc = self.childViewControllers[selectedIndex];
//    if (vc.view.tag == 666) {
//        vc.view.tag = 888;
//        
//        RevanMiddleView *middleView = [RevanMiddleView middleView];
//        middleView.middleClickBlock = [RevanMiddleView shareInstance].middleClickBlock;
//        middleView.isPlaying = [RevanMiddleView shareInstance].isPlaying;
////        middleView.middleImg = [RevanMiddleView shareInstance].middleImg;
//        CGRect frame = middleView.frame;
//        frame.size.width = 65;
//        frame.size.height = 65;
//        CGSize screenSize = [UIScreen mainScreen].bounds.size;
//        frame.origin.x = (screenSize.width - 65) * 0.5;
//        frame.origin.y = screenSize.height - 65;
//        middleView.frame = frame;
//        [vc.view addSubview:middleView];
//    }
//}


@end
