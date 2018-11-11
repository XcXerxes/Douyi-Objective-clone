//
//  UserHeader.h
//  Douyi-clone
//
//  Created by xiacan on 2018/11/11.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeader : UICollectionReusableView
// 头部的 背景视图对象
@property(nonatomic, strong) UIImageView *topBackground;

// 初始化数据
-(void) initData;
@end

NS_ASSUME_NONNULL_END