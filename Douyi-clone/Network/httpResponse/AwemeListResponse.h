//
//  AwemeListResponse.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/16.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "BaseResponse.h"
#import "Aweme.h"

NS_ASSUME_NONNULL_BEGIN

@interface AwemeListResponse : BaseResponse
@property (nonatomic, copy) NSArray<Aweme *> *data;
@end

NS_ASSUME_NONNULL_END
