//
//  UserHeader.m
//  Douyi-clone
//
//  Created by xiacan on 2018/11/11.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import "UserHeader.h"
#import "Constants.h"
#import "Masonry.h"
#import "User.h"

static const NSInteger UserHeaderAvatarTag = 0x01;
static const NSInteger UserHeaderSettingTag = 0x05;

@implementation UserHeader
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}
-(void)initSubViews {
    // 初始化头部的背景图
    [self initAvatarBackground];
    // 初始化一个 内容视图对象
    _containerView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_containerView];
    // 初始化 头像视图
    [self initAvatar];
    // 初始化 包含 事件的视图
    [self initActionsView];
    // 初始化 展示的视图
    [self initInfoView];
}

// 设置包含动作的视图
-(void) initActionsView {
    // 定义 设置按钮
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setImage:[UIImage imageNamed:@"icon_titlebar_whitemore"] forState:UIControlStateNormal];
    _settingBtn.backgroundColor = ColorWhiteAlpha20;
    // 设置圆角
    _settingBtn.layer.cornerRadius = 2;
    [_settingBtn addTarget:self action:@selector(onTapAction:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_settingBtn];
    // 设置按钮的位置大小
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatar);
        make.right.equalTo(self).inset(15);
        make.width.height.mas_equalTo(40);
    }];
    
    // 定义 关注按钮
    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followBtn setImage:[UIImage imageNamed:@"icon_personal_add_little"] forState:UIControlStateNormal];
    // 设置图标的偏移位置
    [_followBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];
    _followBtn.backgroundColor = ColorThemeRed;
    // 设置圆角
    _followBtn.layer.cornerRadius = 2;
    _followBtn.titleLabel.font = MediumFont;
    [_containerView addSubview:_followBtn];
    // 设置按钮的位置大小
    [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.settingBtn);
        make.right.equalTo(self.settingBtn.mas_left).inset(5);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

