//
//  BaseResponse.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/13.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseResponse : JSONModel
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSInteger has_more;
@property (nonatomic, assign) NSInteger total_count;
@end

NS_ASSUME_NONNULL_END
