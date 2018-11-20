//
//  UserHomeController.m
//  Douyi-clone
//
//  Created by xiacan on 2018/11/10.
//  Copyright © 2018 Antony x. All rights reserved.
//

#import "UserHomeController.h"
#import "UserHeader.h"
#import "AwemeCollectionViewCell.h"
#import "HoverViewFlowLayout.h"

#import "User.h"
#import "NetworkHelper.h"

// 头部控件的整体高度
#define kUserHeaderHeight    (int) (350+SafeAreaTopHeight)
// tabBar 的 高度
#define kSlideTabBarHeight   40

// 定义 头部控件 的 字符 id
NSString * const kUserHeaderCell = @"USerHeaderCell";
// 定义 单元格 的字符 id
NSString * const kAwemeCollectionCell  = @"AwemeCollectionCell";

@interface UserHomeController ()
// 定义 collection 的基本协议和数据协议
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate,
slideTabBarOnTabActionDelegate
>

// 定义 用户请求的 uid
@property (nonatomic, copy) NSString *uid;
// 定义用户头部 的类属性对象
@property (nonatomic, strong) UserHeader *userHeader;

// 定义User 数据模型
@property (nonatomic, strong)User *user;

@property (nonatomic, copy) NSMutableArray<UIView *> *awemeList;
@end

@implementation UserHomeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _uid = @"97795069353";
        _awemeList = [NSMutableArray array];
        [self loadList];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航 的 标题颜色
    [self setNavigationBarTitleColor:ColorClear];
    // 设置导航的 背景颜色
    [self setNavigationBarBackgroundColor:ColorClear];
    // 设置状态栏的背景颜色
    [self setStatusBarBackgroundColor:ColorClear];
    [self setStatusBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抖音";
    // Do any additional setup after loading the view.
    [self initCollectionView];
    
    // 初始化 加载 用户数据
    [self fetchUserData];
    // 使用通知中心 加载数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onNetworkStatusChange:) name:NetworkStatesChangeNotification object:nil];
}

// 初始化整个collectionView
- (void)initCollectionView {
    // 初始化 layout
    HoverViewFlowLayout *layout = [[HoverViewFlowLayout alloc] initWithTopHeight:SafeAreaTopHeight + kSlideTabBarHeight];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    // 初始化 collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:ScreenFrame collectionViewLayout: layout];
    _collectionView.backgroundColor = ColorClear;
    
    // 适配 ios11 的头部样式问题
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 弹性滚动效果
    _collectionView.alwaysBounceVertical = YES;
    // 显示滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    // 设置代理协议
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册 collection 的 头部组件
    [_collectionView registerClass:[UserHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserHeaderCell];
    
    // 注册collection 单元格
    [_collectionView registerClass:[AwemeCollectionViewCell class] forCellWithReuseIdentifier:kAwemeCollectionCell];
    // 插入 clllection 对象
    [self.view addSubview:_collectionView];
}


// UICollectionViewDataSource Delegate
// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 返回个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _awemeList.count;
}
-(void)loadList {
    for (int i = 0; i < 15; i ++) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(i * ScreenWidth / 3, i * 180, ScreenWidth / 3, 170);
        [_awemeList addObject:view];
    }
}
// 设置单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth / 3 - 10, 170);
}
// 返回每个单元格的 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AwemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAwemeCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = (indexPath.item % 2) ? ColorThemeRed : ColorThemeYellow;
    return cell;
}

// 返回 头部控件的视图对象
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UserHeader *header = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserHeaderCell forIndexPath:indexPath];
    _userHeader = header;
    // 初始化 userHeader 的数据
    if (_user) {
        [header initData:_user];
        header.slideTabBar.delegate = self;
    }
    return header;
}
// 返回头部控件 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    // 获取安全头部的高度
    float f = SafeAreaTopHeight;
    // 设置 整体头部的高度
    return CGSizeMake(ScreenWidth, 350 + f);
}

// scrollView delegate
// 滚动结束时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 垂直方向的 偏移值
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当下拉时 偏移值为 负
    if (offsetY < 0) {
        [_userHeader overScrollAction: offsetY];
    } else {
        // 上推
        [_userHeader scrollToTopAction:offsetY];
        [self  updateNavigationTitle:offsetY];
    }
}

// 更新导航控制器样式
-(void)updateNavigationTitle:(CGFloat)offsetY {
    if (kUserHeaderHeight - [self navigationBarHeight] *2 >= offsetY) {
        [self setNavigationBarTitleColor:ColorClear];
    }
    if (kUserHeaderHeight - [self navigationBarHeight] *2 < offsetY && offsetY < kUserHeaderHeight - [self navigationBarHeight]) {
        CGFloat alphaRatio = 1.0f - (kUserHeaderHeight - [self navigationBarHeight] - offsetY)/[self navigationBarHeight];
        [self setNavigationBarTitleColor:[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:alphaRatio]];
    }
    if (offsetY > kUserHeaderHeight - [self navigationBarHeight]) {
        [self setNavigationBarTitleColor:ColorWhite];
    }
}

// 返回导航控制器的高度
-(CGFloat) navigationBarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}

// 网络状态发生变化
-(void) onNetworkStatusChange:(NSNotification *)notification {
    // 如果没有网络
    NSLog(@"ccccc");
    if (![NetworkHelper isNotReachableStatus:*[NetworkHelper networkStatus]]) {
        if (_user == nil) {
            // 加载用户信息
            [self fetchUserData];
        }
    }
}

// 获取 用户信息
- (void)fetchUserData {
    // 防止 嵌套依赖
    __weak typeof (self) wself = self;
    // 初始化 用户request 对象
    UserRequest *request = [UserRequest new];
    // 给用户 request 对象 赋值 uid
    request.uid = _uid;
    // 通过get 请求 获取 用户信息
    // 参数1: 请求地址 ， 参数通过 全局定义获得
    // 参数2: 请求的参数类  这里是 用户 request 对象类
    // 参数3: 成功的回调， 返回 responseObject
    // 参数4： 失败的回调
    [NetworkHelper getWithUrlPath:FindUserByUidPath request:request success: ^(id data) {
        // 初始化 用户 返回值 对象
        UserResponse *response = [[UserResponse alloc] initWithDictionary:data error:nil];
        // 将返回的 数据 赋值给 user 模型
        wself.user = response.data;
        // 设置 导航控制器 的标题 为 用户的名称
        [wself setTitle:self.user.nickname];
        // 重新渲染
        [wself.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure: ^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

// slideTabBar delegate
- (void)onTabTapAction:(NSInteger)index {
    NSLog(@"index=======%ld", index);
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
