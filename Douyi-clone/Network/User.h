//
//  User.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "BaseModel.h"

// 自定义 头像类
@class Avatar;

NS_ASSUME_NONNULL_BEGIN

@interface User : BaseModel
// 用户名称
@property (nonatomic, copy) NSString *nickname;
// 抖音号
@property (nonatomic, copy) NSString *short_id;
// 性别
@property (nonatomic, assign) NSInteger gender;
// 获赞
@property (nonatomic, assign) NSInteger total_favorited;
// 关注
@property (nonatomic, assign) NSInteger following_count;
// 粉丝
@property (nonatomic, assign) NSInteger follower_count;
// 个性签名
@property (nonatomic, copy) NSString *signature;
// 头像图片地址
@property (nonatomic, copy) NSString *avatar_uri;

// 头像类
@property (nonatomic, strong) Avatar *avatar_medium;

@end

@interface Avatar : BaseModel
@property (nonatomic, copy) NSArray<NSString *> *url_list;
@property (nonatomic, copy) NSString *uri;
@end

NS_ASSUME_NONNULL_END
