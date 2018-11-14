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

@implementation UserHeader
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        NSLog(@"init");
        [self initAvatarBackground];
    }
    return self;
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
    NSLog(@"===%@", self);
    [self addSubview:_bottomBackground];
    // 初始化 一个 模糊对象
    // 设置模糊的样式
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    // 初始化视图
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    // 设置位置大小
    visualEffectView.frame = _bottomBackground.bounds;
    // 设置透明度
    visualEffectView.alpha = 1;
    [_bottomBackground addSubview:visualEffectView];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [self createBezierPath].CGPath;
    _bottomBackground.layer.mask = maskLayer;
    
    
}
-(UIBezierPath *)createBezierPath {
    int avatarRadius = 54;
    int topOffset = 16;
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
- (void)initData:(User *)user {
    // 背景图片的数据
    UIImage *bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pb3.pstatp.com/obj/dbc1001cd29ccc479f7f"]]];
    _topBackground.image = bgImage;
    NSLog(@"ccc");
}

// 下拉滚动时调用的事件
- (void)overScrollAction:(CGFloat)offsetY {
    CGFloat scaleRatio = fabs(offsetY) / 370.0f;
    CGFloat overScaleHeight = (370.0f * scaleRatio) /2;
    _topBackground.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(scaleRatio + 1.0f, scaleRatio + 1.0f), CGAffineTransformMakeTranslation(0, -overScaleHeight));
}


@end
