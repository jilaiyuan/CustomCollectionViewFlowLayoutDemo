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
        // initial property
        self.columnCount = 1;
        self.rowCount = 1;
        self.shouldKeepAspectRatio = NO;
        self.aspectRatio = 1.f / 2.f;
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
    NSInteger itemCountInPage = self.rowCount * self.columnCount;
    NSInteger remainder = itemTotalCount % itemCountInPage;
    NSInteger pageNumber = itemTotalCount / itemCountInPage;
    if (itemTotalCount <= itemCountInPage)
    {
        pageNumber = 1;
    }
    else
    {
        if (remainder == 0)
        {
            pageNumber = pageNumber;
        }
        else
        {
            pageNumber = pageNumber + 1;
        }
    }
    
    BOOL scrollHorizontal = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal);
    CGFloat width = pageNumber * (scrollHorizontal ? self.collectionView.bounds.size.width : self.collectionView.bounds.size.height);
    
    if (scrollHorizontal)
        return CGSizeMake(width, 150);
    else
        return CGSizeMake(150, width);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = [self getItemSize];
    
    NSInteger item = indexPath.item;
    NSInteger pageNumber = item / (self.rowCount * self.columnCount);
    
    NSInteger x = (item % self.columnCount + pageNumber * self.columnCount) % self.columnCount;
    NSInteger y = (item / self.columnCount - pageNumber * self.rowCount) % self.rowCount;
    
    BOOL scrollHorizontal = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal);
    
    CGFloat itemX = (scrollHorizontal ? pageNumber * self.collectionView.bounds.size.width : 0)  + self.sectionInset.left + (itemSize.width + self.minimumInteritemSpacing) * x;
    
    CGFloat itemY = (scrollHorizontal ? 0 : pageNumber * self.collectionView.bounds.size.height)  + self.sectionInset.top + (itemSize.height + self.minimumLineSpacing) * y;
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    attributes.frame = CGRectMake(itemX, itemY, itemSize.width, itemSize.height);
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArrayM;
}

- (CGSize)getItemSize
{
    CGFloat itemWidth = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1)  * self.minimumInteritemSpacing) / self.columnCount;
    CGFloat itemHeight = (self.collectionView.frame.size.height - self.sectionInset.top - self.sectionInset.bottom - (self.rowCount - 1) * self.minimumLineSpacing) / self.rowCount;
    
    if (self.shouldKeepAspectRatio)
        itemHeight = itemWidth / self.aspectRatio;
    
    return CGSizeMake(itemWidth, itemHeight);
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
