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

@protocol UserHeaderDelegate


@end

@interface UserHeader : UICollectionReusableView

// 头部的 背景视图对象
@property (nonatomic, strong) UIImageView *topBackground;
// 定义 头部的 下半部分的背景视图对象
@property (nonatomic, strong) UIImageView *bottomBackground;
// 定义头像的视图
@property (nonatomic, strong) UIImageView *avatar;

// 定义一个内容的视图对象
@property (nonatomic, strong) UIView *containerView;

// 发送消息按钮
@property (nonatomic, strong) UIButton *sendMessageBtn;
// 设置按钮
@property (nonatomic, strong) UIButton *settingBtn;
// 取消关注图标
@property (nonatomic, strong) UIImageView *focusIcon;
// 取消关注按钮
@property (nonatomic, strong) UIButton *focusBtn;
// 添加关注图标
@property (nonatomic, strong) UIImageView *followIcon;
// 添加关注按钮
@property (nonatomic, strong) UIButton *followBtn;

//用户名
@property (nonatomic, strong) UILabel *nickName;
// 抖音号
@property (nonatomic, strong) UILabel *douyinNum;
// 个性签名
@property (nonatomic, strong) UILabel *signature;
// github
@property (nonatomic, strong) UIButton *githubBtn;
//性别
@property (nonatomic, strong) UIImageView *gender;
// 城市
@property (nonatomic, strong) UITextView *city;
// 获取点赞数
@property (nonatomic, strong) UIButton *likeNumBtn;
// 获取关注数
@property (nonatomic, strong) UIButton *followNumBtn;
// 获取粉丝数
@property (nonatomic, strong) UIButton *followedNumBtn;


// 初始化数据
-(void) initData:(User *)user;
// 下拉时 调用的 事件
-(void) overScrollAction: (CGFloat) offsetY;
@end

NS_ASSUME_NONNULL_END