// 初始化 展示的信息
-(void) initInfoView {
    // 设置用户名
    _nickName = [UILabel new];
    _nickName.text = @"Antony";
    _nickName.font = SuperBigBoldFont;
    _nickName.textColor = ColorWhite;
    [_containerView addSubview:_nickName];
    // 设置 用户名的位置大小
    // 通过Masonry 插件 实现的
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).offset(20);
        make.left.equalTo(self.avatar);
        make.right.equalTo(self.settingBtn);
    }];
    
    // 设置抖音号的 label
    _douyinNum = [UILabel new];
    _douyinNum.text = @"抖音号：8821345679";
    _douyinNum.textColor = ColorWhite;
    _douyinNum.font = SmallFont;
    [_containerView addSubview:_douyinNum];
    [_douyinNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(3);
        make.left.right.equalTo(self.nickName);
    }];
    
    // 设置 箭头图标
    UIImageView *arrowIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow"]];
    [_containerView addSubview:arrowIcon];
    [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.douyinNum);
        make.width.height.mas_equalTo(12);
    }];
    
    // 设置 github 按钮
    _githubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_githubBtn setTitle:@"Github主页" forState:UIControlStateNormal];
    _githubBtn.titleLabel.font = SmallFont;
    _githubBtn.tintColor = ColorWhite;
    [_githubBtn setImage:[UIImage imageNamed:@"icon_github"] forState:UIControlStateNormal];
    [_githubBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_containerView addSubview:_githubBtn];
    [_githubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.douyinNum);
        make.right.equalTo(arrowIcon).inset(5);
        make.width.mas_equalTo(92);
    }];
    
    // 设置分割线
    UIView *hrView = [UIView new];
    hrView.backgroundColor = ColorWhiteAlpha20;
    [_containerView addSubview:hrView];
    [hrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.douyinNum.mas_bottom).offset(10);
        make.left.right.equalTo(self.nickName);
        make.height.mas_equalTo(.5);
    }];
    
    // 设置个性签名
    _signature = [UILabel new];
    _signature.text = @"本宝宝暂时还没想到个性的签名";
    _signature.textColor = ColorWhiteAlpha60;
    _signature.font = SmallFont;
    // 支持多行
    _signature.numberOfLines = 0;
    [_containerView addSubview:_signature];
    [_signature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hrView.mas_bottom).offset(10);
        make.left.right.equalTo(self.nickName);
    }];
    
    //设置性别
    _gender = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconUserProfileBoy"]];
    _gender.backgroundColor = ColorWhiteAlpha20;
    _gender.layer.cornerRadius = 9;
    // 设置 视图的 内容布局方式
    _gender.contentMode = UIViewContentModeCenter;
    [_containerView addSubview:_gender];
    [_gender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickName);
        make.top.equalTo(self.signature.mas_bottom).offset(8);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(22);
    }];
    
    // 设置city 的 label
    _city = [UITextView new];
    _city.text = @"上海";
    _city.textColor = ColorWhite;
    _city.font = SuperSmallFont;
    _city.layer.backgroundColor = ColorWhiteAlpha20.CGColor;
    _city.scrollEnabled = NO;
    _city.editable = NO;
    _city.textContainerInset = UIEdgeInsetsMake(3, 8, 3, 8);
    _city.textContainer.lineFragmentPadding = 0;
    
    _city.layer.backgroundColor = ColorWhiteAlpha20.CGColor;
    _city.layer.cornerRadius = 9;
    [_city sizeToFit];
    [_containerView addSubview:_city];
    [_city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gender.mas_right).offset(5);
        make.top.height.equalTo(self.gender);
    }];
    
    // 设置 获赞数量按钮
    _likeNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_likeNumBtn setTitle:@"0 获赞" forState:UIControlStateNormal];
    [_likeNumBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    _likeNumBtn.titleLabel.font = BigBoldFont;
    [_containerView addSubview:_likeNumBtn];
    [_likeNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gender.mas_bottom).offset(15);
        make.left.equalTo(self.nickName);
    }];
    
    // 设置 关注数量按钮
    _followNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_followNumBtn setTitle:@"0 关注" forState:UIControlStateNormal];
    [_followNumBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    _followNumBtn.titleLabel.font = BigBoldFont;
    [_containerView addSubview:_followNumBtn];
    [_followNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeNumBtn);
        make.left.equalTo(self.likeNumBtn.mas_right).offset(30);
    }];
    // 设置粉丝数量按钮
    _followedNumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_followedNumBtn setTitle:@"0 粉丝" forState:UIControlStateNormal];
    [_followedNumBtn setTitleColor:ColorWhite forState:UIControlStateNormal];
    _followedNumBtn.titleLabel.font = BigBoldFont;
    [_containerView addSubview:_followedNumBtn];
    [_followedNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeNumBtn);
        make.left.equalTo(self.followNumBtn.mas_right).offset(30);
    }];
    
    // 设置 slidebar
    _slideTabBar = [SlideTabBar new];
    [self addSubview:_slideTabBar];
    [_slideTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.right.bottom.equalTo(self);
    }];
    [_slideTabBar setLabels:@[@"作品0", @"喜欢0"] tabIndex:0];
}

