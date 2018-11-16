//
//  SlideTabBar.m
//  Douyi-clone
//
//  Created by Antony x on 2018/11/16.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "SlideTabBar.h"

// 定义类 内部的属性
@interface SlideTabBar()
// 定义slideTabBar 视图对象
@property (nonatomic, strong) UIView *slideLightView;
// 定义label
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
// 定义标题
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;

// 定义索引
@property (nonatomic, assign) NSInteger tabIndex;

// 定义每个tab 的宽度
@property (nonatomic, assign) CGFloat itemWidth;
@end

@implementation SlideTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        _labels = [NSMutableArray array];
        _titles = [NSMutableArray array];
    }
    return self;
}
// 布局子视图
- (void)layoutSubviews {
    [super layoutSubviews];
    if (_titles.count == 0) {
        return;
    }
    // 循环变量所有的子视图
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 删除所有的子视图
        [obj removeFromSuperview];
    }];
    // 清空数组
    [_labels removeAllObjects];
    // 设置当前tabItem 的宽度为1 等分
    CGFloat itemWidth = _itemWidth = ScreenWidth/_titles.count;
    // 循环变量 标题数组
    [_titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [UILabel new];
        label.text = title;
        label.textColor = ColorWhiteAlpha60;
        // 文字居中
        label.textAlignment = NSTextAlignmentCenter;
        label.font = BigFont;
        label.tag = idx;
        // 开启 事件处理
        label.userInteractionEnabled = YES;
        // 添加 事件处理函数
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction:)]];
        // 将 label 控件 添加到数组中
        [self.labels addObject:label];
        [self addSubview:label];
        
        label.frame = CGRectMake(idx*itemWidth, 0, itemWidth, self.bounds.size.height);
//        if (idx != self.titles.count - 1) {
//            UIView *spliteLine = [[UIView alloc] initWithFrame:CGRectMake((idx + 1)*itemWidth, 12.5f, .5f, self.bounds.size.height - 25.0f)];
//            spliteLine.backgroundColor = ColorWhiteAlpha20;
//            // zIndex
//            spliteLine.layer.zPosition = 10;
//            [self addSubview:spliteLine];
//        }
    }];
    _labels[_tabIndex].textColor = ColorWhite;
    NSLog(@"label======%@", _labels[_tabIndex]);
    _slideLightView = [UIView new];
    _slideLightView.backgroundColor = ColorThemeYellow;
    // 设置选择时的 样式
    _slideLightView.frame = CGRectMake(_tabIndex * itemWidth + 15, self.bounds.size.height - 2, itemWidth - 30, 2);
    [self addSubview:_slideLightView];
}

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex {
    // 清空原有的
    [_titles removeAllObjects];
    // 添加新的
    [_titles addObjectsFromArray:titles];
    _tabIndex = tabIndex;
}

-(void) onTapAction: (UITapGestureRecognizer *)sender {
    // 获取当前点击的 label 控件的 tag 值
    NSInteger index = sender.view.tag;
    if (index != _tabIndex) {
        if (_delegate) {
            // 创建动画函数
            // 参数1: 动画总时间
            // 参数2: 动画延时
            // 参数3: 动画摩擦力
            // 参数4: 弹簧动画的速率
            // 参数5: 动画的形式
            // 参数6: 动画的 区间函数
            // 参数7: 结束动画时 调用
            [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:1.8 initialSpringVelocity:.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                // 获取底部 slide 的位置大小
                CGRect frame = self.slideLightView.frame;
                // 让slide 随 x 坐标移动
                frame.origin.x = self.itemWidth * index + 15;
                [self.slideLightView setFrame:frame];
                
                // 通过循环遍历， 调整选中时 label 的颜色
                [self.labels enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
                    label.textColor = index == idx ? ColorWhite : ColorWhiteAlpha60;
                }];
            } completion:^(BOOL finished) {
                // 将新的 索引值 通过 协议 传递给代理对象
                [self.delegate onTabTapAction:index];
            }];
            _tabIndex = index;
        }
    }
}

@end
