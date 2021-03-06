//
//  ViewController.m
//  CustomCollectionViewFlowLayoutDemo
//
//  Created by Admin on 2019/12/27.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewFlowLayout.h"
#import "CustomCollectionViewCell.h"

#define ITEMMARGIN 32.f

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) CustomCollectionViewFlowLayout *layout;
@property (nonatomic, retain) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
}

- (void)initSubviews
{
    CustomCollectionViewFlowLayout *layout = [[CustomCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = ITEMMARGIN;
    layout.minimumLineSpacing = ITEMMARGIN;
    layout.sectionInset = UIEdgeInsetsMake(ITEMMARGIN, ITEMMARGIN, ITEMMARGIN, ITEMMARGIN);
    self.layout = layout;
    [layout release];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat x = 100, y = 100;
    CGRect rect = CGRectMake(x, y, width - 2*x, height - 2*y);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.layout];
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.scrollEnabled = YES;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCollectionViewCell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView release];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self resetLayoutAttributes];
}

- (void)resetLayoutAttributes
{
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
    NSInteger columnCount = isLandscape ? 4 : 3;
    NSInteger rowCount = isLandscape ? 3 : 4;
    self.layout.columnCount = columnCount;
    self.layout.rowCount = rowCount;
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - self.layout.sectionInset.left - self.layout.sectionInset.right - (columnCount - 1)  * self.layout.minimumInteritemSpacing) / columnCount;
    CGFloat itemHeight = (CGRectGetHeight(self.collectionView.frame) - self.layout.sectionInset.top - self.layout.sectionInset.bottom - (rowCount - 1) * self.layout.minimumLineSpacing) / rowCount;
    
    BOOL shouldKeepAspectRatio = YES;
    CGFloat aspectRatio = 4.f / 3.f;
    if (shouldKeepAspectRatio)
        itemHeight = itemWidth / aspectRatio;
    
    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 97;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewCell" forIndexPath:indexPath];
    
    [cell setCount:indexPath.row + 1];
    [cell setImage];
    
    return cell;
}

-(void)dealloc
{
    self.layout = nil;
    self.collectionView = nil;
    
    [super dealloc];
}


@end
