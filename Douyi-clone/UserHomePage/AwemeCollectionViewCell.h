//
//  AwemeCollectionViewCell.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/12.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebPImageView;
@class Aweme;
NS_ASSUME_NONNULL_BEGIN

@interface AwemeCollectionViewCell : UICollectionViewCell
// 定义图片视图对象
@property (nonatomic, strong) WebPImageView *imageView;
@property (nonatomic, strong) UIView *view;
// 定义点赞数按钮
@property (nonatomic, strong) UIButton *favoriteNumBtn;

// 初始化数据
- (void) initData: (Aweme *)aweme;
@end

NS_ASSUME_NONNULL_END
