//
//  NetworkHelper.m
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "NetworkHelper.h"

// 设置网络状态变化消息
NSString *const NetworkStatesChangeNotification = @"NetworkStatesChangeNotification";
// 接口地址的 主域
NSString *const NetworkDomain = @"com.start.douyin";

// 接口地址的 基础地址
NSString *const BaseUrl = @"http://116.62.9.17:8080/douyin/";

// 创建访客用户的接口地址
NSString *const CreateVisitorPath = @"visitor/create";

// 根据用户 id 获取用户信息的接口地址
NSString *const FindUserByUidPath = @"user";

// 获取视频列表 接口地址
NSString *const FindAwemePostByPagePath = @"aweme/post";

// 获取喜欢的视频列表 接口地址
NSString *const FindAwemeFavoriteByPagePath = @"aweme/favorite";

@implementation NetworkHelper

+ (AFHTTPSessionManager *)sharedManager {
    // 定义静态的属性
    // 使用 dispatch_one 创建单例模式 是为了 保证线程的安全
    static dispatch_once_t once;
    static AFHTTPSessionManager *manager;
    dispatch_once(&once, ^{
        // 创建网络连接对象 单例对象
        manager = [AFHTTPSessionManager manager];
        // 设置 超时 时间
        manager.requestSerializer.timeoutInterval = 15.0f;
    });
    return manager;
}

// 处理 返回值
// 参数1: 返回的对象
// 参数2: 成功的回调
// 参数3: 失败的回调
+(void) processResponseData:(id)responseObject success:(HttpSuccess)success failure:(HttpFailure)failure {
    NSInteger code = -1;
    NSString *message = @"response data error";
    // 判断返回的值 是否是字典
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        // 获取返回的信息
        NSDictionary *dic = (NSDictionary *)responseObject;
        // 获取 后端返回的code  同时转换为 int 类型
        code = [(NSNumber *)[dic objectForKey:@"code"] integerValue];
        // 获取 后端返回的 message
        message = [dic objectForKey:@"message"];
    }
    if (code == 0) {
        // 如果成功，传递成功的消息
        success(responseObject);
    } else {
        // 初始化失败的 userInfo 内容
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:NetworkDomain code:HttpRequestFailed userInfo:userInfo];
        // 传递失败的 消息
        failure(error);
    }
}

+ (NSURLSessionDataTask *)getWithUrlPath:(NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure {
    // 将请求的参数转换为 字典
    NSDictionary *parameters = [request toDictionary];
    // 返回一个dataTask 可用于下次的执行
    // 参数1: get请求的 url，包含基础 的URL 和 当前接口的url
    // 参数2: get 请求的参数
    // 参数3: 下载时的 进度条 未实现
    // 参数4: 成功时的回调 同时里面 包含 服务端返回的数据
    // 参数5: 失败时的回调 同时包含错误 的信息
    return [[NetworkHelper sharedManager] GET:[BaseUrl stringByAppendingString:urlPath] parameters:parameters progress: nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetworkHelper processResponseData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果失败， 获取当前的网络状态
        AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
        // 如果是未连接到网络
        if (status == AFNetworkReachabilityStatusNotReachable) {
            failure(error);
            return ;
        }
        
        // 如果当前服务器无法响应时， 使用本地json数据
        // 获取发起请求时的 接口地址
        NSString *path = task.originalRequest.URL.path;
        // 如果接口地址是 获取用户信息
        if ([path containsString:FindUserByUidPath]) {
            // 返回 用户的 json 数据
            success([NetworkHelper readJson2DicWithFielName:@"user"]);
        } else if ([path containsString:FindAwemePostByPagePath]) {
            // 返回 视频列表
            success([NetworkHelper readJson2DicWithFielName:@"awemes"]);
        } else if ([path containsString:FindAwemeFavoriteByPagePath]) {
            // 返回 点赞数量
            success([NetworkHelper readJson2DicWithFielName:@"favorites"]);
        } else {
            failure(error);
        }
    }];
}

+ (NSURLSessionDataTask *)postWithUrlPath:(NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure {
    // 将 请求的参数转换为字典对象
    NSDictionary *parameters = [request toDictionary];
    // 返回一个 请求的 task 回调 用于下次的执行
    // 参数 跟 get 请求一样的！！！
    return [[NetworkHelper sharedManager] POST:[BaseUrl stringByAppendingString:urlPath] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 处理成功时 服务端返回的数据
        [NetworkHelper processResponseData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)deleteWithUrlPath:(NSString *)urlPath request:(BaseRequest *)request success:(HttpSuccess)success failure:(HttpFailure)failure {
    // 将请求参数转换为 字典对象
    NSDictionary *parameters = [request toDictionary];
    // 返回一个 请求的 task 回调， 用于 下次的再执行
    // 参数 跟 get 请求 一样的！！！
    return [[NetworkHelper sharedManager] DELETE:[BaseUrl stringByAppendingString:urlPath] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetworkHelper processResponseData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

// 根据本地的 json文件 转换为 字典对象
+(NSDictionary *)readJson2DicWithFielName:(NSString *)fileName {
    // 读取本地的 json 文件
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    // 通过路径 获取 二进制数据
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 将二进制文件数据 转换为 字典数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dic;
}

// 使用 dispatch_once 创建 单例， 保证线程安全
+ (AFNetworkReachabilityManager *)shareReachabilityManager {
    static dispatch_once_t once;
    static AFNetworkReachabilityManager *manager;
    // 使用 dispatch_once 创建 单例， 保证线程安全
    dispatch_once(&once, ^{
        // 创建单例
        manager = [AFNetworkReachabilityManager manager];
    });
    return manager;
}

// 获取网络状态
+ (AFNetworkReachabilityStatus *)networkStatus {
    AFNetworkReachabilityStatus *status = [NetworkHelper shareReachabilityManager].networkReachabilityStatus;
    return status;
}

// 判断网络状态 是否是未连接
+ (BOOL)isNotReachableStatus:(AFNetworkReachabilityStatus)status {
    return status == AFNetworkReachabilityStatusNotReachable;
}

@end