- (void)initAvatarBackground {
    // 初始化 头部背景视图对象
    _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,50 + SafeAreaTopHeight)];
    // 设置头部背景视图对象 的 图片显示方式 为 可缩放的
    _topBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topBackground];
    
    // 设置 头部的 下部分的背景对象
    // 设置图片对象的 位置大小
    _bottomBackground =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + SafeAreaTopHeight, ScreenWidth, self.bounds.size.height - (35 + SafeAreaTopHeight))];
    // 设置图片对象的 显示方式
    _bottomBackground.contentMode = UIViewContentModeScaleAspectFill;
    NSLog(@"===%@", _bottomBackground);
    [self addSubview:_bottomBackground];
    // 实现模糊效果
    // 初始化 一个 模糊对象
    // 设置模糊的样式
    // UIBlurEffectStyleDark： 有点黑
    // UIBlurEffectStyleExtraLight: 特别亮
    // UIBlurEffectStyleLight: 有点亮
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 初始化视图
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    // 设置位置大小
    visualEffectView.frame = _bottomBackground.bounds;
    // 设置模糊半径
    visualEffectView.alpha = 1;
    [_bottomBackground addSubview:visualEffectView];
    
    // 添加头像的 圆路径
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [self createBezierPath].CGPath;
    _bottomBackground.layer.mask = maskLayer;
}
-(UIBezierPath *)createBezierPath {
    int avatarRadius = 54;
    int topOffset = 16;
    // 定义一个贝塞尔曲线对象
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(25, topOffset)];
    [bezierPath addArcWithCenter:CGPointMake(25 + avatarRadius * cos(M_PI/4), avatarRadius * sin(M_PI/4) + topOffset) radius:avatarRadius startAngle:(M_PI * 5)/4 endAngle:(M_PI * 7)/4 clockwise:YES];
    [bezierPath addLineToPoint:CGPointMake(25 + avatarRadius * cos(M_PI/4), topOffset)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, topOffset)];
    [bezierPath addLineToPoint:CGPointMake(ScreenWidth, self.bounds.size.height - (50 + SafeAreaTopHeight) + topOffset - 1)];
    [bezierPath addLineToPoint:CGPointMake(0, self.bounds.size.height - (50 + SafeAreaTopHeight) + topOffset - 1)];
    [bezierPath closePath];
    return bezierPath;
}
// 初始化头像
- (void) initAvatar {
    // 定义头像的圆角
    int avatarRadius = 48;
    // 头像的图片文件
    UIImage *avatarImg = [UIImage imageNamed:@"img_find_default"];
    _avatar = [[UIImageView alloc] initWithImage:avatarImg];
    // 设置允许响应事件
    _avatar.userInteractionEnabled = YES;
    // 设置头像视图的 标签
    _avatar.tag = UserHeaderAvatarTag;
    // 添加点击事件
    [_avatar addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction:)]];
    [_containerView addSubview:_avatar];
    
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40 + SafeAreaTopHeight);
        make.left.equalTo(self).offset(15);
        make.width.height.mas_equalTo(avatarRadius * 2);
    }];
}

// 获取服务端的数据
- (void)initData:(User *)user {
    // 背景图片的数据
    UIImage *bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pb3.pstatp.com/obj/dbc1001cd29ccc479f7f"]]];
    _topBackground.image = bgImage;
    [_nickName setText:user.nickname];
    // 设置头像的图片
//    [_avatar setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:user.avatar_medium.url_list.firstObject]]]];
    // 获取抖音号
    [_douyinNum setText: [NSString stringWithFormat:@"抖音号：%@", user.short_id]];
    // 获取个性签名
    if (![user.signature isEqual:@""]) {
        [_signature setText:user.signature];
    }
    // 获取性别
    [_gender setImage:[UIImage imageNamed:user.gender == 0 ? @"iconUserProfileBoy" : @"iconUserProfileGirl"]];
    // 获取点赞数
    [_likeNumBtn setTitle:[NSString stringWithFormat:@"%ld 获赞", user.total_favorited] forState:UIControlStateNormal];
    // 获取关注数量
    [_followNumBtn setTitle:[NSString stringWithFormat:@"%ld 关注", user.following_count] forState:UIControlStateNormal];
    // 获取粉丝数量
    [_followedNumBtn setTitle:[NSString stringWithFormat:@"%ld 粉丝", user.follower_count] forState: UIControlStateNormal];
}

// 下拉滚动时调用的事件
- (void)overScrollAction:(CGFloat)offsetY {
    // 计算背景容器缩放比例
    CGFloat scaleRatio = fabs(offsetY) / 370.0f;
    // 计算容器缩放后 y 方向的偏移量
    CGFloat overScaleHeight = (370.0f * scaleRatio) /2;
    // 缩放同时 平移背景容器
    _topBackground.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(scaleRatio + 1.0f, scaleRatio + 1.0f), CGAffineTransformMakeTranslation(0, -overScaleHeight));
}

- (void)scrollToTopAction:(CGFloat)offsetY {
    CGFloat alphaRatio = offsetY / (370.0f - 44 - [UIApplication sharedApplication].statusBarFrame.size.height);
    _containerView.alpha = 1.0f - alphaRatio;
}


@end
