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


- (void)initAvatarBackground {
    // 初始化 头部背景视图对象
    _topBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,50 + SafeAreaTopHeight)];
    // 设置头部背景视图对象 的 图片显示方式 为 可缩放的
    _topBackground.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topBackground];
    
}
- (void)initData {
    // 背景图片的数据
    UIImage *bgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pb3.pstatp.com/obj/dbc1001cd29ccc479f7f"]]];
    _topBackground.image = bgImage;
}
@end
