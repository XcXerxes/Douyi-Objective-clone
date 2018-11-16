//
//  AwemeListRequest.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/16.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AwemeListRequest : BaseRequest
// 定义请求参数的 分页的 当前页数
@property (nonatomic, assign) NSInteger page;
// 定义请求参数的 分页的 每页的个数
@property (nonatomic, assign) NSInteger size;
// 定义请求参数的 uid
@property (nonatomic, copy) NSString *uid;
@end

NS_ASSUME_NONNULL_END
