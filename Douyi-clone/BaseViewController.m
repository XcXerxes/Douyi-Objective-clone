//
//  BaseViewController.m
//  Douyi-clone
//
//  Created by xiacan on 2018/11/10.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)initNavigationBarTransparent {
    [self setNavigationBarTitleColor:ColorWhite];
    [self setNavigationBarBackgroundImage:[UIImage new]];
    [self setBackgroundColor:ColorThemeBackground];
    [self setStatusBarStyle:UIBarStyleBlack];
    [self initLeftBarButton:@"icon_titlebar_whiteback.png"];
}

- (void)setTranslucentCover {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualView.frame = self.view.bounds;
    visualView.alpha = 1;
    [self.view addSubview:visualView];
}
- (void)setBackgroundColor:(UIColor *)color {
    self.view.backgroundColor = color;
}

- (void)initLeftBarButton:(NSString *)imageName {
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    leftBtn.tintColor = ColorWhite;
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)setStatusBarHidden:(BOOL)hidden {
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
- (void)setNavigationBarTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void)setNavigationBarTitleColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: color}];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color {
    [self.navigationController.navigationBar setBackgroundColor:color];
}

- (void)setStatusBarStyle:(UIBarStyle)style {
    self.navigationController.navigationBar.barStyle = style;
}
- (void)setNavigationBarBackgroundImage:(UIImage *)image {
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self initNavigationBarTransparent];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
