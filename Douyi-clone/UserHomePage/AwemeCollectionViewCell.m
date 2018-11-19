//
//  AwemeCollectionViewCell.m
//  Douyi-clone
//
//  Created by Antony x on 2018/11/12.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "AwemeCollectionViewCell.h"

#import "Aweme.h"
#import "Constants.h"

@implementation AwemeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _view = [UIView new];
        _view.backgroundColor = ColorThemeRed;
        _view.layer.cornerRadius = 10;
    }
    return self;
}

- (void)initData:(Aweme *)aweme {
    
}
@end
