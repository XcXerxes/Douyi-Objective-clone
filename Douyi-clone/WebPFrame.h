//
//  WebPFrame.h
//  Douyi-clone
//
//  Created by xiacan on 2018/11/19.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <webp/decode.h>
#import <webp/demux.h>
NS_ASSUME_NONNULL_BEGIN

@interface WebPFrame : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) WebPData webPData;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat has_alpha;
@end

NS_ASSUME_NONNULL_END
