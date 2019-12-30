//
//  CustomCollectionViewFlowLayout.m
//  CustomCollectionViewFlowLayoutDemo
//
//  Created by Admin on 2019/12/27.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import "CustomCollectionViewFlowLayout.h"

@implementation CustomCollectionViewFlowLayout
{
    NSMutableArray *_attributesArrayM;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (self.attributesArrayM && self.attributesArrayM.count > 0) {
        [self.attributesArrayM removeAllObjects];
    }
    
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < itemTotalCount; i++)
    {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attributesArrayM addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger itemTotalCount = [self.collectionView numberOfItemsInSection:0];
    BOOL scrollHorizontal = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal);
    BOOL pageEnabled = self.collectionView.pagingEnabled;
    NSInteger totalUnits = 0;//pageEnabled = YES: page; pageEnabled = NO : row.
    NSInteger itemPreUnit = 0;//item in one row(pageEnabled = NO) or one page(pageEnabled = YES).
    if (pageEnabled)
        itemPreUnit = self.columnCount * self.rowCount;
    else
        itemPreUnit = scrollHorizontal ? self.rowCount : self.columnCount;
    
    totalUnits = itemTotalCount / itemPreUnit;
    if (itemTotalCount % itemPreUnit != 0)
        totalUnits += 1;

    CGSize itemSize = self.itemSize;
    if (scrollHorizontal)
    {
        CGFloat width = 0.f;
        if (pageEnabled)
            width = CGRectGetWidth(self.collectionView.bounds) * totalUnits;
        else
            width = self.sectionInset.left + totalUnits * itemSize.width + (totalUnits - 1) * self.minimumInteritemSpacing + self.sectionInset.right;
        return CGSizeMake(width, 150);
    }
    else
    {
        CGFloat height = 0.f;
        if (pageEnabled)
            height = CGRectGetHeight(self.collectionView.bounds) * totalUnits;
        else
            height = self.sectionInset.top + totalUnits * itemSize.height + (totalUnits - 1) * self.minimumLineSpacing + self.sectionInset.bottom;
        return CGSizeMake(150, height);
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL scrollHorizontal = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal);
    BOOL pageEnabled = self.collectionView.pagingEnabled;
    NSInteger item = indexPath.item;
    
    NSInteger pageNumber = pageEnabled ? item / (self.rowCount * self.columnCount) : 0;
    
    NSInteger x = item % (scrollHorizontal ? self.rowCount : self.columnCount);
    NSInteger y = item / (scrollHorizontal ? self.rowCount : self.columnCount);
    if (pageEnabled)
    {
        y %= (scrollHorizontal ? self.columnCount : self.rowCount);
    }
    if (scrollHorizontal)
    {
        NSInteger temp = x;
        x = y;
        y = temp;
    }
    
    CGFloat itemX = (scrollHorizontal ? pageNumber * self.collectionView.bounds.size.width :0) + self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing) * x;
    CGFloat itemY = (scrollHorizontal ? 0 : pageNumber * self.collectionView.bounds.size.height) + self.sectionInset.top + (self.itemSize.height + self.minimumLineSpacing) * y;

    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    attributes.frame = CGRectMake(itemX, itemY, self.itemSize.width, self.itemSize.height);
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArrayM;
}

- (NSMutableArray *)attributesArrayM
{
    if (!_attributesArrayM)
    {
        _attributesArrayM = [[NSMutableArray alloc] init];
    }
    
    return _attributesArrayM;
}

- (void)dealloc
{
    [_attributesArrayM release];
    
    [super dealloc];
}

@end
