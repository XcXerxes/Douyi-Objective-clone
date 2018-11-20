//
//  HoverViewFlowLayout.m
//  Douyi-clone
//
//  Created by Antony x on 2018/11/20.
//  Copyright © 2018年 Antony x. All rights reserved.
//

#import "HoverViewFlowLayout.h"

@implementation HoverViewFlowLayout
- (instancetype)initWithTopHeight:(CGFloat)height {
    self = [super init];
    if (self) {
        self.topHeight = height;
    }
    return self;
}

// 重写 布局容器的方法
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 获取当前在屏幕 rect 中显示的元素属性
    NSMutableArray<UICollectionViewLayoutAttributes *> *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    // 移除掉所有 Header 和 Footer 类型的元素， 因为抖音个人主页中只有 第一个 section 包含Header 和 Footer 类型画元素
    // 即移除需要固定的 Header和Footer, 后续单独添加， 避免重复处理
    for (UICollectionViewLayoutAttributes *attributes in [superArray mutableCopy]) {
        // section 的了下 是 header 就移除掉
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [superArray removeObject:attributes];
        }
    }
    // 单独添加上一步移除的Header 和 Footer, 单独添加原因是因为 第一步 只能获取当前在屏幕 rect 中显示的元素属性， 当第一个 Section 移除屏幕后， 便无法获取Header和Footer. 这是需要单独添加Header和Footer以及第二部单独移除Header和Footer的原因。
    [superArray addObject:[super layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    // 循环当前获取的元素
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        // 判断是否是第一个section
        NSLog(@"输出section 的 索引=========%ld", attributes.indexPath.section);
        if(attributes.indexPath.section == 0) {
            // 判断是否是Header 类型
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                // 获取Header 的位置大小
                CGRect rect = attributes.frame;
                NSLog(@"topHeight是======%f", self.topHeight);
                NSLog(@"offsetY=========%f", self.collectionView.contentOffset.y);
                // 判断Header的 bottom 是否g滑动到导航栏的下方
                if (self.collectionView.contentOffset.y + self.topHeight - rect.size.height > rect.origin.y) {
                    rect.origin.y = self.collectionView.contentOffset.y + self.topHeight - rect.size.height;
                    NSLog(@"%f", rect.origin.y);
                    attributes.frame = rect;
                }
                attributes.zIndex = 5;
            }
        }
    }
    return [superArray copy];
}
// 修改newBounds 内部的元素属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
