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
        success(responseObject)
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:message forKeys:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:NetworkDomain code:HttpResqu userInfo:userInfo];
    }
}
@end
