//
//  WebPImage.h
//  Douyi-clone
//
//  Created by Antony x on 2018/11/17.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <webp/mux_types.h>
#import "WebPFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebPImage : UIImage
@property (nonatomic, strong) WebPFrame *curDisplayFrame;
@property (nonatomic, copy) NSData  *imageData;
@property (nonatomic, strong) UIImage *curDisplayImage;
@property (nonatomic, assign) NSInteger curDisplayIndex;
@property (nonatomic, assign) NSInteger curDecodeIndex;
@property (nonatomic, assign) NSInteger frameCount;
@property (nonatomic, strong) NSMutableArray<WebPFrame *> *frames;

- (CGFloat)curDisplayFrameDuration;
- (WebPFrame *)decodeCurFrame;
- (void)incrementCurDisplayIndex;
- (BOOL)isAllFrameDecoded;
@end

NS_ASSUME_NONNULL_END
