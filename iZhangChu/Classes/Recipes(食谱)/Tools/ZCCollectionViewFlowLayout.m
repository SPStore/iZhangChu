//
//  SPCollectionViewFlowLayout.m
//  CollectionView
//
//  Created by Libo on 2017/11/6.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCollectionViewFlowLayout.h"

/** 最大列数 */
static const NSInteger maxColumn = 5;
/** 每一列之间的间距 */
static const CGFloat columnPadding = 10;
/** 每一行之间的间距 */
static const CGFloat rowPadding = 10;
/** 边缘间距 */
static const UIEdgeInsets edgeInsets = {0, 10, 0, 10};

@interface ZCCollectionViewFlowLayout()
@property (nonatomic, strong) NSMutableArray *attrsArray;
// 上一区头的最大Y值
@property (nonatomic, assign) CGFloat lastHeaderMaxY;
// 上一个区尾的最大Y值
@property (nonatomic, assign) CGFloat lastFooterMaxY;;
// 上一个分区的最后一个cell的最大Y值
@property (nonatomic, assign) CGFloat LastSectionLastItemMaxY;
@end

@implementation ZCCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    // 获取分区总个数
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int j = 0; j < sectionCount; j++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:j];
        // 获取indexPath位置区头的布局属性
        UICollectionViewLayoutAttributes *headerAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [self.attrsArray addObject:headerAttrs];
        
        // 获取每个分区cell的个数
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < itemCount; i++) {
            // 创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            // 获取indexPath位置cell对应的布局属性
            UICollectionViewLayoutAttributes *itemAttrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:itemAttrs];
        }
        // 获取indexPath位置区尾的布局属性
        UICollectionViewLayoutAttributes *footerAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        [self.attrsArray addObject:footerAttrs];
        
        // 要注意布局属性的添加顺序，必须是先加header,再加cell,最后加footer顺序
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    // 该数组里装的是布局属性，包括cell、header、footer,方法会通过UICollectionViewLayoutAttributes的representedElementCategory属性判断是cell，header还是footer,representedElementCategory的意思就是谁的布局属性，取决于prepareLayout方法中所获取的布局属性来源
    return self.attrsArray;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性,注意是创建，不是获取
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    // 计算好第一个cell和其余cell的宽高
    CGFloat otherCellWidth = (collectionViewW-edgeInsets.left-edgeInsets.right-(maxColumn-1)*columnPadding)/maxColumn;
    CGFloat otherCellHeight = otherCellWidth * 2 / 3;
    
    CGFloat firstCellSizeWidth = otherCellWidth*2+columnPadding;
    CGFloat firstCellSizeHeight = otherCellHeight*2+rowPadding;
    
    CGFloat cellW = 0;
    CGFloat cellH = 0;
    CGFloat cellX = 0;
    CGFloat cellY = 0;
    if (indexPath.item == 0) {
        cellW = firstCellSizeWidth;
        cellH = firstCellSizeHeight;
        cellX = edgeInsets.left;
        cellY = _lastHeaderMaxY;
    } else {
        cellW = otherCellWidth;
        cellH = otherCellHeight;
        // 前2行除去第一个cell,剩余的空间可排布的cell的个数
        // 第一个2是第一个cell占据的列数(2列),第二个2是行数(2行),1是指第一个cell
        NSInteger countBefore2Rows = (maxColumn-2)*2+1;
        if (indexPath.item < countBefore2Rows) {
            NSInteger maxCol = maxColumn-2; // 此时,除去第一个cell之外,最大列数比全局最大列数少2列，这2列就是第一个cell占据的列数
            NSInteger col = (indexPath.item-1) % maxCol;  // 第几列
            NSInteger row = (indexPath.item-1) / maxCol;  // 第几行
            cellX = edgeInsets.left + firstCellSizeWidth + columnPadding + col * (cellW+columnPadding);
            cellY = _lastHeaderMaxY+(otherCellHeight+rowPadding)*row;
        } else {
            NSInteger col = (indexPath.item-countBefore2Rows) % maxColumn;  // 第几列
            NSInteger row = (indexPath.item-countBefore2Rows) / maxColumn;  // 第几行
            cellX = edgeInsets.left + (otherCellWidth+columnPadding) * col;
            cellY = _lastHeaderMaxY+firstCellSizeHeight+rowPadding+(otherCellHeight+rowPadding)*row;
        }
    }
    
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:indexPath.section];
    // 第一行能排布的cell的个数
    // 第一个2是第一个cell占据的列数(2列),第二个2是行数(2行),第三个2是一半,1是指第一个cell
    NSInteger countAtFirstRow = (maxColumn-2)*2/2+1;
    if (numberOfItems <= countAtFirstRow) { // 说明只有一行
        if (indexPath.item == 0) { // 在只有一行的情况下，最大Y值以第一个cell为准，因为第一个cell是最高的
            _LastSectionLastItemMaxY = CGRectGetMaxY(attrs.frame);
        }
    } else {
        if (indexPath.item == numberOfItems-1) { // 纪录最后一个item的最大Y值
            _LastSectionLastItemMaxY = CGRectGetMaxY(attrs.frame);
        }
    }
    return attrs;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section != [self.collectionView numberOfSections]) {
            if (indexPath.section == 0) {
                attrs.frame = CGRectMake(0, edgeInsets.top+_lastFooterMaxY, self.collectionView.frame.size.width, 50);
            } else {
                attrs.frame = CGRectMake(0, _lastFooterMaxY, self.collectionView.frame.size.width, 50);
            }
            _lastHeaderMaxY = CGRectGetMaxY(attrs.frame);
        }
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        attrs.frame = CGRectMake(0, _LastSectionLastItemMaxY+rowPadding, self.collectionView.frame.size.width, 10);
        _lastFooterMaxY = CGRectGetMaxY(attrs.frame);
    }
    return attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, _lastFooterMaxY+edgeInsets.bottom);
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

@end

