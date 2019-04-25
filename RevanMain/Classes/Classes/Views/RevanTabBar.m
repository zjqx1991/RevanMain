//
//  RevanTabBar.m
//  RevanMain_Example
//
//  Created by 紫荆秋雪 on 2017/11/27.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanTabBar.h"
#import "RevanMiddleView.h"
#import "UIView+RevanView.h"
#import "UIImage+RevanImage.h"
#import "RevanMiddleHead.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface RevanTabBar()
/** 中间播放按钮 */
@property (nonatomic, strong) RevanMiddleView *middleView;

@end

@implementation RevanTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    // 设置样式, 去除tabbar上面的黑线
//    self.barStyle = UIBarStyleBlack;
    // 设置tabbar 背景图片
    self.backgroundImage = [UIImage revan_assetImageName:@"tabbar_bg" inDirectoryBundleName:RevanDirectoryBundleName commandClass:[self class]];
}


- (void)setMiddleClickBlock:(void (^)(BOOL))middleClickBlock {
    self.middleView.middleClickBlock = middleClickBlock;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    // 添加一个按钮, 准备放在中间
    CGFloat width = 65;
    CGFloat height = 65;
    self.middleView.frame = CGRectMake((kScreenWidth - width) * 0.5, (kScreenHeight - height), width, height);
    self.middleView.centerX = self.frame.size.width * 0.5;
    self.middleView.y = self.height - self.middleView.height - KTabBarBottomMargin;
}

//-(void)layoutSubviews {
//    [super layoutSubviews];
//    // 将中间按钮, 移动到顶部
//    //    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    //    [window.rootViewController.view bringSubviewToFront:self.middleBtn];
//    NSInteger count = self.items.count;
//    // 1. 遍历所有的子控件
//    NSArray *subViews = self.subviews;
//    // 确定单个控件的大小
//    CGFloat btnW = self.width / (count + 1);
//    CGFloat btnH = self.height;
//    CGFloat btnY = 5;
//    NSInteger index = 0;
//    for (UIView *subView in subViews) {
//        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            if (index == count / 2) {
//                index ++;
//            }
//            CGFloat btnX = index * btnW;
//            subView.frame = CGRectMake(btnX, btnY, btnW, btnH);
//            index ++;
//        }
//    }
//    // 添加一个按钮, 准备放在中间
//    CGFloat width = 65;
//    CGFloat height = 65;
//    self.middleView.frame = CGRectMake((kScreenWidth - width) * 0.5, (kScreenHeight - height), width, height);
//    self.middleView.centerX = self.frame.size.width * 0.5;
//    self.middleView.y = self.height - self.middleView.height;
//
//}


#pragma mark -RevanMiddleView
- (RevanMiddleView *)middleView {
    if (!_middleView) {
        _middleView = [RevanMiddleView middleViewWithType:RevanMiddleTypeNormal];
        [self addSubview:self.middleView];
    }
    return _middleView;
}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 设置允许交互的区域
    // 1. 转换点击在tabbar上的坐标点, 到中间按钮上
    CGPoint pointInMiddleBtn = [self convertPoint:point toView:self.middleView];
    // 2. 确定中间按钮的圆心
    CGPoint middleBtnCenter = CGPointMake(33, 33);
    // 3. 计算点击的位置距离圆心的距离
    CGFloat distance = sqrt(pow(pointInMiddleBtn.x - middleBtnCenter.x, 2) + pow(pointInMiddleBtn.y - middleBtnCenter.y, 2));
    // 4. 判定中间按钮区域之外
    if (distance > 33 && pointInMiddleBtn.y < 18) {
        return NO;
    }
    return YES;
}

#pragma mark - overwrite
- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    [super setSelectedItem:selectedItem];
//    NSString *middleImgName = @"tabbar_pasture_normal";
//    if ([self.items indexOfObject:selectedItem] == (self.items.count/2)) {
//        middleImgName = @"tabbar_pasture_normal";
//    }
//    else {
//        middleImgName = @"tabbar_pasture_normal";
//    }
//    
//    UIImage *img =[UIImage revan_originImageWithName:middleImgName];
//    [self.middleView revan_updateMiddleImage:img];
    
    if (self.selectTabBarItemBlock) {
        self.selectTabBarItemBlock(selectedItem);
    }
}

- (void)revan_updateMiddleImageName:(NSString *)middleImageName {
    UIImage *img =[UIImage revan_originImageWithName:middleImageName];
    [self.middleView revan_updateMiddleImage:img];
}

@end
