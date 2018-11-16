//
//  SlideTabBar.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/16.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN
// 定义一个代理对象， 用于处理 tab标签切换
@protocol slideTabBarOnTabActionDelegate <NSObject>
// tab切换时触发的事件
// 参数： 选中时的索引
@required
-(void) onTabTapAction:(NSInteger) index;
@end

@interface SlideTabBar : UIView
// 定义一个代理对象属性
@property (nonatomic, weak) id <slideTabBarOnTabActionDelegate> delegate;
// 设置内容
-(void) setLabels: (NSArray<NSString *> *) titles tabIndex:(NSInteger)tabIndex;
@end

NS_ASSUME_NONNULL_END
