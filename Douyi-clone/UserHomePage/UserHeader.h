//
//  UserHeader.h
//  Douyi-clone
//
//  Created by xiacan on 2018/11/11.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

NS_ASSUME_NONNULL_BEGIN

@interface UserHeader : UICollectionReusableView
// 头部的 背景视图对象
@property (nonatomic, strong) UIImageView *topBackground;

// 定义 头部的 下半部分的背景视图对象
@property (nonatomic, strong) UIImageView *bottomBackground;

// 初始化数据
-(void) initData:(User *)user;
// 下拉时 调用的 事件
-(void) overScrollAction: (CGFloat) offsetY;
@end

NS_ASSUME_NONNULL_END
