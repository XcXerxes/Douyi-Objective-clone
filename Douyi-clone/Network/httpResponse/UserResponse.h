//
//  UserResponse.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "BaseResponse.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserResponse : BaseResponse
@property (nonatomic, copy) User *data;
@end

NS_ASSUME_NONNULL_END
