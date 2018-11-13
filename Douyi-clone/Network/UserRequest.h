//
//  UserRequest.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserRequest : BaseRequest
@property (nonatomic, copy) NSString *uid;
@end

NS_ASSUME_NONNULL_END
