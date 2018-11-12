//
//  BaseViewController.h
//  Douyi-clone
//
//  Created by xiacan on 2018/11/10.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

// 设置毛玻璃 模糊效果
-(void)setTranslucentCover;
// 设置导航控制器的透明度
-(void) initNavigationBarTransparent;

// 设置背景颜色
// 参数： 颜色值
-(void) setBackgroundColor: (UIColor *)color;

// 初始化 导航控制器 的左按钮
// 参数： 图片名称
-(void) initLeftBarButton: (NSString *)imageName;

// 设置 statusBar 是否隐藏
// 参数：BOOL
-(void) setStatusBarHidden: (BOOL) hidden;

// 设置状态栏的背景颜色
- (void) setStatusBarBackgroundColor: (UIColor *)color;
// 设置导航控制器标题
// 参数：标题的字符串
-(void) setNavigationBarTitle: (NSString *)title;

// 设置导航控制器标题颜色
-(void) setNavigationBarTitleColor: (UIColor *)color;

// 设置导航控制器的背景颜色
// 参数： 颜色值
-(void) setNavigationBarBackgroundColor: (UIColor *)color;

// 设置状态栏 的样式
-(void) setStatusBarStyle: (UIBarStyle )style;

// 设置导航控制器的背景 图片
-(void) setNavigationBarBackgroundImage: (UIImage *)image;

// 后退功能
-(void) back;

@end

NS_ASSUME_NONNULL_END
