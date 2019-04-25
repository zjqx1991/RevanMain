//
//  RevanNavigationBar.h
//  RevanMainModule_Example
//
//  Created by 紫荆秋雪 on 2017/11/28.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanNavigationBar : UINavigationBar
/**
 *  设置全局的导航栏背景图片
 *
 *  @param globalImg 全局导航栏背景图片
 */
+ (void)revan_setGlobalBackGroundImage: (UIImage *)globalImg;
/**
 *  设置全局导航栏标题颜色, 和文字大小
 *
 *  @param globalTextColor 全局导航栏标题颜色
 *  @param fontSize        全局导航栏文字大小
 */
+ (void)revan_setGlobalTextColor: (UIColor *)globalTextColor andFontSize: (CGFloat)fontSize;
@end
