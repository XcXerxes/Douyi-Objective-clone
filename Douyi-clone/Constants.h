//
//  Constants.h
//  Douyi-clone
//
//  Created by xiacan on 2018/11/10.
//  Copyright © 2018 Antony x. All rights reserved.
//


#ifndef Constants_h
#define Constants_h

//size
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define SafeAreaTopHeight ((ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]) ? 88 : 64

#define ScreenFrame [UIScreen mainScreen].bounds

// color
#define ColorClear [UIColor clearColor]
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define ColorThemeBackground RGBA(14.0, 15.0, 26.0, 1.0)
#define ColorWhite [UIColor whiteColor]


#endif /* Constants_h */
