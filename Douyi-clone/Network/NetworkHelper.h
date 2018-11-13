//
//  NetworkHelper.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "Constants.h"

#import "BaseRequest.h"
#import "UserRequest.h"

#import "BaseResponse.h"
#import "UserResponse.h"

// 定义全局的属性

// network state notification (状态消息)
extern NSString *const NetworkStatesChangeNotification;

extern NSString *const NetworkDomain;

// 请求的基础 地址
extern NSString *const BaseUrl;

// 创建访客用户接口
extern NSString *const CreateVisitorPath;

// 根据用户 id 获取用户信息的 URL
extern NSString *const FindUserByUidPath;

// 获取用户发布的 短视频 列表数据 URL
extern NSString *const FindAwemePostByPagePath;

// 获取用户喜欢的短视频列表数据 URL
extern NSString *const FindAwemeFavoriteByPagePath;

// 定义失败的 状态 code
typedef enum {
    HttpRequestFailed = -1000
} NetworkError;
// 定义 成功的回调 和失败的回调
typedef void (HttpSuccess)(id data);
typedef void (HttpFailure)(NSError *error);


NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

// 定义类的方法
// 创建 http 的 连接管理对象

+(AFHTTPSessionManager *)sharedManager;

// 定义类的方法
// 所有的 通过 GET 请求的 公共调用
+(NSURLSessionDataTask *)getWithUrlPath: (NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure;

// 定义类的方法
// 所有通过 DELETE 请求的 公共调用
+(NSURLSessionDataTask *)deleteWithUrlPath: (NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure;

// 定义类的方法
// 所有通过 上传 请求 的 公共调用

// 定义类的方法
// 所有通过 POST 请求的 公共调用
+(NSURLSessionDataTask *)postWithUrlPath: (NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure;

// 获取网络监听 类
+(AFNetworkReachabilityManager *)shareReachabilityManager;

// 开始监听
+ (void)startListening;

// 获取网络状态
+(AFNetworkReachabilityStatus *)networkStatus;

// 没网络状态
+(BOOL)isNotReachableStatus:(AFNetworkReachabilityStatus)status;
//
@end

NS_ASSUME_NONNULL_END
