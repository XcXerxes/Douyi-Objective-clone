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

// 头部控件的整体高度
#define kUserHeaderHeight    350 + SafeAreaTopHeight
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
UIScrollViewDelegate
>
// 定义用户头部 的类属性对象
@property (nonatomic, strong) UserHeader *userHeader;

@end

@implementation UserHomeController

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
}

// 初始化整个collectionView
- (void)initCollectionView {
    // 初始化 layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
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
    return 1;
}
// 返回每个单元格的 内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AwemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAwemeCollectionCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    NSLog(@"1111");
    return cell;
    
}

// 返回 头部控件的视图对象
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UserHeader *header = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserHeaderCell forIndexPath:indexPath];
    _userHeader = header;
    // 初始化 userHeader 的数据
    [header initData];
    return header;
}
// 返回头部控件 的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, kUserHeaderHeight);
}

// scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 垂直方向的 偏移值
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当下拉时 偏移值为 负
    if (offsetY < 0) {
        [_userHeader overScrollAction: offsetY];
    }
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
