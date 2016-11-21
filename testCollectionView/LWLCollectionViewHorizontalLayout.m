//
//  DDCollectionViewHorizontalLayout.m
//  TestCollectionView
//
//  Created by 刘卫林 on 15/08/27.

#import"LWLCollectionViewHorizontalLayout.h"

@interface LWLCollectionViewHorizontalLayout ()

@property (strong, nonatomic) NSMutableArray *allAttributes;

@end

@implementation LWLCollectionViewHorizontalLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.allAttributes = [NSMutableArray array];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger item = indexPath.item;
    NSUInteger x, y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtx:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *tmp = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y {
    NSUInteger page = item / (self.itemCountPerRow * self.rowCount);
    *x = item % self.itemCountPerRow + page * self.itemCountPerRow;
    *y = item / self.itemCountPerRow - page * self.rowCount;
}

// 根据偏移量计算item
- (NSUInteger)originItemAtx:(NSUInteger)x
                          y:(NSUInteger)y {
    NSUInteger item = x * self.rowCount + y;
    return item;
}

@end
